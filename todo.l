(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(class +Task +Entity)
(rel nr (+Need +Key +Number))
(rel ttl (+IdxFold +String))
(rel sts (+Sn +IdxFold +String))
(rel tgs (+Sn +IdxFold +String))
(rel dt (+Need +Ref +Date))
(rel upds (+List +Joint) tsk (+Update))

(dm url> (Tab)
  (and (list "tsk.l" '*ID This)) )

(class +Update +Entity)
(rel tsk (+Joint) upds (+Task) )
(rel dsc (+Sn +IdxFold +String))            
(rel dt (+Need +Ref +Date))
(rel tm (+Need +Ref +Time))

(setq *Rows 3)

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
                             @Nr NIL
                             (select (@@)
                                 ( (nr +Task @Nr) )
                             ) 
                          ) 
                      )
                      3
                     '((This) (list This (: sts) (: ttl)))
                 )
        
                 (<table> NIL (choTtl "Entries" '+Task)
                     (quote
                        ("em20 align" "C1")
                        ("em20 align" "C2")
                        ("em20 align" "C3")
                     )
        
                     (do *Rows
                         (<row> NIL
                             (gui 1 '(+ObjView +TextField) '(: ttl))
                             (gui 2 '(+View +TextField))
                             (gui 3 '(+View +TextField))
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
