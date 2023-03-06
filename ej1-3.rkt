#| 
Andrés Tarazona
Iker García
|#

#lang racket

(provide F-to-C sign roots)

#|
La función fahrenheit-to-celsius toma como entrada una temperatura f en grados Fahrenheit y la
convierte a su equivalente en grados Celsius 
|#
(define (F-to-C f)
  (/ (- f 32) 1.8))

#|
La función sign recibe como entrada un valor entero n. Devuelve -1 si n es negativo, 1 si n es positivo mayor
que cero, o 0 si n es cero.
|#

(define (sign n)
  (cond [(< n 0) -1]
        [(> n 0) 1]
        [else 0]))

#|
La función roots devuelve la ra ́ız que resuelve una ecuaci ́on cuadr ́atica a partir de sus tres coeficiente, a, b y
c, que se reciben como entrada.
|#

(define (roots a b c)
  (/ (- b (sqrt (- (* b b) (* 4 a c))))
     (* 2 a)))


