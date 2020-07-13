(load "service.lisp")


(defun test-service-add ()
	(let* ((test-repository (make-instance 'Repository))
		   (test-service (create-service test-repository)))
		(add-expense 1 "Education" "Book" 25.99 test-service)
		(assert (= 1 (get-repository-size (repository test-service)))))
	(print "Test-service-add passed!"))


(defun test-repo-remove ()
	(let* ((test-repository (make-instance 'Repository))
		   (test-service (create-service test-repository)))
			(add-expense 1 "Education" "Book" 25.99 test-service)
			(add-expense 2 "Education" "Book 2" 22.59 test-service)
			(add-expense 3 "Education" "Book 3" 29.99 test-service)
			(remove-from-repository 2 test-repository)	
			(assert (= (get-repository-size test-repository) 2))
			(print "Test-repo-remove passed!")))										


(defun test-service-remove ()
	(let* ((test-repository (make-instance 'Repository))
		   (test-service (create-service test-repository)))
			(add-expense 1 "Education" "Book" 25.99 test-service)
			(add-expense 2 "Education" "Book 2" 22.59 test-service)
			(add-expense 3 "Education" "Book 3" 29.99 test-service)
			(remove-expense 2 test-service)	
			(assert (= (get-repository-size test-repository) 2))
			(print "Test-service-remove passed!")))


(defun run-tests ()
	(test-service-add)
	(test-repo-remove)
	(test-service-remove))


