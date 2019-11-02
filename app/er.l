(class +Task +Entity)
(rel nr (+Need +Key +Number))
(rel ttl (+Sn +IdxFold +String))
(rel dt (+Need +Ref +Date))
(rel upds (+List +Joint) tsk (+Update))

(dm url> (Tab)
  (and (list "app/tsk.l" '*ID This)) )

(class +Update +Entity)
(rel tsk (+Joint) upds (+Task) )
(rel dsc (+Sn +IdxFold +String))            
(rel dt (+Need +Ref +Date))
