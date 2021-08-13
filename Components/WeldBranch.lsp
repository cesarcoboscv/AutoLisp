(defun c:Yeen ()
  ;Deleting commands
  (setvar "cmdecho" 0)
  
  ;it is for inital variables for begin to calculate
  (setq Dma (getreal "Introduce el Diametro Mayor(In): "))
  (setq Dme (getreal "Introduce el Diametro Menor(In): "))
  (setq Din (getreal "Introduce el Diametro del Injerto (In): "))
  (setq bLenght 300)
  
  ;Insertion point, from here it starts to draw
  (setq pInitial (getpoint "Punto de inserción: "))
  

   ;Funtion for convert degrade to Radians
  (defun Angu (A)(* pi (/ A 180.0))) ;The funtion ends here
  (defun grados (rad) (* (/ rad pi) 180.0));_fin de defun
  
 
  ;Converting Inches to mm
  (setq Dmamm (* Dma 25.4))
  (setq Dmemm (* Dme 25.4))
  (setq Dinmm (* Din 25.4))
  ;lenght of the body's branch
  (setq lenght (+ (* Dinmm 2) 381))

  ;Setting body's inlet and outlet center
  (setq lenghtP2 (/ Dmamm 2))
  (setq lenghtP5 (/ Dmemm 2))
  
      
      ;=============
      ;Body's branch
      ;=============
 
  ;Points used for draw the body of the branch
  ;These points are calculated initializing with p0 (Point 0), with polar cordinates

    (setq p2      (polar  pInitial       (Angu 90)    lenghtP2))
    (setq p3      (polar  pInitial       (Angu 90)    Dmamm))  
    (setq p4      (polar  p2       (Angu 0)     lenght))
    (setq p5      (polar  p4       (Angu 90)    lenghtP5))
    (setq p6      (polar  p5       (Angu 270)   Dmemm))
  
     
     
  ;setting the midpoint between branch (minor diameter) inlet
      
  ;distance between initual point divided in 2, and using the angle bewtween p3 an p5 (body's branch inclination) for get the midpoint, this is the center of the branch
    (setq p8     (polar  p3       (angle p3 p5) (/ (distance pInitial p6) 2)))


  ;========================
   ;Calculating hypotenuse
  ;========================

  ;Angle's cosine
    (setq cosAng (cos (Angu (- 45  (- 360 (grados(angle p3 p5)))))))

  ;Hypotenuse
    (setq hypo (/ (/ Dinmm 2) cosAng))
  ;Central point of the inlet (minor diameter) branch, this will used for the center line of the branch(minor diameter)
    (setq pc      (polar  p2        (Angu 0) (/ lenght 2)))
  
  ;second hypotenuse, this is used for the center line of the branch(minor diameter)   
    (setq hypo2 (/ (distance p8 pc) (cos (Angu 45))))

  ;Setting the initial points of the branch (minor diameter)
    (setq p9 (polar p8 (angle p5 p3) hypo))
    (setq p10 (polar p8 (angle p3 p5) hypo))
    (setq p11 (polar p10 (Angu 45) bLenght))
    (setq p12 (polar p11 (Angu 135) Dinmm))
  

  ;Branch center line
    (setq p13 (polar p11 (Angu 135) (/ Dinmm 2)))
    (setq p14 (polar p8 (Angu 225) hypo2))
  
                      
  ;==============
  ;Drawing branch
  ;==============
  (command "_pline"  pInitial  p3 p9 p12 p11 p10 p5 p6 pInitial "")

                      
  ;==================
  ;Drawing centerline
  ;==================
  (command "_line" p14 p13 "") 
  (command "_line" p2 p4 "")

 ) ;LISP end

;    /\___/\
;   /       \
;  l  u   u  l
;--l----*----l--
;   \   w   /     - Quack!
;     ======
;   /       \ __
;   l        l\ \
;   l        l/ /  
;   l  l l   l /
;   \ ml lm /_/