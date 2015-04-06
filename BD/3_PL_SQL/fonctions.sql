-- @Romain
-- Que fait la fonction ?
create or replace function isResponsable(idU utilisateur.id_user%type,id_ens enseignement.id_enseignement%type) return boolean AS
	 resp boolean; -- pas d'initialisation ?
	 id_prof formation.id_prof_responsable%type;
	BEGIN
	  select id_prof_responsable into id_prof
	  from formation natural join semestre natural join enseignement
	  where id_ens=enseignement.id_enseignement;

		if id_prof=idU then
			resp:=true;
		end if;

	  return resp; -- booléen initialisé directement à false ? Parce que si on ne passe pas dans le if, il n'est initialisé ni dans le bloc BEGIN ni dans le DECLARE
	END;

-- Manque test unitaires :)