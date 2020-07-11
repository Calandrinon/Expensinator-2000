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
			(print "Test-repo-remove passed!")))										


(defun test-service-remove ()
	(let* ((test-repository (make-instance 'Repository))
		   (test-service (create-service test-repository)))
			(add-expense "Book 1" 25 test-service)
			(add-expense "Book 2" 30 test-service)
			(remove-expense "Book 2" 30 test-service)	
			(assert (= (get-repository-size test-repository) 1))
			(print "Test-service-remove passed!")))


(defun run-tests ()
	(test-service-add)
	(test-repo-remove)
	(test-service-remove))


