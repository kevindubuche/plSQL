-- Exercice 3
-- Ecrire un programme PL/SQL qui permet d’affecter le salaire de 23000 à tous les pilotes qui habitent
-- dans une ville donnée.
-- Si aucun pilote n’y habite, afficher un message d’erreur. Aucun pilote dans cette ville
-- Tester le programme avec les numéros suivants :
-- adr= 'Nice' puis adr= 'Louvain'

SET SERVEROUTPUT ON
select * from pilote where adr='Nice';
DECLARE
    salaire pilote.sal%TYPE := 23000;
    adresse pilote.adr%TYPE := 'Nice';
    badAdresse EXCEPTION;
	PRAGMA EXCEPTION_INIT(badAdresse, -20000);
BEGIN
    UPDATE pilote
    SET sal = salaire
    WHERE adr = adresse;

    IF SQL%ROWCOUNT = 0 THEN
        	RAISE_APPLICATION_ERROR(-20000, 'Il n''y a aucun pilote '||
		' à l''adresse ' || adresse);
    END IF;
    EXCEPTION
		WHEN badAdresse THEN
			dbms_output.put_line('sqlcode='||sqlcode);
			dbms_output.put_line('sqlerrm='||sqlerrm);

END;
select * from pilote where adr='Nice';