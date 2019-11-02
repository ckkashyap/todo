# 18jan18abu
# (c) Software Lab. Alexander Burger

`(not (seq *DB))

### Role ###
(obj ((+Role) nm "Administration") perm `*Perms)
(obj ((+Role) nm "Accounting") perm (Customer Item Order Report Delete))
(obj ((+Role) nm "Assistance") perm (Order))
(commit)

### User ###
(obj ((+User) nm "admin") pw `(passwd "admin") nam "Administrator" role `(db 'nm '+Role "Administration"))
(obj ((+User) nm "ben") pw `(passwd "ben") nam "Ben Affleck" role `(db 'nm '+Role "Accounting"))
(obj ((+User) nm "jodie") pw `(passwd "jodie") nam "Jodie Foster" role `(db 'nm '+Role "Accounting"))
(obj ((+User) nm "sandy") pw `(passwd "sandy") nam "Sandra Bullock" role `(db 'nm '+Role "Accounting"))
(obj ((+User) nm "depp") pw `(passwd "depp") nam "Johnny Depp" role `(db 'nm '+Role "Assistance"))
(obj ((+User) nm "tom") pw `(passwd "tom") nam "Tom Hanks" role `(db 'nm '+Role "Assistance"))
(commit)


(let T1 (new (db: +Task) '(+Task) 'nr 1 'ttl "TASK1" 'dt (date 2019 11 2))
  (put> T1 'upds
    (list  (new (db: +Update) '(+Update) 'dsc "One Update 1" 'dt (date 2019 11 1))
           (new (db: +Update) '(+Update) 'dsc "One Update 2" 'dt (date 2019 11 2))
           (new (db: +Update) '(+Update) 'dsc "One Update 3" 'dt (date 2019 11 3))                         )))

(let T2 (new (db: +Task) '(+Task) 'nr 2 'ttl "Task Two" 'dt (date 2019 11 1))
  (put> T2 'upds
    (list  (new (db: +Update) '(+Update) 'dsc "Two Update 1" 'dt (date 2019 11 1))
           (new (db: +Update) '(+Update) 'dsc "Two Update 2" 'dt (date 2019 11 2))
           (new (db: +Update) '(+Update) 'dsc "Two Update 3" 'dt (date 2019 11 3))                         )))
(commit)

# vi:et:ts=3:sw=3
