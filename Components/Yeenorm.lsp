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
  
  
 
  ;Converting Inches to mm
  (setq Dmamm (* Dma 25.4))
  (setq Dmemm (* Dme 25.4))
  (setq Dinmm (* Din 25.4))
  ;lenght of the body's branch
  (setq lenght (+ (* Dinmm 2) 381))

  ;Setting body's inlet and aoutlet center
  (setq lenghtP2 (/ Dmamm 2))
  (setq lenghtP5 (/ Dmemm 2))
  
 
  ;Points used for draw the body of the branch
  ;These points are calculated initializing with p0 (Point 0), with polar cordinates
  ;Estos puntos van calculados de acuerto al punto P0, con coordenadas polares
  ;estos puntos son para dibujar solamente la reducción
    (setq p2      (polar  pInitial       (Angu 90)    lenghtP2))
    (setq p3      (polar  pInitial       (Angu 90)    Dmamm))  
    (setq p4      (polar  p2       (Angu 0)     lenght))
    (setq p5      (polar  p4       (Angu 90)    lenghtP5))
    (setq p6      (polar  p5       (Angu 270)   Dmemm))
    ;(setq p7 	  (polar  p3	   (angle p3 p5) lenghtP5))

    ; (setq lenghtP8 (distance pInitial p6))
    (setq lenghtP8a (/ (distance pInitial p6) 2))

   

    (setq p8     (polar  p3       (angle p3 p5) lenghtP8a))


    ;Coseno del angulo par calculo de hipotenusa
    ; (setq angul (angle p3 p5))
    ; (setq angl (- 45 (angle p3 p5)))
    ; (setq ango (Angu (- 45 (angle p3 p5))))
    (setq cosAng (cos(Angu(- 45 (angle p3 p5)))))
    
    ;Aquí va el código para dibujar los injertos
    ;angulo para el injerto


  ;Calculando distancia de h para primer punto de injerto
    (setq cad (/ Dinmm 2))
    (setq hypo (/ cad cosAng))

  
    (setq p9 (polar p8 (angle p5 p3) hypo))
    (setq p10 (polar p8 (angle p3 p5) hypo))
    (setq p11 (polar p10 (Angu 45) bLenght))
    (setq p12 (polar p11 (Angu 135) Dinmm))

  ;Distancia interna del injerto

  ;(setq p10 (polar p9 (Angu 45) bLenght))
  (command "_pline"  pInitial  p3 p9 p12 p11 p10 p5 p6 pInitial "")
  (command "_line" p2 p4 "") 
 ) ;Fin del LISP

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