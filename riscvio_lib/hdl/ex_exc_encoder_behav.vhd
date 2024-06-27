ARCHITECTURE behav OF ex_exc_encoder IS
  signal stage_exc: exc_cause_T;
BEGIN
  stage_exc <= sterr when state_err_a_exc or state_err_b_exc else
               frtyp when frame_type_exc else
               ixoob when ixoob_exc else
               well_behaved;

  exc <= stage_exc when exc_cause_T'pos(stage_exc) <= exc_cause_T'pos(prev_exc) else prev_exc;
               
END ARCHITECTURE behav;

