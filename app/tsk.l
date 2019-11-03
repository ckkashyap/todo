(menu "Tasks"
   (idForm ,"Tasks" '(choTsk) 'nr '+Tsk T '(may Delete) '((: nr))
      (--)
      (<grid> 2
         "Title" (gui '(+E/R +Cue +TextField) '(ttl : home obj) "Name" 40)
         "Due" (gui '(+E/R +DateField) '(dt : home obj) 40) 
         "Status" (gui '(+E/R +TextField) '(sts : home obj) 40) 

         "Update" (gui '(+TextField) 60 2)
         (gui '(+Button) "Update"
              '(put!> (: home obj) 'upds (new! '(+Update) 'dsc (val> (field -1)) 'dt (date) 'tm (time) ) ) )  )
      (--)

      (gui '(+Set +E/R +Chart) '((L) (filter bool L)) '(upds : home obj) 3
        '( (U I) (with U (list (: dsc) (: dt) (: tm) )) ) )
      (<table> 'chart NIL
         '((NIL "Updates") ("em7" "Date") ("em7" "Time") )
         (do 6
            (<row> (alternating)
               (gui 1 '(+View +TextField) NIL 100 2) 
               (gui 2 '(+View +DateField) 100) 
               (gui 3 '(+View +TimeField) 100) 
               )))
  (<spread> (scroll 6))

      )
)
