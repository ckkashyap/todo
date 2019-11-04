# 18jan18abu
# (c) Software Lab. Alexander Burger

`(not (seq *DB))

#(prinl "START 200")
#(for I (range 1 200)
#	(let T1 (new (db: +Task) '(+Task) 'nr I 'ttl (pack "LOOP TASK " I) 'dt (date 2019 11 2) 'sts "OPEN")
#	  (put> T1 'upds
#	    (list  (new (db: +Update) '(+Update) 'dsc (pack "One Update 1 " I) 'dt (date 2019 11 1) 'tm (time) )
#		   (new (db: +Update) '(+Update) 'dsc (pack "One Update 2 " I) 'dt (date 2019 11 2) 'tm (time) )
#		   (new (db: +Update) '(+Update) 'dsc (pack "One Update 3 " I) 'dt (date 2019 11 3) 'tm (time) )                         )))
#)
#(prinl "END 200")
#
#
#(let T2 (new (db: +Task) '(+Task) 'nr 2 'ttl "Task Two" 'dt (date 2019 11 1) 'sts "DONE")
#  (put> T2 'upds
#    (list  (new (db: +Update) '(+Update) 'dsc "Two Update 1" 'dt (date 2019 11 1) 'tm (time) )
#           (new (db: +Update) '(+Update) 'dsc "Two Update 2" 'dt (date 2019 11 2) 'tm (time) )
#           (new (db: +Update) '(+Update) 'dsc "Two Update 3" 'dt (date 2019 11 3) 'tm (time) )                         )))
#(commit)

# vi:et:ts=3:sw=3
