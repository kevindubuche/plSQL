-- Ecrire une procédure stockée qui permet de renvoyer 
-- la référence vers un  curseur contenant le numéro, 
-- le nom, la date de naissance, l'adresse, le salaire 
-- et le téléphone des pilotes habitant une adresse donnée.

-- Créer pour cela un package contenant un type REF CURSOR générique :
-- CREATE OR REPLACE PACKAGE Pk_refCursType AS
-- TYPE REFCURSTYPE	IS REF CURSOR;
-- End;
-- /
-- Voici le prototype de la fonction :
-- -	function  getPiloteByAdr(adresse	IN VARCHAR2)  
-- 	return Pk_refCursType.REFCURSTYPE ;

-- Tester le programme avec les villes de villes de : Paris puis Lilles. 
-- S’il n’ya aucun pilote dans la dite ville, afficher un message d’erreur. 
-- Pas de Pilote dans cette ville.

SET SERVEROUTPUT ON
CREATE OR REPLACE PACKAGE Pk_refCursType AS
TYPE REFCURSTYPE	IS REF CURSOR;
function  getPiloteByAdr(adresse	IN VARCHAR2)  
	return Pk_refCursType.REFCURSTYPE ;
end Pk_refCursType;

CREATE OR REPLACE FUNCTION getPiloteByAdr (adresse IN VARCHAR2)
    RETURN Pk_refCursType.REFCURSTYPE IS
    c1 Pk_refCursType.REFCURSTYPE;
    begin
    open c1
        for SELECT pl#, plnom, dnaiss, adr, tel, sal
            from pilote where adr=adresse;       
        return c1;
    END;
  DECLARE
        adresse	pilote.adr%type:='Paris';
        cursorListPilotes Pk_refCursType.REFCURSTYPE;
         unPilote  pilote%rowtype;
        BEGIN
            
            cursorListPilotes := getPiloteByAdr(adresse);
            LOOP
                fetch cursorListPilotes into unPilote;
                exit when cursorListPilotes%notfound;
                dbms_output.put_line('Numero pilote  :'|| unPilote.pl#);
                dbms_output.put_line('Nom pilote     :'|| unPilote.plnom);
                dbms_output.put_line('Salaire pilote :'|| unPilote.sal);
                dbms_output.put_line('---------');
            end loop;
            EXCEPTION 
                WHEN OTHERS THEN
                    raise ;
        END;
