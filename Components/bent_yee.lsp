(defun c:bent ()
  ;Deleting commands
  (setvar "cmdecho" 0)
  
  ;it is for inital variables for begin to calculate
  (setq Dma (getreal "Introduce el Diametro Mayor(In): "))(terpri)
  (setq Dme (getreal "Introduce el Diametro Menor(In): "))(terpri)
  (setq Din (getreal "Introduce el Diametro del Injerto (In): "))(terpri)
  (setq branch_lenght 300)
  
  ;Insertion point, from here it starts to draw
  (setq initial_point (getpoint "Punto de insercion: "))(terpri)
  
  ;Funtion for convert degrade to Radians
  (defun rads (A)(* pi (/ A 180.0))) ;The funtion ends here
  (defun degr (rad) (* (/ rad pi) 180.0));_fin de defun
    ;Converting Inches to mm
  (setq mayor_diam_mm (* Dma 25.4))
  (setq menor_diam_mm (* Dme 25.4))
  (setq branch_diam_mm (* Din 25.4))
  ;lenght of the body's branch
  (setq lenght_1 (* branch_diam_mm 2))
  (setq lenght_2 (+ 228.6 (- mayor_diam_mm  menor_diam_mm) ))
  (setq lenght_4 (sqrt (/ ( expt branch_diam_mm 2) 2 )))
  (setq lenght_3 (- (/ lenght_1 2) lenght_4))
  
  (setq point_1 (polar initial_point        (rads 90) (/ mayor_diam_mm 2)))
  (setq point_2 (polar point_1 (rads 0) lenght_3))
  (setq point_3 (polar point_2 (rads 45) (* 3 (/ branch_diam_mm 2))))
  (setq point_4 (polar point_3 (rads 315) branch_diam_mm))
  (setq point_5 (polar point_4 (rads 225) (/ branch_diam_mm 2)))
  (setq point_6 (polar point_5 (rads 0) lenght_3))
  
  (setq point_10 (polar point_1 (rads 270) mayor_diam_mm))
  (setq point_9 (polar point_10 (rads 0) lenght_1))
  (setq mid_point (polar initial_point (rads 0) (+ lenght_1 lenght_2)))
  (setq point_7 (polar mid_point (rads 90) (/ menor_diam_mm 2)))
  (setq point_8 (polar point_7 (rads 270) menor_diam_mm))

  
  (setq branch_center_2 (polar point_3 (rads 315) (/ branch_diam_mm 2)))
  
  (setq lenght_6 (+ lenght_4  (/ mayor_diam_mm 2)))
  (setq lenght_5 (sqrt ( expt (* 2 lenght_6) 2)  ))

  (setq branch_center_1 (polar branch_center_2 (rads 225) lenght_5))

  
  (command "_line" point_1 point_2 "")
  (command "_line" point_2 point_3 "")
  (command "_line" point_3 point_4 "")
  (command "_line" point_4 point_5 "")
  (command "_line" point_5 point_6 "")
  (command "_line" initial_point mid_point "")


  (command "_line" point_1 point_10 "")
  (command "_line" point_10 point_9 "")
  (command "_line" point_9 point_6 "")
  (command "_line" point_6 point_7 "")
  (command "_line" point_7 point_8 "")
  (command "_line" point_8 point_9 "")

  (command "_line" branch_center_1 branch_center_2 "")
  
) ; lisp ends