(load "utils.lisp")
(load "day1.lisp")
(load "day2.lisp")
(load "day3.lisp")
(defpackage aoc-2023 (:use :cl :aoc-2023-utils :aoc-2023-day1 :aoc-2023-day2 :aoc-2023-day3))

(in-package aoc-2023)

(solve-day1 (read-lines 1))
(solve-day2 (read-lines 2))
(solve-day3 (read-lines 3))
