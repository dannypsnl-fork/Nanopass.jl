@language L0
  terminals
    variable: [x]
    primitive: [pr]
    datum: [d]
    constant: [c]
  Expr [e body]
    x
    pr
    c
    d
    begin e* ... e
    if e0 e1
    if e0 e1 e2
    lambda [x* ...] body* ... body
    app e e* ...
