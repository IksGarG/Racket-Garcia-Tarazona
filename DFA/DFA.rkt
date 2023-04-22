#|
DFA Para un token list

Andrés Tarazona - A01023332
Iker García - 
|#

#lang racket

(require racket/trace)

(provide (all-defined-out))

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

(define (arithmetic-lexer strng)
  (evaluate-dfa (dfa delta-arithmetic 'start '(paropn parcls int float exp var spa comment)) strng))

(define (evaluate-dfa dfa-to-evaluate strng)
  " This function will verify if a string is acceptable by a DFA "
  (trace-let loop
    ; Convert the string into a list of characters
    ([chars (string->list strng)]
     ; Get the initial state of the DFA
     [state (dfa-initial dfa-to-evaluate)]
     ; The return list with all the tokens found
     [tokens '()])
    (cond
      ; When the list of chars if over, check if the final state is acceptable
      [(empty? chars)
       (if (member state (dfa-accept dfa-to-evaluate))
         ; Add the last pending state to the list, and reverse it
         (reverse (cons state tokens))
         'invalid)]
      [else
        (let-values
          ; Call the transition function and get the new state and whether or not a token was found
          ([(new-state found) ((dfa-func dfa-to-evaluate) state (car chars))])
          (loop (cdr chars)
                new-state
                ; The new list of tokens
                (if found (cons found tokens) tokens)))])))

(define (char-operator? char)
  " Identify caracters that represent arithmetic operators "
  (member char '(#\+ #\- #\* #\/ #\= #\^)))

(define (delta-arithmetic state char)
  "States accepted: 'start 'paropn 'parcls 'sign 'int 'dot 'float 'e 'e_sign 'exp 'var 'spa 'comment 'inv
  Comments are created with one bang"
  (case state
    ['start (cond
       [(char-numeric? char) (values 'int #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
       [(char-alphabetic? char) (values 'var #f)]
       [(eq? char #\_) (values 'var #f)]
       [(eq? char #\() (values 'paropn #f)]
       [(eq? char #\)) (values 'parcls #f)]
       [(eq? char #\space) (values 'spa #f)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['paropn (cond
        [(char-numeric? char) (values 'int 'paropn)]
        [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'paropn)]
        [(char-alphabetic? char) (values 'var 'paropn)]
        [(eq? char #\_) (values 'var 'paropn)]
        [(eq? char #\() (values 'paropn 'paropn)]
        [(eq? char #\)) (values 'parcls 'paropn)])]
       [(eq? char #\!) (values 'comment #f)]
    ['parcls (cond
        [(char-numeric? char) (values 'int 'parcls)]
        [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'parcls)]
        [(char-alphabetic? char) (values 'var 'parcls)]
        [(char-operator? char) (values 'op 'parcls)]
        [(eq? char #\_) (values 'var 'parcls)]
        [(eq? char #\() (values 'paropn 'parcls)]
        [(eq? char #\)) (values 'parcls 'parcls)])]
       [(eq? char #\!) (values 'comment #f)]
    ['sign (cond
       [(char-numeric? char) (values 'int #f)]
        [(eq? char #\() (values 'paropn #f)]
        [(eq? char #\)) (values 'parcls #f)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['int (cond
       [(char-numeric? char) (values 'int #f)]
       [(eq? char #\.) (values 'dot #f)]
       [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
       [(char-operator? char) (values 'op 'int)]
       [(eq? char #\space) (values 'spa 'int)]
        [(eq? char #\() (values 'paropn 'int)]
        [(eq? char #\)) (values 'parcls 'int)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['dot (cond
       [(char-numeric? char) (values 'float #f)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['float (cond
       [(char-numeric? char) (values 'float #f)]
       [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
       [(char-operator? char) (values 'op 'float)]
       [(eq? char #\space) (values 'spa 'float)]
        [(eq? char #\() (values 'paropn 'float)]
        [(eq? char #\)) (values 'parcls 'float)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['e (cond
       [(char-numeric? char) (values 'exp #f)]
       [(eq? char #\!) (values 'comment #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'e_sign #f)]
       [else (values 'inv #f)])]
    ['e_sign (cond
       [(char-numeric? char) (values 'exp #f)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['exp (cond
       [(char-numeric? char) (values 'exp #f)]
       [(char-operator? char) (values 'op 'exp)]
       [(eq? char #\space) (values 'spa 'exp)]
        [(eq? char #\() (values 'paropn 'exp)]
        [(eq? char #\)) (values 'parcls 'exp)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['var (cond
       [(char-alphabetic? char) (values 'var #f)]
       [(char-numeric? char) (values 'var #f)]
       [(eq? char #\_) (values 'var #f)]
       [(char-operator? char) (values 'op 'var)]
       [(eq? char #\space) (values 'spa 'var)]
        [(eq? char #\() (values 'paropn 'var)]
        [(eq? char #\)) (values 'parcls 'var)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['op (cond
       [(char-numeric? char) (values 'int 'op)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'op)]
       [(char-alphabetic? char) (values 'var 'op)]
       [(eq? char #\_) (values 'var 'op)]
       [(eq? char #\space) (values 'op_spa 'op)]
        [(eq? char #\() (values 'paropn 'op)]
        [(eq? char #\)) (values 'parcls 'op)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
     ['spa (cond
       [(char-operator? char) (values 'op #f)]
       [(eq? char #\space) (values 'spa #f)]
        [(eq? char #\() (values 'paropn #f)]
        [(eq? char #\)) (values 'parcls #f)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['op_spa (cond
       [(char-numeric? char) (values 'int #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
       [(char-alphabetic? char) (values 'var #f)]
       [(eq? char #\_) (values 'var #f)]
       [(eq? char #\space) (values 'op_spa #f)]
        [(eq? char #\() (values 'paropn #f)]
        [(eq? char #\)) (values 'parcls #f)]
       [(eq? char #\!) (values 'comment #f)]
       [else (values 'inv #f)])]
    ['comment (cond
       [(eq? char #\newline) (values 'start 'comment)]
       [else (values 'comment #f)])
    [else (values 'inv #f)]))
