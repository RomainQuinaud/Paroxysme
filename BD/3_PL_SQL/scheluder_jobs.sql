begin
  dbms_scheduler.create_job (
    job_name => 'MAJ_SEMESTERS',  -- Choose some name. 
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin Fonctions_Utiles.open_semester; Fonctions_Utiles.close_semester; insertIntoLog; end;',
    start_date => SYSDATE,
    repeat_interval => 'FREQ=DAILY; BYHOUR=1;BYMINUTE=0;BYSECOND=0',
    enabled => TRUE,
    comments => 'Daily update of semesters'
    );
end;
/


-- Run pour voir si il fonctionne

begin
  dbms_scheduler.run_job(MAJ_SEMESTERS);
end;
/

-- Creation d'une table de log et d'une procédure pour voir dans quelques jours s'il se lance correctement à l'heure dite
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




begin
  dbms_scheduler.create_job (
    job_name => 'TEST',  -- Choose some name. 
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin Fonctions_Utiles.open_semester; Fonctions_Utiles.close_semester; insertIntoLog; end;',
    start_date => SYSDATE,
    repeat_interval => 'FREQ=MINUTELY; BYHOUR=12;BYMINUTE=21;BYSECOND=0',
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