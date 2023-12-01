(require :uiop )
(load "utils.lisp")
(defpackage aoc-2023-day1 (:use :cl :aoc-2023-utils) (:export :solve-day1))


(defun get-numbers-from-string (str)
    (let ((value (remove-if-not #'digit-char-p str)))
         (if (< (length value) 2) (concatenate 'string value value) value)))

(defun extract-number (str) 
    (+ (* 10 (digit-char-p (char str 0))) 
       (digit-char-p (char str (- (length str) 1)))))


(defun part1 (inp)
    (loop for line in inp
        sum (extract-number (get-numbers-from-string line))))

(defun replace-written-numbers (line)
    (string-replace "one" "o1e" 
    (string-replace "two" "t2o"
    (string-replace "three" "t3e"
    (string-replace "four" "f4r"
    (string-replace "five" "f5e"
    (string-replace "six" "s6x"
    (string-replace "seven" "s7n"
    (string-replace "eight" "e8t"
    (string-replace "nine" "n9e" line))))))))))

(defun part2 (inp)
    (loop for line in inp
        sum (extract-number (get-numbers-from-string (replace-written-numbers line)))))


(defun solve-day1 (inp) (format t "----------~%Day1~%----------~%Part 1: ~a~%Part 2: ~a~%" (part1 inp) (part2 inp)))
