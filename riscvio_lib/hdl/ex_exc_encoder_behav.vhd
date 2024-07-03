ARCHITECTURE behav OF ex_exc_encoder IS
  signal stage_exc1, stage_exc2: exc_cause_T;
BEGIN
  stage_exc1 <= pgu_exc when exc_cause_T'pos(pgu_exc) <= exc_cause_T'pos(mux_exc) else mux_exc;
  stage_exc2 <= stage_exc1 when exc_cause_T'pos(stage_exc1) <= exc_cause_T'pos(dbu_exc) else dbu_exc;

  exc <= stage_exc2 when exc_cause_T'pos(stage_exc2) <= exc_cause_T'pos(prev_exc) else prev_exc;
               
END ARCHITECTURE behav;

