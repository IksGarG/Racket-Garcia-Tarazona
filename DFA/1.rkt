#lang racket
(define mi-lista '(1 2 3 4 5 6 7))
(define (multiply-by-index lst)
  (define (helper lst index)
    (cond
      [(empty? lst) '()]                              ; Base case: empty list, return empty list
      [else (cons (* (first lst) (+ index 1))          ; Multiply the first element by the (index + 1)
                  (helper (rest lst) (+ index 1)))])) ; Recursively process the rest of the list with the next index

  (helper lst 0))  ; Call the helper function with the initial index 0


(multiply-by-index mi-lista)