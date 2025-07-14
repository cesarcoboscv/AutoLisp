;****************************************************************************************************************************

;	komondormrex, jul 2023

;****************************************************************************************************************************

(defun crd (in_list)
	(reverse (cdr (reverse in_list)))
)

;****************************************************************************************************************************

(defun c:dynamic_multiple_copy (/ copy_index command_finished original_copy_instance copied_set base_point second_point
				  copy_distance error_ocurred copied_point current_copy_index
			       )
	(setq copy_index 0
		  original_copy_instance (mapcar 'vlax-ename->vla-object (vl-remove-if 'listp (mapcar 'cadr (ssnamex (ssget)))))
		  copied_set (list (list copy_index original_copy_instance))
		  base_point (getpoint "\nPick base point: ")
		  second_point (getpoint base_point "\nPick second point: ")
		  copy_distance (distance base_point second_point)
	)
	(while (not command_finished)
		   (setq error_ocurred (if (vl-catch-all-error-p (setq grread_data (vl-catch-all-apply 'grread (list t 12 0)))) t nil))
		   (redraw)
	       	   (cond
			(
				error_ocurred
					(prompt "\nCommand cancelled")
					(mapcar 'vla-erase (apply 'append (mapcar 'cadr (cdr copied_set))))
					(setq command_finished t)
			)
			(
				(= 5 (car grread_data))
					(grdraw base_point
							(setq copied_point (inters base_point
						    				   second_point
						    				   (cadr grread_data)
						    				   (polar (cadr grread_data) (+ (* 0.5 pi) (angle base_point second_point)) 1)
						    				   nil
									   )
						    )
							1
					)
					(cond
						(
							(and
								 (< (car (last copied_set)) (setq current_copy_index (fix (/ (distance base_point (cadr grread_data)) copy_distance))))
								 (null (assoc current_copy_index copied_set))
							)
								(repeat (- current_copy_index (car (last copied_set)))
									(foreach object (setq copied_instance (mapcar 'vla-copy original_copy_instance))
										(vla-move object (vlax-3d-point (trans base_point 1 0))
														 (vlax-3d-point (trans (polar base_point
														 							  (angle base_point copied_point)
																					  (* (setq added_copy_index (1+ (car (last copied_set)))) copy_distance)
																			   )
																			   1 0
																		)
														 )
										)
									)
									(setq copied_set (append copied_set (list (list added_copy_index copied_instance))))
								)
						)
						(
							t
								(repeat (- (car (last copied_set)) current_copy_index)
									(mapcar 'vla-erase (cadr (last copied_set)))
									(setq copied_set (crd copied_set))
								)
						)
					)
			)
			(
				(= 3 (car grread_data))
					(setq command_finished t)
			)
			(
				t
					(prompt "\nWrong key pressed!")
			)
		   )
	)
	(princ)
)

;****




