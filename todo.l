(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(setq *DateSep "-")            ## separate dates with - (e.g. 2016-08-24)

(class +Task +Entity)         # starts the entity definition
(rel nr (+Need +Key +Number)) # defines a key, needed collect/query
(rel nm (+Sn +IdxFold +String))            # task name
(rel tags (+Sn +IdxFold +String))            # tags name
                              # NOTE: +Ref must be specified before +Number
(rel pri (+Ref +Number))      # task priority, with index to support (collect 'pri '+Task 1)
(rel due (+Ref +Date))        # task due date
(rel status (+Ref +String))   # task status

# adds a task. Uses default priority of 1000 if not specified
# usage (task-add "call home")
(de task-add (Task Priority Due)
    (new! '(+Task)
          'nr (genKey 'nr '+Task)
          'nm Task
          'pri (or Priority 1000)
          'due Due
          'status "NEW"))

# fetches properties of a task from an external symbol
# usage (task-show '{4})
(de task-show (This)
    (list 'nr (: nr)
          'nm (: nm)
          'pri (: pri)
          'due (: due)
          'status (: status)))

# returns a list of all tasks
# usage (task-all)
(de task-all ()
    (mapcar task-show (collect 'nr '+Task)))

# sets a task to be done
# usage (task-done 1)
(de task-done (Nr)
    (put!> (db 'nr '+Task Nr) 'status "DONE"))

# finds open tasks
(de task-all-open ()
    (mapcar task-show (collect 'status '+Task "OPEN")))

# finds done tasks
(de task-all-done ()
    (mapcar task-show (collect 'status '+Task "DONE")))

# sets a task due date
# usage (task-due 1 "2016-08-24")
(de task-due (Nr Due)
    (put!> (db 'nr '+Task Nr) 'due ($dat Due *DateSep)))

# finds task by due date
# usage (task-all-due "2016-08-16") or (task-all-due "2016-01-01" "2017-01-01")
(de task-all-due (Start End)
    (mapcar task-show
            (collect 'due '+Task
                     ($dat Start *DateSep)
                     ($dat (or End Start) *DateSep))))

(de ui-main ()
   (app)
   #(load "mytodoapp.l")
(action
   (html 0 Ttl "@lib.css" NIL
      (form NIL
               (<grid> "----."
                  "Name" (gui 'nm '(+DbHint +TextField) '(nm +Task) 20)
                  "Tags" (gui 'tags '(+DbHint +TextField) '(tags +Task) 20)
                  (searchButton '(init> (: home query)))
                  
                   )
         (gui 'query '(+QueryChart) 5
                  '(goal
                     (quote
                        @Nm (val> (: home nm)) 
                        @Tg (val> (: home tags)) 
                        (select (@@)
                           ((nm +Task @Nm) (tags +Task @Tg))
			   (tolr @Nm @@ nm)
			   (part @Tg @@ tags)

                           
                            ) ) )
                  5
                  '((This) (list (: nm) (: status) (: tags) (: due) ))
                  '((L D)
                     (cond
                        (D
                           (mapc
                              '((K V) (put!> D K V))
                              '(nm status tags due)
                              L )
                           D )
                        ((car L)
                           (new! '(+Task) 'nm (car L)) ) ) ) )

         (<table> NIL (choTtl "Entries" '+Task)
            (quote
               (NIL "Name")
               (NIL "Status")
               (NIL "Tags")
               (NIL "Due")
            )

            (do 5
               (<row> NIL
                  (gui 1 '(+TextField) 30)
                  (gui 2 '(+DbHint +TextField)  '(status +Task) 10)
                  (gui 3 '(+TextField) 40)
                  (gui 4 '(+DateField) 20)
                  (gui 5 '(+DelRowButton)
                           '(lose!> (curr))
                           '(text "Delete Entry @1?" (curr 'nm)) )
                )
            )
         ) 
         (scroll 5)
      )
   )
)
)

(de main () (pool "dingo.db"))

(de go ()
   (rollback)
   (server 8080 "!ui-main") )

