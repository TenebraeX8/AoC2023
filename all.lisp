(load "utils.lisp")
(load "day1.lisp")
(load "day2.lisp")
(defpackage aoc-2023 (:use :cl :aoc-2023-utils :aoc-2023-day1 :aoc-2023-day2))

(solve-day1 (read-lines 1))
(solve-day2 (read-lines 2))
