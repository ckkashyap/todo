(menu "Tasks"
   (idForm ,"Tasks" '(choTsk) 'nr '+Tsk T '(may Delete) '((: nr))
      (--)
      (<grid> 2
         "Title" (gui '(+E/R +Cue +TextField) '(ttl : home obj) "Name" 40)
         "Due" (gui '(+E/R +DateField) '(dt : home obj) 40) 

         "Update" (gui '(+TextField) 30)
         (gui '(+Button) "Update"
              '(put!> (: home obj) 'upds (new! '(+Update) 'dsc (val> (field -1)) ) ) )  )
      (--)

      (gui '(+Set +E/R +Chart) '((L) (filter bool L)) '(upds : home obj) 2
        '( (U I) (with U (list (: dsc) (: dt) )) ) )
      (<table> 'chart NIL
         '((NIL "Updates"))
         (do 2
            (<row> (alternating)
               (gui 1 '(+View +TextField) 100) 
               (gui 2 '(+View +DateField) 100) 
               )))
  (<spread> (scroll 2))

      )
)
