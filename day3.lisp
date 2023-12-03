(require :uiop )
(load "utils.lisp")
(defpackage aoc-2023-day3 (:use :cl :aoc-2023-utils) (:export :solve-day3))

(in-package aoc-2023-day3)

(defun array-access (arr i j) (char (nth i arr)j))
(defun engine-symbolp (arr i j)
    (let ((c (array-access arr i j)))
        (and (not (digit-char-p c)) (not (equalp c #\.)))))

(defun check-adjacents (arr i j)
    (or
        (and (> i 0) (> j 0) (engine-symbolp arr (- i 1) (- j 1)))
        (and (> i 0)         (engine-symbolp arr (- i 1) j))
        (and (> i 0) (< j (- (length (first arr)) 1)) (engine-symbolp arr (- i 1) (+ j 1)))
        (and (> j 0) (engine-symbolp arr i (- j 1)))
        (and (< j (- (length (first arr)) 1)) (engine-symbolp arr i (+ j 1)))
        (and (< i (- (length arr) 1)) (> j 0) (engine-symbolp arr (+ i 1) (- j 1)))
        (and (< i (- (length arr) 1)) (engine-symbolp arr (+ i 1) j))
        (and (< i (- (length arr) 1)) (< j (- (length (first arr)) 1)) (engine-symbolp arr (+ i 1) (+ j 1)))))

(defun day3-part1 (inp) 
    (loop for i from 0 to (length inp)
          for line in inp
        sum (let ((buffer "") (adjacent nil) (numbers nil))
            (loop for j from 0 to (length line)
                  for c across line
                when (digit-char-p c)
                do 
                (setf buffer (format nil "~a~a" buffer c))
                (setf adjacent (or adjacent (check-adjacents inp i j)))

                else do 
                    (if (and (not (zerop (length buffer))) adjacent) (push (parse-integer buffer) numbers))
                    (setf adjacent nil)
                    (setf buffer "")

                finally (if (and (not (zerop (length buffer))) adjacent) (push (parse-integer buffer) numbers))
            )            
            (reduce #'+ numbers))))


(defun extract-number-at (arr i j)
    (let ((buffer "") (col j))
        (loop while (and (< col (length (nth i arr))) (digit-char-p (array-access arr i col)))  
            do (setf buffer (format nil "~a~a" buffer (array-access arr i col)))
               (incf col))
        (setf col (- j 1))
        (loop while (and (>= col 0) (digit-char-p (array-access arr i col)))  
            do (setf buffer (format nil "~a~a" (array-access arr i col) buffer))
               (decf col))
        (parse-integer buffer)))

(defun find-adjacent-numbers (arr i j)
    (let ((numbers nil))
        (if (and (> i 0) (> j 0) 
                 (digit-char-p (array-access arr (- i 1) (- j 1)))) 
                 (push (extract-number-at arr (- i 1) (- j 1)) numbers))
        (if (and (> i 0) 
                 (digit-char-p (array-access arr (- i 1) j))
                 (or (= j 0) (not (digit-char-p (array-access arr (- i 1) (- j 1))))))
                 (push (extract-number-at arr (- i 1) j) numbers))
        (if (and (> i 0) (< j (- (length (first arr)) 1))
                 (digit-char-p (array-access arr (- i 1) (+ j 1)))
                 (not (digit-char-p (array-access arr (- i 1) j))))
                 (push (extract-number-at arr (- i 1) (+ j 1)) numbers))

        (if (and (> j 0) 
                 (digit-char-p (array-access arr i (- j 1)))) 
                 (push (extract-number-at arr i (- j 1)) numbers))
        (if (and (> j 0) (< j (- (length (first arr)) 1))
                 (digit-char-p (array-access arr i (+ j 1)))) 
                 (push (extract-number-at arr i (+ j 1)) numbers))

        (if (and (< i (- (length arr) 1)) (> j 0) 
                 (digit-char-p (array-access arr (+ i 1) (- j 1)))) 
                 (push (extract-number-at arr (+ i 1) (- j 1)) numbers))
        (if (and (< i (- (length arr) 1))
                 (digit-char-p (array-access arr (+ i 1) j)) 
                 (or (= j 0) (not (digit-char-p (array-access arr (+ i 1) (- j 1))))))
                 (push (extract-number-at arr (+ i 1) j) numbers))
        (if (and (< i (- (length arr) 1)) (< j (- (length (first arr)) 1))
                 (digit-char-p (array-access arr (+ i 1) (+ j 1))) 
                 (not (digit-char-p (array-access arr (+ i 1) j))))
                 (push (extract-number-at arr (+ i 1) (+ j 1)) numbers))
        numbers))

(defun day3-part2 (inp) 
    (loop for i from 0 to (length inp)
          for line in inp
        sum (loop for j from 0 to (length line)
                  for c across line
                when (equalp c #\*)
                sum (let ((numbers (find-adjacent-numbers inp i j)))
                    (if (= (length numbers) 2) (reduce #'* numbers) 0)))))


(defun solve-day3 (inp) (format t "----------~%Day3~%----------~%Part 1: ~a~%Part 2: ~a~%" (day3-part1 inp) (day3-part2 inp)))