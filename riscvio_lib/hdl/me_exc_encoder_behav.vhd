ARCHITECTURE behav OF me_exc_encoder IS
  signal stage_exc: exc_cause_T;
BEGIN
  stage_exc <= hpovf when heap_overflow else
               stovf when stack_overflow else
               well_behaved;

  exc <= stage_exc when exc_cause_T'pos(stage_exc) <= exc_cause_T'pos(prev_exc) else prev_exc;
               
END ARCHITECTURE behav;

