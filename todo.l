(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(class +Task +Entity)               # starts the entity definition
(rel nr     (+Need +Key +Number))   # defines a key, needed collect/query
(rel nm     (+Sn +IdxFold +String)) # task name
(rel tags   (+Sn +IdxFold +String)) # tags
(rel status (+Ref +String))         # task status
(rel due    (+Ref +Date))           # task due date

(de ui-main ()
    (app)
    (action
        (html 0 Ttl "@lib.css" NIL
            (form NIL
                (<grid> "----."
                    "Name" (gui 'nm '(+DbHint +TextField) '(nm +Task) 20)
                    "Tags" (gui 'tags '(+DbHint +TextField) '(tags +Task) 20)
                    (searchButton '(init> (: home query)))
                )
                (gui 'query '(+QueryChart) 5
                    '(goal
                        (quote
                            @Nm (val> (: home nm)) 
                            @Tg (val> (: home tags)) 
                            (select (@@)
                                ((nm +Task @Nm) (tags +Task @Tg))
	    	    	            (tolr @Nm @@ nm)
	    	    	            (part @Tg @@ tags)
                            ) 
                         ) 
                     )
                     5
                    '((This) (list (: nm) (: status) (: tags) (: due)))
                    '((L D)
                        (cond
                            (D
                                (mapc
                                    '((K V) (put!> D K V))
                                    '(nm status tags due)
                                    L
                                )
                                D
                            )
                            ((car L)
                                (new! '(+Task) 'nm (car L))
                            )
                        )   
                    )
                )

                (<table> NIL (choTtl "Entries" '+Task)
                    (quote
                       (NIL "Name")
                       (NIL "Status")
                       (NIL "Tags")
                       (NIL "Due")
                    )

                    (do 5
                        (<row> NIL
                            (gui 1 '(+TextField) 30)
                            (gui 2 '(+DbHint +TextField)  '(status +Task) 10)
                            (gui 3 '(+TextField) 40)
                            (gui 4 '(+DateField) 20)
                            (gui 5 '(+DelRowButton)
                                '(lose!> (curr))
                                '(text "Delete Entry @1?" (curr 'nm))
                            )
                        )
                    )
                ) 
                (scroll 5)
            )
        )
    )
)

(de main ()
    (pool "dingo.db")
)

(de go ()
    (rollback)
    (server 8080 "!ui-main")
)
