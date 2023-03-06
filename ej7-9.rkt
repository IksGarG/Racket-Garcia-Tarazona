#|
Ejercicios 7 a 9

Andrés Tarazona
Iker García
|#

#lang racket

(provide pow fib enlist)

#|
La función pow toma dos entradas como entrada: un n ́umero a y un entero positivo b. Devuelve el resultado
de calcular a elevado a la potencia b.
|#

(define (pow n m)
  (let loop 
    ([n n]
     [m m])
    (if (= m 0)
      1
      (* n (loop n (- m 1))))))

#|
La función fib toma un entero positivo n como entrada y devuelve el elemento correspondiente de la secuencia
de Fibonacci.
|#

(define (fib n)
  (let loop
    ([n n]
     [a 0]
     [b 1])
    (if (= n 0)
      a
      (loop (- n 1) b (+ a b)))))

#|
La función enlist coloca dento de una lista a cada elemento de nivel superior de la lista que recibe como
entrada.
|#

(define (enlist l)
  (if (null? l)
    '()
    (cons (list (car l)) (enlist (cdr l)))))
