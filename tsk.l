
(de may () T)

    (action
(html 0 Ttl "@lib.css" NIL
        (idForm "Edit updates" '(choTmp) 'nr '+Update T '(may Delete) '((: nr))
            (gui '(+Set +E/R +Chart) '((L) (filter bool L)) '(upds .  *ID)  3
                '( (U I) (with U (list (: dsc) (: dt) (: tm) ) ))  
                '( (A B) (put!> B 'dsc (car A)) (put!> B 'dt (cadr A)) (put!> B 'dt (cadr A)) B )
            )
            (<table> 'chart NIL
                '(("em7" "Updates") ("em7" "Date") ("em7" "Time") )
                (do 4
                    (<row> (alternating)
                        (gui 1 '(+TextField) 100) 
                        (gui 2 '(+DateField) 100) 
                        (gui 3 '(+TimeField) 100) 
                    )
                 )
             )
             (scroll 4)
        )
    )
)


(de choTmp (X)
    (out "+/tmp/dummy.txt"  (prinl X)))
