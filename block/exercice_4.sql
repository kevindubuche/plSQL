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

-- 4.1 Définir un curseur. Contrôler le curseur avec OPEN-FETCH-CLOSE
-- utiliser la boucle perpétuelle LOOP ... END LOOP. Comment sortir de la boucle
-- utiliser la boucle WHILE condition LOOP ... END LOOP. Quelle est la condition de sortie dans cette
-- boucle
 DECLARE
	lp pilote%rowtype;
	adresse	pilote.adr%type:='Paris';
	cursor c1 is select pl#, plnom, dnaiss, adr, tel, sal 
	from pilote where adr=adresse;
	trouve boolean:=false;
BEGIN
	open c1;
	fetch c1 into lp.pl#, lp.plnom, lp.dnaiss,
			lp.adr, lp.tel, lp.sal;
	while c1%found
	LOOP
		trouve:=true;
		dbms_output.put_line('Numero pilote  :'|| lp.pl#);
		dbms_output.put_line('Nom pilote     :'|| lp.plnom);
		dbms_output.put_line('Salaire pilote :'|| lp.sal);
        dbms_output.put_line('---------');
		fetch c1 into lp.pl#, lp.plnom, lp.dnaiss,
			lp.adr, lp.tel, lp.sal;

	end loop;
	
	close c1;
	if trouve= false THEN
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
			
end;

-- 4.2 Définir un curseur. Controler le curseur avec la boucle FOR element IN ...
-- Tester le programme avec les villes de villes de : Paris puis Lilles

DECLARE

	adresse	pilote.adr%type:='Paris';
	cursor c1 is select pl#, plnom, dnaiss, adr, tel, sal 
	from pilote where adr=adresse;
	trouve boolean:=false;
    BEGIN
	for lp in c1
	LOOP
		trouve:=true;
		dbms_output.put_line('Numero pilote  :'|| lp.pl#);
		dbms_output.put_line('Nom pilote     :'|| lp.plnom);
		dbms_output.put_line('Salaire pilote :'|| lp.sal);
        dbms_output.put_line('---------');
	end loop;

	if trouve= false THEN
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
			
end;