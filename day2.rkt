#lang scheme

; data abstraction with car/cdr and cons cells

(define (make-rat n d) (cons n d))

(define (numer x) (car x))

(define (denom x) (cdr x))

; writing a rational normalizer for positive/negative

(define (normalize rat)
   ; numerator
   (cond
     ; EITHER positive numerator OR (negative numerator AND negative denomator)
     ((or (> 0 (numer rat)) (and (< 0 (numer rat)) (< 0 (denom rat))))
     ; force positive
         (make-rat (abs (numer rat)) (abs (denom rat))))
     ; either numerator or demominator is negative
     ((or (< (numer rat) 0) (< (denom rat) 0))
         (make-rat (- 0 (abs (numer rat))) (abs (denom rat))))
     ; is there an else? leave alone
     (else
         (displayln "weird rational?")
         (make-rat (numer rat) (denom rat)))))

(define (normal-rat numer denom) (normalize (make-rat numer denom)))
           
(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))


; print a rational number

(print-rat (make-rat 2 3))
(print-rat (normal-rat -2 -3))
(print-rat (normal-rat 2 3))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(add-rat (make-rat 1 2) (make-rat 1 2))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(sub-rat (make-rat 1 2) (make-rat 1 2))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(mul-rat (make-rat 1 2) (make-rat 1 2))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(div-rat (make-rat 4 1) (make-rat 1 4))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(equal-rat? (make-rat 1 2) (make-rat 1 2))
(equal-rat? (make-rat 1 4) (make-rat 2 8))

(define (numer-1 x)
  (let ((g (gcd (car x) (cdr x))))
  (/ (car x) g)))

(define (denom-1 x)
  (let ((g (gcd (car x) (cdr x))))
  (/ (cdr x) g)))

(define (simplify rat)
  (make-rat (numer-1 rat) (denom-1 rat)))

(simplify (make-rat 4 16))

(simplify (normal-rat -4 -16))