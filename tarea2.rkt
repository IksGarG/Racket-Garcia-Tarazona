#|
Tarea 2: Programación funcional parte 2

Andrés Tarazona Solloa
Iker García
|#

#lang racket

(provide (all-defined-out))

;; Ejercicio 1

(define (insert i lst)
  (cons i (lst)))
