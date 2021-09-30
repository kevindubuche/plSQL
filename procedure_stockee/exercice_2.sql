-- Ecrire une  procédure stockée PL/SQL qui permet 
-- d’insérer un nouveau pilote dans la base. 
-- La fonction reçoit en paramètre la structure 
-- d’un pilote (pilote%rowtype) et ne renvoie rien.

-- Voici le prototype de la fonction :
-- -	Procedure  insertPilote(lignePilote 
-- 	IN  PILOTE%ROWTYPE);

-- Vous devez effectuer un maximum de contrôle 
-- avant d’insérer le pilote dans la base :
-- 1)	Le numéro, le nom, l’adresse et le salaire 
-- 	du pilote sont obligatoires. Pas de valeur nulle. 
-- 	Lever une exception en cas de violation de cette contrainte.
-- 2)	Le salaire doit toujours être inférieur à 70000. Lever une exception en cas de violation de cette erreur.
-- 3)	Lever une exception en cas de duplication du numéro ou du nom du pilote
-- 4)	Lever une exception pour toutes autres erreurs non identifiées


-- Tester le programme avec un pilote de nom ‘Bill’. 
-- Provoquer la levée de chacune des erreurs définies plus haut.
SET SERVEROUTPUT ON
create or replace Procedure  insertPilote(lignePilote 
	IN  PILOTE%ROWTYPE) is 
	lp pilote%rowtype;
	badSalaire Exception;
	PRAGMA EXCEPTION_INIT(badSalaire, -02290);
    BEGIN
    insert into pilote 
	values (lignePilote.pl#, lignePilote.plnom, 
	lignePilote.dnaiss,lignePilote.adr,lignePilote.tel,
	lignePilote.sal);
	
	EXCEPTION
		WHEN DUP_VAL_ON_INDEX THEN
			raise;
		WHEN badSalaire THEN
			raise;
		WHEN Others THEN
			raise;
END;
/
DECLARE
	lp pilote%rowtype;
	badSalaire Exception;
	PRAGMA EXCEPTION_INIT(badSalaire, -02290);
BEGIN
	lp.pl#:=22;
	lp.plnom:='Benmoussa';
	lp.dnaiss:= to_date('11-11-1957','DD-MM-YYYY'); 
	lp.adr:='Lyon';
	lp.tel:='054444444';
	lp.sal:=20000;
	insertPilote(lp);
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