# 05jan18abu
# (c) Software Lab. Alexander Burger

### Entity/Relations ###

(class +Task +Entity)
(rel nr (+Need +Key +Number))
(rel dsc (+Sn +IdxFold +String))
(rel nm (+Sn +IdxFold +String))
(rel upds (+List +Joint) tsk (+Update))

(dm url> (Tab)
  (and (may Customer) (list "app/tsk.l" '*ID This)) )

(class +Update +Entity)
(rel tsk (+Joint) upds (+Task) )
(rel dsc (+Sn +IdxFold +String))            

(dm url> (Tab)
   (and (may Customer) (list "bbbbbbbbb" '*ID This)) )
  # (and (may Customer) (list "app/tsk.l" '*ID This)) )

# Database sizes
(dbs
   (2 +Task)                                    # C:256 Normal objects
    )                             # K:1024

# vi:et:ts=3:sw=3
