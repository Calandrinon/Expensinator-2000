(load "service.lisp")


(defun test-service-add ()
	(let* ((test-repository (make-instance 'Repository))
		   (test-service (create-service test-repository)))
		(add-expense "Book" 25 test-service)
		(assert (= 1 (get-repository-size (repository test-service)))))
	(print "Test-service-add passed!"))


(defun run-tests ()
	(test-service-add))


