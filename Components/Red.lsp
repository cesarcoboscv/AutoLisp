(defun c:reduct ()
  ;Deleting commands
;   (setvar "cmdecho" 0)

; Getting mayor diameter
(setq Dma (getreal "Introduce el diámetro mayor(in): ")) (terpri)
(setq Dmn (getreal "introduce el diámetro menor(in): ")) (terpri)
(setq h (getreal "introduce la altura(mm): ")) (terpri)

(setq Dma_mm (* Dma 25.4))
(setq Dmn_mm (* Dmn 25.4))
(setq Rad_ma (/ Dma_mm 2))
(setq Rad_mn (/ (/ Dmn_mm 2)))

(setq g1 (sqrt (+ (expt (/ (* Rad_mn h) (- Rad_ma Rad_mn)) 2 ) (expt Rad_mn 2))))
(setq g2 (sqrt (+ (expt (- Rad_ma Rad_mn) 2) (expt h 2) )))
(setq gt (+ g1 g2))

(setq ang (* (/ Dma_mm gt) 180))

(print g1)
(print g2)
(print ang)

;   (setq centerp(strcat"0" "," "0"))
;   (setq ndp (strcat"200" "," "0"))
;   ;
;   (command "_circle" centerp ndp)

) ;LISP end
