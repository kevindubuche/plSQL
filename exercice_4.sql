-- Exercice 4
-- Ecrire un programme PL/SQL qui permet d'afficher le numéro, le nom, la date de naissance, l'adresse,
-- le salaire et le téléphone des pilotes habitant une ville donnée.
-- S’il n’ya aucun pilote dans la dite ville, afficher un message d’erreur. Pas de Pilote dans cette ville.

SET SERVEROUTPUT ON
DECLARE
    lp pilote%ROWTYPE;
    adresse pilote.adr%TYPE := 'Nice';
   cursor c1 is select * from pilote where adr=adresse;
	trouve boolean:=false;
BEGIN
    OPEN c1;
        LOOP
            fetch c1 into lp.pl#, lp.plnom, lp.dnaiss,
                lp.adr, lp.tel, lp.sal;
            EXIT WHEN c1%notfound;
            trouve := TRUE;
            dbms_output.put_line('Numero pilote  :'|| lp.pl#);
            dbms_output.put_line('Nom pilote     :'|| lp.plnom);
            dbms_output.put_line('Date de naissance pilote :'|| lp.dnaiss);
            dbms_output.put_line('Adresse pilote :'|| lp.adr);
            dbms_output.put_line('-----------------');
        END LOOP;
    CLOSE c1;
    if trouve = false THEN
		raise no_data_found;
	end if;
    EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			dbms_output.put_line('L''adresse '|| adresse ||
			' n''existe pas');
			dbms_output.put_line('sqlcode ='||sqlcode);
			dbms_output.put_line('sqlerrm ='||sqlerrm);
		WHEN OTHERS THEN
            dbms_output.put_line('Ce n''est pas vous c''est nous');
                dbms_output.put_line('sqlcode ='||sqlcode);
                dbms_output.put_line('sqlerrm ='||sqlerrm);

END;