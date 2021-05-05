(defun c:Yeen ()
  ;Deleting commands
  (setvar "cmdecho" 0)
  
  ;it is for inital variables for begin to calculate
  (setq Dma (getreal "Introduce el Diametro Mayor(In): "))
  (setq Dme (getreal "Introduce el Diametro Menor(In): "))
  (setq Din (getreal "Introduce el Diametro del Injerto (In): "))
  
  ;Insertion point, from here it starts to draw
  (setq p0 (getpoint "Punto de inserción: "))
  

   ;Funtion for convert degrade to Radians
  (defun Angu (A)
    (* pi (/ A 180.0))
  ) ;The funtion ends here
  
 
  
 
  ;Convirtiing Inches to mm
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
    (setq p4      (polar  p2       (Angu 0)     Largo))
    (setq p5      (polar  p4       (Angu 90)    LargoP5))
    (setq p6      (polar  p5       (angu 270)   Dmemm))
    
   
  ;Aquí se dibujan las líneas
  (command "_line"  p5  p6  "")
  (command "_line"  p0  p3  "")
  (command "_line"  p3  p5  "")
  (command "_line"  p0  p6  "")
     
  
    ;Aquí va el código para dibujar los injertos


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