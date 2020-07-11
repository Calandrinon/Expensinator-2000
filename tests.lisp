(load "service.lisp")


(defun test-service-add ()
	(let* ((test-repository (make-instance 'Repository))
		   (test-service (create-service test-repository)))
		(add-expense "Book" 25 test-service)
		(assert (= 1 (get-repository-size (repository test-service)))))
	(print "Test-service-add passed!"))


(defun test-repo-remove ()
	(let* ((test-repository (make-instance 'Repository))
		   (test-service (create-service test-repository)))
			(add-expense "Book 1" 25 test-service)
			(add-expense "Book 2" 30 test-service)
			(remove-from-repository "Book 2" 30 test-repository)	
			(assert (= (get-repository-size test-repository) 1))
			(print "Test-repo-remove passed!")
		)
)										

#|
(defun test-expense-equality-function ()
	(let* ((exp1 (make-instance 'Expense :expense-title "abc" :price 1))
		   (exp2 (make-instance 'Expense :expense-title "def" :price 2)))
		(assert (not (equal-expenses exp1 exp2))	
	)
)
|#


(defun run-tests ()
	(test-service-add)
	(test-repo-remove)
	)


