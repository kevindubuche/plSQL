-- Ecrire une function stockée PL/SQL qui permet 
-- d'afficher le numéro, le nom, la date de naissance, 
-- l'adresse, le salaire et le téléphone.

-- Elle reçoit en paramètre un numéro de Pilote.

-- Elle renvoie la structure d’un pilote.
 
-- Voici le prototype de la fonction :
-- - Function getPiloteById(piloteId	
-- IN number) return pilote%rowtype ;

-- Si le pilote n’existe lever une erreur avec 
-- le message suivant : Le Pilote nr. X est inexistant

-- Tester la procédure stockée  avec 
-- les numéros suivants : 1 puis 100

SET SERVEROUTPUT ON
CREATE OR REPLACE FUNCTION getPiloteById (piloteId IN NUMBER)
    RETURN pilote%ROWTYPE IS
    lp pilote%rowtype;
        BEGIN
            SELECT pl#, plnom, dnaiss, adr, tel, sal
                INTO lp.pl#, lp.plnom, lp.dnaiss, lp.adr, lp.tel, lp.sal
                from pilote where pl#=piloteId;
                return lp;
            EXCEPTION 
                WHEN OTHERS THEN
                    raise ;
        END;
        /
        DECLARE
            lp pilote%rowtype;
            plnum	pilote.pl#%type:=1;
        BEGIN
            lp:=getPiloteById(plnum);
            dbms_output.put_line('Numero pilote  :'|| lp.pl#);
            dbms_output.put_line('Nom pilote     :'|| lp.plnom);
            dbms_output.put_line('Salaire pilote :'|| lp.sal);
            	EXCEPTION 
                    WHEN NO_DATA_FOUND THEN
                        dbms_output.put_line('Le pilote Nr '|| plnum ||
                        ' n''existe pas');
                        dbms_output.put_line('sqlcode ='||sqlcode);
                        dbms_output.put_line('sqlerrm ='||sqlerrm);
                    WHEN OTHERS THEN
                        dbms_output.put_line('Ce n''est pas vous c''est nous');
                        dbms_output.put_line('sqlcode ='||sqlcode);
                        dbms_output.put_line('sqlerrm ='||sqlerrm);
                        
        END;
/

