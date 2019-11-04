# 08may16abu
# (c) Software Lab. Alexander Burger
(setq *Login T)

### GUI ###
(de menu (Ttl . Prg)
   (action
      (html 0 Ttl *Css NIL
         (<ping> 7)
         (<layout>
            ((180 0 'menu)
               (<div> @
                  (expires)
                  (<menu>
                     (NIL (<hr>))
                     (T ""
                        ("Tasks" (and "app/tsk.l")))
                      ) )
               ((NIL NIL 'main)
                  (<div> @ (run Prg 1)) ) ) ) ) ) )

(de work ()
   (setq *Url "!work")
   (and (app) (setq *Menu 1))
   (menu "PicoLisp App"
      ) 
   )

(de stop ()
   (logout)
   (work) )

(de choTsk (Dst)
   (diaform '(Dst)
      (<grid> "--.-.--.--."
         "Number" (gui 'nr '(+Focus +Var +NumField) '*ItemNr 10)
         "Title" (gui 'ttl '(+Var +TextField)  '*ItemTitle 10)
         "Status" (gui 'sts '(+DbHint +Var +TextField) '(sts +Task ) '*ItemStatus 10)
         (searchButton '(init> (: home query)))
         (resetButton '(nr)) )
      (gui 'query '(+QueryChart) (cho)
	'(goal
            (quote
               @Nr (and *ItemNr (cons @ @))
               @St *ItemStatus
               @Tl *ItemTitle

               (select (@@)
                  ((nr +Task @Nr) (sts +Task @St) (ttl +Task @Tl) )
               ) ) )
         4
         '((This) (list (: nr) This  (: dt) (: sts) )) )
      (<table> 'chart  (choTtl ,"Items" 'nr '+Task)
         (quote
            ("em7 align" "#")
            ("em40 fixedWidth" "Title")
            ("em7 align" "Due Date")
            ("em7 align" "Status")
            )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+NumField))
               (gui 2 '(+ObjView +TextField) '(: ttl) ) 
               (gui 3 '(+DateField))
               (gui 4 '(+TextField))
                ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Task)
            '(nr genKey 'nr '+Task)
            'nm *ItemNm
            'pr *ItemPr )
         (cancelButton) ) 
      
      ) )
