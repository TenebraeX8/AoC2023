(require :uiop )
(load "utils.lisp")
(defpackage aoc-2023-day2 (:use :cl :aoc-2023-utils) (:export :solve-day2))


(defvar *requirement* nil)
(setf *requirement* '(("red" . 12) ("green" . 13) ("blue" . 14))) 

(defun to-int (str) (parse-integer (remove-if-not #'digit-char-p str)))
(defun section-elem-to-dict (elem) (dictionarify (reverse (str-split (subseq elem 1) " "))))
(defun int-from-string-dict (key dict) (parse-integer (nil-to-default (lookup key dict) "0")))

(defun extract-list (line)
    (let ((computed (uiop:split-string line :separator ":")))
        (setf (first computed) (to-int (first computed)))
        (setf (second computed) (uiop:split-string (second computed) :separator ";"))
        (loop for idx from 0 to (- (length (second computed)) 1)
            do (setf (nth idx (second computed)) (mapcar #'section-elem-to-dict (str-split (nth idx (second computed)) ","))))
        computed))

(defun check-requirement-p (key dict) (<= (int-from-string-dict key dict) (lookup key *requirement*)))
(defun check-all-requirements-p (dict) (and (check-requirement-p "red" dict) 
                                            (check-requirement-p "green" dict) 
                                            (check-requirement-p "blue" dict)))

(defun construct-criteria-list (line)
    (loop for section in (second (extract-list line))
        collect (if (check-all-requirements-p section) 1 0)))

(defun day2-part1 (inp) 
    (loop for line in inp 
        sum (let((criteria-met (construct-criteria-list line)))
            (if (some #'zerop criteria-met) 0 (first (extract-list line))))))


(defun get-min (line)
    (let ((min-vals (copy-alist '(("red" . 0) ("green" . 0) ("blue" . 0)))))
        (loop for section in (second (extract-list line))
            do (loop for color in '("red" "green" "blue")
                do 
                    (let ((elem (int-from-string-dict color section)))
                      (if (> elem (lookup color min-vals)) (update color min-vals elem)))))
        min-vals))

(defun day2-part2 (inp) (loop for line in inp sum (reduce #'* (values-of-dict (get-min line)))))


(defun solve-day2 (inp) (format t "----------~%Day2~%----------~%Part 1: ~a~%Part 2: ~a~%" (day2-part1 inp) (day2-part2 inp)))