; Name: Akshith Gara
; Homework 4

(defun myLast (L)
	(if (eq nil (cdr L))
		(car L)
		(myLast (cdr L))
	)
)

(defun myCount (X L)
	(if (myMember X L) 
		(if (eq X (car L)) 
			(+ 1 (myCount X (cdr L)))
			(+ 0 (myCount X (cdr L)))
		)
		0
	)
)


(defun myMember (X L)
	(if (eq X (car L)) t 
		(if (eq nil (car L)) nil
			(myMember X (cdr L))
		)
	)
)


(defun myPurge (L)
	(if (eq nil (car L))
		nil
		(if (myMember (car L) (cdr L))
			(myPurge (cdr L))
			(cons (car L) (myPurge (cdr L)))
		)
	)
)

(defun myCommon (L1 L2)
	(if (eq (car L1) nil)
		nil
		(if (myMember (car L1) L2) 
			(cons (car L1) (myCommon (cdr L1) L2))
			(myCommon (cdr L1) L2)
		)
	)
)

(defun myGen (X Y Z)
	(cond ((< X Y) (cons X (myGen (+ X Z) Y Z)))
		((= X Y) (list X))
		((> X Y) nil)
	)
)

(defun myMap (F L)
	(if (eq nil (car L)) 
		nil
		(cons (funcall F (car L)) (myMap F (cdr L)))
	)
)

(defun myReduce (F L)
	(if (eq nil (car L))
		(cond ((eq (funcall F 0 1) 1) 0)
			((eq (funcall F 0 1) 0) 1)
		)
		(funcall F (car L) (myReduce F (cdr L)))
	)
)