(defun c:bent ()
  ;Deleting commands
;   (setvar "cmdecho" 0)
  
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

  (setq point_1 (polar initial_point        (rads 90) (/ mayor_diam_mm 2)))
  (setq point_2 (polar point_1              (rads 0) lenght_1))
  (setq point_4 (polar initial_point        (rads 0) (+ lenght_1 lenght_2)))
  (setq point_3 (polar point_4              (rads 90) (/ menor_diam_mm 2)))
  (setq point_5 (polar point_4              (rads 270) (/ menor_diam_mm 2)))
  (setq point_7 (polar initial_point        (rads 270) (/ mayor_diam_mm 2)))
  (setq point_6 (polar point_7              (rads 0) lenght_1))

;   (setq b_point_0 (polar point_1 (rads 0) (/ lenght_1 2)))
;   (setq b_point_1 (polar b_point_1 (rads 45 menor_diam_mm))

  (command "_line" initial_point point_1 "")
  (command "_line" initial_point point_7 "")
  (command "_line" point_7 point_6 "")
  (command "_line" point_1 point_2 "")
  (command "_line" point_6 point_2 "")
  (command "_line" point_4 point_3 "")
  (command "_line" point_4 point_5 "")
  (command "_line" point_2 point_3 "")
  (command "_line" point_6 point_5 "")
;   (command "_line" b_point_0 b_point_1)

  
) ; lisp ends