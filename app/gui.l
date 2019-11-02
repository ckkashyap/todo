# 08may16abu
# (c) Software Lab. Alexander Burger

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
                     (,"Home" "!work")
                     (,"logout" (and *Login "!stop"))
                     (NIL (<hr>))
                     (T ,"Data"
                        (,"Tasks" (and (may Customer) "app/tsk.l")))
                      ) )
               ((NIL NIL 'main)
                  (<div> @ (run Prg 1)) ) ) ) ) ) )

(de work ()
   (setq *Url "!work")
   (and (app) (setq *Menu 3))
   (menu "PicoLisp App"
      (<h2> NIL "PicoLisp App")
      (<img> "@img/7fachLogo.png" "7fach Logo" NIL "50%")
      (----)
      (form NIL
         (gui '(+Init +Map +TextField)
            (cons *Ctry *Lang)
            *Locales
            (mapcar car *Locales)
            ',"Language" )
         (gui '(+Button) ',"Change"
            '(let V (val> (field -1))
               (locale (car V) (cdr V) "app/loc/") ) ) )
      (loginForm) ) )

(de stop ()
   (logout)
   (work) )

(de choTsk (Dst)
   (diaform '(Dst)
      (<grid> "--.-."
         ,"Number" (gui 'nr '(+Focus +Var +NumField) '*ItemNr 10)
         (searchButton '(init> (: home query)))
         (resetButton '(nr)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *ItemNr (cons @ @))

               (select (@@)
                  ((nr +Task @Nr))

                  #(tolr @Sup @@ sup nm) 
                  
               ) ) )
         4
         '((This) (list This (: nr) (: nm)  (: dsc) )) )
      (<table> 'chart  (choTtl ,"Items" 'nr '+Task)
         (quote
            (btn)
            (align "#")
            (NIL ,"Name")
            (NIL ,"Description")
            )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+TextField)) 
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

