
(in-package :modf)

;; @\section{FUNDS Integration}

;; @There actually isn't much to integrate with FUNDS.  It is interesting to
;; note how FSet and FUNDS have a pretty different goal.  FSet is intended to be
;; a functional replacement to the basic data structures of Common Lisp while
;; FUNDS is an add on of a few functional types like queues, stacks, and heaps.
;; The only overlap is FUNDS dictionaries and FSet maps and FUNDS f-arrays and
;; FSet seqs.  So, there isn't as much to do here as I thought.

;; @\subsection{Trees}

;; @\FUNDS is based on trees.  This means that we really only need to define a
;; modf function for <<funds:tree-find>>.  This should be used with caution.
;; <<Tree-find>> only returns the first match it finds.  This means that if you
;; have a tree with multiple elements with the same key, it may be unpredictable
;; which key is replaced.

(modf:define-modf-function funds:tree-find 1
    (new-val tree key &key (order nil order?) (test nil test?))
  (let ((key-args (append (if order? (list :order order))
                          (if test? (list :test test)) )))
    (apply #'funds:tree-insert
           (apply #'funds:tree-remove tree key key-args)
           key
           new-val key-args )))

;; @\subsection{Dictionaries}

(modf:define-modf-function funds:dictionary-lookup 1
    (new-val d key)
  (funds:dictionary-add d key new-val) )

;; @\subsection{F-Arrays}

(modf:define-modf-function funds:f-array-elt 1
    (new-val arr index)
  (funds:f-array-replace arr index new-val) )

;; @\subsection{Queues, Stacks, and Heaps}

;; @Why aren't there any modf facilities for queues, stacks, and heaps: because
;; you cannot change arbitrary elements for these structures.  You can only push
;; onto them and pull from them.  This means that the access form is inherently
;; un-invertable.

