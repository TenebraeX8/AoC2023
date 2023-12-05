(require :uiop )
(load "utils.lisp")
(defpackage aoc-2023-day4 (:use :cl :aoc-2023-utils) (:export :solve-day4))

(in-package aoc-2023-day4)

(defun only-digits (str) (remove-if-not #'digit-char-p str))

(defun extract-data (line)
    (let ((data (str-split (second (str-split line ":")) "|")))
        (setf (first data) (mapcar #'parse-integer (remove-if #'str-empty  (mapcar #'only-digits (str-split (first data) " ")))))
        (setf (second data) (mapcar #'parse-integer (remove-if #'str-empty  (mapcar #'only-digits (str-split (second data) " ")))))
        data))

(defun day4-part1 (inp) 
    (loop for line in inp
    sum (let ((data (extract-data line)))
       (let ((cnt (count-if #'(lambda (x) (find x (second data))) (first data))))
         (if (> cnt 0) (expt 2 (- cnt 1)) 0)))))

(defun day4-part2 (inp) 
    (loop for line in inp
          for idx from 0 to (- (length inp) 1)
        with multipliers := (make-array (length inp) :initial-element 1)
        do (let ((data (extract-data line)))
        (let ((cnt (count-if #'(lambda (x) (find x (second data))) (first data))))
                (loop for i from 1 to cnt
                    when (< (+ idx i) (length multipliers))
                    do (incf (aref multipliers (+ idx i)) (aref multipliers idx))
                )
        ))
        finally (return-from day4-part2 (reduce #'+ multipliers))))


(defun solve-day4 (inp) (format t "----------~%Day4~%----------~%Part 1: ~a~%Part 2: ~a~%" (day4-part1 inp) (day4-part2 inp)))

(solve-day4 (read-lines 4))