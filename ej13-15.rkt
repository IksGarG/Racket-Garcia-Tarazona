#|
Ejercicios 13 a 17

Andrés Tarazona Solloa
Iker García
|#

#lang racket

(require racket/trace)

(provide list-of-symbols? swapper dot-product average)

(define (list-of-symbols? lst)
  (trace-let loop ([lst lst])
    (if (empty? lst)
      #t
        (if (symbol? (car lst))
          (loop (cdr lst))
          #f))))

#|
Ejercicio 14: swap dos numeros en la lista
|#
(define (swapper a b lst)
  (trace-let loop ([a a]
                   [b b]
                   [lst lst]
                   [res '()])
        (if (empty? lst)
          (reverse res)
            (if (= (car lst) a)
              (loop a b (cdr lst) (cons b res))
              (if (= (car lst) b)
                (loop a b (cdr lst) (cons a res))
                  (loop a b (cdr lst) (cons (car lst) res)))))))

#|
Ejercicio 15: dot product
|#
(define (dot-product lst1 lst2)
  (trace-let loop ([lst1 lst1] [lst2 lst2] [res 0])
        (if (or (empty? lst1) (empty? lst2))
          res
          (loop (cdr lst1) (cdr lst2) (+ res (* (car lst1) (car lst2)))))))

#|
Ejercicio 16: average
|#

(define (average lst)
  (trace-let loop ([lst lst] [lst2 lst] [res 0])
    (if (empty? lst)
      (/ res (length lst2))
      (loop (cdr lst) lst2 (+ res (car lst))))))
