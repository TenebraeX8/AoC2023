(require :uiop)
(defpackage aoc-2023-utils (:use :cl)
    (:export :read-lines :read-lines-as-int :nil-to-default
             :string-replace :str-split
             :dictionarify :lookup :update :keys-of-dict :values-of-dict
    ))

(in-package aoc-2023-utils)

(defun read-lines (nr) (uiop:read-file-lines (format nil "./inputs/~a.inp" nr)))
(defun read-lines-as-int (nr) (mapcar #'parse-integer (read-lines nr)))

(defun nil-to-default(value default) (if (eq value nil) default value))

;-------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------
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
(defun str-split (str sep) (uiop:split-string str :separator sep))


;-------------------------------------------------------------------
; Dictionaries (association lists)
;-------------------------------------------------------------------
(defun dictionarify (tuple) (cons (first tuple) (second tuple)))
(defun lookup (key dict) (cdr (assoc key dict :test #'equalp)))
(defun update (key dict value) (rplacd (assoc key dict :test #'equalp) value))
(defun keys-of-dict (dict) (loop for x in dict collect (car x)))
(defun values-of-dict (dict) (loop for x in dict collect (cdr x)))