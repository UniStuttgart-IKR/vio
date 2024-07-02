ARCHITECTURE behav OF ex_exc_encoder IS
  signal stage_exc: exc_cause_T;
BEGIN
  stage_exc <= sterr when state_err_pgu_exc or state_err_dbu_exc else
               tciob when target_bounds_exc else
               ixoob when ixoob_exc else
               frtyp when frame_type_exc else
               ptari when pointer_arith_exc else
               hpovf when heap_overflow_exc else
               stovf when stack_overflow_exc else
               well_behaved;

  exc <= stage_exc when exc_cause_T'pos(stage_exc) <= exc_cause_T'pos(prev_exc) else prev_exc;
               
END ARCHITECTURE behav;

