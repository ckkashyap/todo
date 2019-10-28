(menu "Tasks"
   (idForm ,"Tasks" '(choTsk) 'dsc '+Tsk T '(may Delete) '((: dsc))
      (--)
      (<grid> 2
         ,"Name>>" (gui '(+E/R +Cue +TextField) '(nm : home obj) ,"Name" 40)
         ,"Desc>>" (gui '(+E/R +TextField) '(dsc : home obj) 40) ) ) )
