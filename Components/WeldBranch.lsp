(defun c:weld ()
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
  (setq lenght (+ (* branch_diam_mm 2) 381))

  ;Setting body's inlet and outlet center
  (setq lenght_point_2 (/ mayor_diam_mm 2))
  (setq lenght_point_5 (/ menor_diam_mm 2))


  ;=============
  ;Body's branch
  ;=============
 
  ;Points used for draw the body of the branch
  ;These points are calculated initializing with p0 (Point 0), with polar cordinates

    (setq point_2      (polar  initial_point       (rads 90)    lenght_point_2))
    (setq point_3      (polar  initial_point       (rads 90)    mayor_diam_mm))  
    (setq point_4      (polar  point_2       (rads 0)     lenght ))
    (setq point_5      (polar  point_4       (rads 90)    lenght_point_5))
    (setq point_6      (polar  point_5       (rads 270)   menor_diam_mm)) 
     
  ;setting the midpoint between branch (minor diameter) inlet  
  ;distance between initual point divided in 2, and using the angle bewtween point_3 an point_5 (body's branch inclination) for get the midpoint, this is the center of the branch
    (setq point_8     (polar  point_3       (angle point_3 point_5) (/ (distance initial_point point_6) 2)))


  ;========================
  ;Calculating hypotenuse
  ;========================
  ;Angle's cosine
    (setq cosAng (cos (rads (- 45  (- 360 (degr(angle point_3 point_5)))))))

  ;Hypotenuse
    (setq hypotenuse (/ (/ branch_diam_mm 2) cosAng))

  ;Central point of the inlet (minor diameter) branch, this will used for the center line of the branch(minor diameter)
    (setq mid_point      (polar  point_2        (rads 0) (/ lenght 2)))
  
  ;second hypotenuse, this is used for the center line of the branch(minor diameter)   
    (setq aux_hypotenuse (/ (distance point_8 mid_point) (cos (rads 45))))

  ;Setting the initial points of the branch (minor diameter)
    (setq point_9 (polar point_8 (angle point_5 point_3) hypotenuse))
    (setq point_10 (polar point_8 (angle point_3 point_5) hypotenuse))
    (setq point_11 (polar point_10 (rads 45) branch_lenght))
    (setq point_12 (polar point_11 (rads 135) branch_diam_mm))

  ;Branch center line
    (setq point_13 (polar point_11 (rads 135) (/ branch_diam_mm 2)))
    (setq point_14 (polar point_8 (rads 225) aux_hypotenuse))
  
                      
  ;==============
  ;Drawing branch
  ;==============
  (command "_pline"  initial_point  point_3 point_9 point_12 point_11 point_10 point_5 point_6 initial_point "")

                      
  ;==================
  ;Drawing centerline
  ;==================
  (command "_line" point_14 point_13 "") 
  (command "_line" point_2 point_4 "")

) ;LISP end
