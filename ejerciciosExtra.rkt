#|
Solo los hice para practicar y porque andaba aburrido lul

|#

#lang racket

(require racket/trace)

(provide (all-defined-out))

#| 
Ejercicio 18: replicar elementos en la lista n veces.
|#
(define (repeat n a)
  (trace-let loop ([n n] [a a] [res '()])
    (if (zero? n)
      res
      (loop (sub1 n) a (cons a res)))))

(define (replic n lst)
  (trace-let loop ([n n][lst lst][res '()])
    (if (empty? lst)
      (reverse res)
      (loop n (cdr lst) (cons (repeat n (car lst)) res)))))

#|
Ejercicio 19: expand.
|#

(define (expand lst)
  (trace-let loop ([n 1][lst lst][res '()])
    (if (empty? lst)
      (reverse res)
      (loop (add1 n) (cdr lst) (cons (repeat n (car lst)) res)))))

#|
Ejercico 20: Binary number conversion.
|#

(define (binary n)
  (trace-let loop ([n n][res '()])
    (if (zero? n)
      res 
      (loop (quotient n 2) (cons (remainder n 2) res)))))



