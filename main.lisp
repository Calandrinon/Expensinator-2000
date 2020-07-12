(load "tests.lisp")
(load "ui.lisp")

(defun main ()
	(run-tests)
	(let* ((repository (make-instance 'Repository))
		   (service (create-service repository))
		   (ui (make-instance 'UI :service service)))
		(ui-run ui)))

(main)
