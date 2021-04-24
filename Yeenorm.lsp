(defun c:Yeen ()
  ;Borrando rastros
  ;(setvar "cmdecho" 0)
  
  ;Se introducen los valores iniciales de entrada para realiar cálculos
  (setq Dma (getreal "Introduce el Diametro Mayor(In): "))
  (setq Dme (getreal "Introduce el Diametro Menor(In): "))
  (setq Din (getreal "Introduce el Diametro del Injerto (In): "))
  
  ;Punto de inserción del bloque, a partir de aquí se comienza a dibujar
  (setq p0 (getpoint "Punto de inserción: "))

   ;Función para convertir angulos en radianes
  (defun Angu (A)
    (* pi (/ A 180.0))
  ) ;Aquí termina la función
  
  ;Convirtiendo pulgadas a mm
  (setq Dmamm (* Dma 25.4))
  (setq Dmemm (* Dme 25.4))
  (setq Dinmm (* Din 25.4))
  ;Largo de la Yee
  (setq Largo (+ (* Dinmm 2) 381))

  ;Largo para P2
  (setq largoP2 (/ Dmamm 2))
  
  ;Estos puntos van calculados de acuerto al punto P0, con coordenadas polares
    (setq p2      (polar p0       (Angu 90)    largoP2))
    (setq p3      (polar p0       (Angu 90)    Dmamm))  
    (setq p4      (polar p2       (Angu 0)      Largo))
   
  ;Aquí se dibujan las líneas
  ;(command "_line" p0 p2 "")
  (command "_line" p3 p0 "")
  (command "_line" p2 p4 "")
    
  
) ;Fin del LISP