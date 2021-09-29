-- Exercice 2
-- Ecrire un programme PL/SQL qui permet d’insérer un nouveau pilote dans la base.
-- insert into pilote values(22, nomPilote , to_date( '04-08-1966', 'DD-MM-YYYY') , 'Nice', null,
-- 23000.6);
-- Si le pilote n’est pas créé, afficher un message d’erreur.
-- Tester le programme avec les noms suivants :
-- nomPilote= 'Bill' puis nomPilote= 'Barak'

--Exercice 2
SET SERVEROUTPUT ON
DECLARE
    lp pilote%ROWTYPE;
    badSalaire EXCEPTION;
    PRAGMA EXCEPTION_INIT(badSalaire, -02290);
BEGIN
    lp.pl#:=22;
	lp.plnom:='Benmoussa';
	lp.dnaiss:= to_date('04-08-1966','DD-MM-YYYY'); 
	lp.adr:='Nice';
	lp.tel:='054444444';
	lp.sal:=20000;
	insert into pilote 
	values (lp.pl#, lp.plnom, lp.dnaiss,lp.adr,lp.tel,lp.sal);
	
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