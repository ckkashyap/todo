(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(class +Task +Entity)               # starts the entity definition
(rel nr     (+Need +Key +Number))   # defines a key, needed collect/query
(rel nm     (+Sn +IdxFold +String)) # task name
(rel tgs    (+Sn +IdxFold +String)) # tags
(rel sts    (+Ref +Sn +String))     # task status
(rel due    (+Ref +Date))           # task due date

(setq *Rows 10)

(de ui-main ()
    (app)
    (action
        (html 0 Ttl "@lib.css" NIL
            (form NIL
                (<grid> "------."
                    "Name" (gui 'nm '(+DbHint +TextField) '(nm +Task) 20)
                    "Status" (gui 'sts '(+DbHint +TextField) '(sts +Task) 20)
                    "Tags" (gui 'tgs '(+DbHint +TextField) '(tgs +Task) 20)
                    (searchButton '(init> (: home query)))
                )
                (gui 'query '(+QueryChart) *Rows
                    '(goal
                        (quote
                            @Nm (val> (: home nm))
                            @Tg (val> (: home tgs))
                            @St (val> (: home sts))
                            (select (@@)
                                ((nm +Task @Nm) (tgs +Task @Tg) (sts +Task @St))
                                (tolr @Nm @@ nm)
                                (tolr @St @@ sts)
                                (part @Tg @@ tgs)
                            ) 
                         ) 
                     )
                     5
                    '((This) (list (: nm) (: sts) (: tgs) (: due)))
                    '((L D)
                        (cond
                            (D
                                (mapc
                                    '((K V) (put!> D K V))
                                    '(nm sts tgs due)
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

                    (do *Rows
                        (<row> NIL
                            (gui 1 '(+TextField) 30)
                            (gui 2 '(+DbHint +TextField)  '(sts +Task) 10)
                            (gui 3 '(+TextField) 40)
                            (gui 4 '(+DateField) 20)
                            (gui 5 '(+DelRowButton)
                                '(lose!> (curr))
                                '(text "Delete Entry @1?" (curr 'nm))
                            )
                        )
                    )
                ) 
                (scroll *Rows)
            )
        )
    )
)

(de main ()
    (pool "tasks.db")
)

(de go ()
    (rollback)
    (server 8080 "!ui-main")
)
