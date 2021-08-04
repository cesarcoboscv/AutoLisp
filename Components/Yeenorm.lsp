(defun c:Yeen ()
  ;Deleting commands
  (setvar "cmdecho" 0)
  
  ;it is for inital variables for begin to calculate
  (setq Dma (getreal "Introduce el Diametro Mayor(In): "))
  (setq Dme (getreal "Introduce el Diametro Menor(In): "))
  (setq Din (getreal "Introduce el Diametro del Injerto (In): "))
  (setq Intj 300)
  
  ;Insertion point, from here it starts to draw
  (setq p0 (getpoint "Punto de inserción: "))
  

   ;Funtion for convert degrade to Radians
  (defun Angu (A)(* pi (/ A 180.0))) ;The funtion ends here
  
  
 
  ;Converting Inches to mm
  (setq Dmamm (* Dma 25.4))
  (setq Dmemm (* Dme 25.4))
  (setq Dinmm (* Din 25.4))
  ;Largo de la Yee
  (setq Largo (+ (* Dinmm 2) 381))

  ;Largo para P2
  (setq largoP2 (/ Dmamm 2))
  (setq largoP5 (/ Dmemm 2))
  
 

  
  ;Estos puntos van calculados de acuerto al punto P0, con coordenadas polares
  ;estos puntos son para dibujar solamente la reducción
    (setq p2      (polar  p0       (Angu 90)    largoP2))
    (setq p3      (polar  p0       (Angu 90)    Dmamm))  
    (setq p4      (polar  p2       (Angu 0)     largo))
    (setq p5      (polar  p4       (Angu 90)    largoP5))
    (setq p6      (polar  p5       (Angu 270)   Dmemm))
    ;(setq p7 	  (polar  p3	   (angle p3 p5) largoP5))

    (setq largoP8 (distance p0 p6))
    (setq largoP8a (/ largoP8 2))

   

    (setq p8     (polar  p3       (angle p3 p5) largoP8a))


    ;Coseno del angulo par calculo de hipotenusa
    (setq angul (angle p3 p5))
    (setq angl (- 45 angul))
    (setq ango (Angu angl))
    (setq cosang (cos ango))
    
    ;Aquí va el código para dibujar los injertos
    ;angulo para el injerto


  ;Calculando distancia de h para primer punto de injerto
    (setq cad (/ Dinmm 2))
    (setq hipo (/ cad cosang))

  
    (setq p9 (polar p8 (angle p5 p3) hipo))
    (setq p10 (polar p8 (angle p3 p5) hipo))
    (setq p11 (polar p10 (Angu 45) IntJ))
    (setq p12 (polar p11 (Angu 135) Dinmm))

  ;Distancia interna del injerto

  ;(setq p10 (polar p9 (Angu 45) IntJ))
  (command "_line"  p0  p3  "")
  (command "_line"  p3  p9  "")
  (command "_line"  p9  p12  "")
  (command "_line"  p12  p11  "")
  (command "_line"  p11 p10  "")
  (command "_line"  p10 p5 "")	 
  (command "_line"  p5 p6 "")
  (command "_line"  p6 p0  "")

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