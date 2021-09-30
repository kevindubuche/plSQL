-- Ecrire une procédure stockée PL/SQL qui permet de
--  modifier le salaire d’un pilote connaissant son numéro.

-- Voici le prototype de la fonction :
-- -	Procedure  updateSalairePilote(piloteId	IN number, 
-- 		nouveauSal IN number);

-- Si le pilote n’existe pas, lever une erreur avec 
-- le message : Le pilote nr. X n’existe pas.

-- Tester le programme avec les numéros suivants : 
-- Pl#= 1 puis pl#= 200

SET SERVEROUTPUT ON
create or replace Procedure  updateSalairePilote
(piloteId IN  number, nouveauSal IN number) is 
	lp pilote%rowtype;
	badSalaire Exception;
    rec_count NUMBER := 0;
	PRAGMA EXCEPTION_INIT(badSalaire, -02290);
    BEGIN
    update pilote 
    set	sal=nouveauSal
    where pl# = piloteId;

    select count(*) 
    into rec_count  
    from pilote  
    WHERE pl# = piloteId;
	if rec_count = 0 then 
		raise no_data_found;
    end if;
	
	EXCEPTION
      WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Le pilote Nr '|| piloteId ||
                ' n''existe pas');
                dbms_output.put_line('sqlcode ='||sqlcode);
                dbms_output.put_line('sqlerrm ='||sqlerrm);

		WHEN badSalaire THEN
			raise;
		WHEN Others THEN
			raise;
END;
/
DECLARE
	piloteId pilote.pl#%type := 1;
    nouveauSal pilote.sal%type := 6700;
	badSalaire Exception;
	PRAGMA EXCEPTION_INIT(badSalaire, -02290);
BEGIN
	updateSalairePilote(piloteId,nouveauSal);
	EXCEPTION
		WHEN DUP_VAL_ON_INDEX THEN
			dbms_output.put_line('Violation de la contrainte unique');
			dbms_output.put_line('sqlcode='||sqlcode);
			dbms_output.put_line('sqlerrm='||sqlerrm);
	
		WHEN badSalaire THEN
			dbms_output.put_line('Salaire incorrect');
			dbms_output.put_line('sqlcode='||sqlcode);
			dbms_output.put_line('sqlerrm='||sqlerrm);

		WHEN Others THEN
			dbms_output.put_line('erreur général');
			dbms_output.put_line('sqlcode='||sqlcode);
			dbms_output.put_line('sqlerrm='||sqlerrm);

END;
select * from pilote where pl# = 1;