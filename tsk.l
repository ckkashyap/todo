
(de may () T)

    (action
(html 0 Ttl "@lib.css" NIL
        (idForm "Edit updates" '(choTmp) 'nr '+Update T '(may Delete) '((: nr))
            (gui '(+Set +E/R +Chart) '((L) (filter bool L)) '(upds .  *ID)  3
                '( (U I) (with U (list (: dsc) (: dt) (: tm) ) ))  
                '( (L D) 
                    (cond
                       (D
                            (mapc 
                                '( (K V) (put!> D K V))
                                '(dsc dt tm)
                                L
                            )
                            D
                       )
                       ((car A)
                           (new! '(+Update) 'dsc (car A))
                       )
                    )
                 )
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
