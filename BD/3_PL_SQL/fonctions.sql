create or replace function isResponsable(idU utilisateur.id_user%type,id_ens enseignement.id_enseignement%type) return boolean AS
	 resp boolean;
	 id_prof formation.id_prof_responsable%type;
	BEGIN
	  select id_prof_responsable into id_prof
	  from formation natural join semestre natural join enseignement
	  where id_ens=enseignement.id_enseignement;

		if id_prof=idU then
			resp:=true;
		end if;

	  return resp;
	END;