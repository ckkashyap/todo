(must "Salutation" Customer)

(menu ,"Tasks"
   (idForm ,"Tasks" '(choTsk) 'nm '+Tsk T '(may Delete) '((: nm))
      (<grid> 2
         ,"Name" (gui '(+E/R +Cue +TextField) '(nm : home obj) ,"Name" 40)
         ,"Desc" (gui '(+E/R +TextField) '(dsc : home obj) 40) ) ) )
