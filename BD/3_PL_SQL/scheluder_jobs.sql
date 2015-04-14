begin
  dbms_scheduler.create_job (
    job_name => 'MAJ_SEMESTERS',  -- Choose some name. 
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin Fonctions_Utiles.open_semester; Fonctions_Utiles.close_semester; insertIntoLog; end;',
    start_date => SYSDATE,
    repeat_interval => 'FREQ=DAILY',
    enabled => TRUE,
    comments => 'Daily update of semesters'
    );
end;
/


-- Tests Unitaires

-- Creation d'une table de log et d'une procédure pour voir dans quelques jours s'il se lance correctement à l'heure dite
/*
CREATE TABLE LOG_SCHELUDER (
  Date_du_Jour VARCHAR2(100),
  Message VARCHAR2(30)
  );
/ 


CREATE OR REPLACE PROCEDURE insertIntoLog IS
BEGIN
  INSERT INTO LOG_SCHELUDER VALUES(TO_CHAR(SYSTIMESTAMP), 'done');
END;
/

*/


-- Tache programmée de test (insertion toutes les minutes)

/*


begin
  dbms_scheduler.create_job (
    job_name => 'TEST',  -- Choose some name. 
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin Fonctions_Utiles.open_semester; Fonctions_Utiles.close_semester; insertIntoLog; end;',
    start_date => SYSDATE,
    repeat_interval => 'FREQ=MINUTELY',
    enabled => TRUE,
    comments => 'Daily update of semesters'
    );
end;
/


CREATE OR REPLACE PROCEDURE insertIntoLog IS
BEGIN
  INSERT INTO LOG_SCHELUDER VALUES(TO_CHAR(SYSTIMESTAMP), 'test done');
END;
/

*/