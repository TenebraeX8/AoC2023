(require :uiop)
(defpackage aoc-2023-utils (:use :cl)
    (:export :read-lines :read-lines-as-int :string-replace))

(defun read-lines (nr) (uiop:read-file-lines (format nil "./inputs/~a.inp" nr)))
(defun read-lines-as-int (nr) (mapcar #'parse-integer (read-lines nr)))



;taken from https://stackoverflow.com/questions/4366668/str-replace-in-common-lisp
(defun string-replace (search replace string &optional count)
  (loop for start = (search search (or result string)
                            :start2 (if start (1+ start) 0))
        while (and start
                   (or (null count) (> count 0)))
        for result = (concatenate 'string
                                  (subseq (or result string) 0 start)
                                  replace
                                  (subseq (or result string)
                                          (+ start (length search))))
        do (when count (decf count))
        finally (return-from string-replace (or result string))))