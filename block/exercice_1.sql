-- Exercice 1
-- Ecrire un programme PL/SQL qui permet d'afficher le numéro, le nom, la date de naissance, l'adresse,
-- le salaire et le téléphone d’un pilote connaissant son numéro.
-- Si pilote n’existe pas afficher un message d’erreur. Pilote inexistant
-- Saisissez en interactif le numéro de pilote pour lequel on souhaite afficher les informations.
-- Tester le programme avec les numéros suivants : 1 puis 100

ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YYYY';
ALTER SESSION SET NLS_DATE_LANGUAGE='AMERICAN';

REM Creation de la base de donnees aerienne

DROP TABLE pilote CASCADE CONSTRAINTS;
CREATE TEBLE pilote(
    pl#     NUMBER(4)       CONSTRAINT pk_pilote PRIMARY KEY,
    plnom   VARCHAR(12)     CONSTRAINT nl_pilote_plnom NOT NULL CONSTRAINT uk__pilote_plnom UNIQUE,
    dnaiss  DATE            CONSTRAINT nl_pilote_dnaiss NOT NULL,
    adr     VARCHAR2(20)    DEFAULT 'Paris',
    tel     VARCHAR2(12),
    sal     NUMBER(7,2)     CONSTRAINT nl_pilote_sal NOT NULL CONSTRAINT chk_pilote_sal CHECK(sal < 70000.0)
);

REM insertion des valeurs dans les tables       

insert into  pilote values(1, 'Miranda', '16-AUG-1952','Sophia-Antipolis', '93548254', 18009.0);
insert into  pilote values(2, 'St-exupery', '16-OCT-1932', 'Lyon', '91548254', 12300.0);
insert into  pilote values(3, 'Armstrong ', '11-MAR-1930', 'Wapakoneta','96548254', 24500.0);
insert into  pilote values(4, 'Tintin', '01-AUG-1929', 'Bruxelles','93548254', 21100.0);
insert into  pilote values(5, 'Gagarine', '12-AUG-1934', 'Klouchino','93548454', 22100.0);
insert into  pilote values(6, 'Baudry', '31-AUG-1959', 'Toulouse','93548444', 21000.0);
insert into  pilote values(8, 'Bush', '28-FEB-1924', 'Milton','44556254', 22000.0);
insert into  pilote values(9, 'Ruskoi', '16-AUG-1930', 'Moscou','73548254', 22000.0);
insert into  pilote values(10, 'Math', '12-AUG-1938', 'Paris', '23548254', 15000.0);
insert into  pilote values(11, 'Yen', '19-SEP-1942', 'Munich','13548254', 29000.0);
insert into  pilote values(12, 'Icare', '17-DEC-1962', 'Ithaques','73548211', 17000.6);
insert into  pilote values(13, 'Mopolo', '04-NOV-1955', 'Nice','93958211', 17000.6);
insert into  pilote values(14, 'Chretien', '04-NOV-1945', '','73223322', 15000.6);
insert into  pilote values(15, 'Vernes', '04-NOV-1935', 'Paris', '',17000.6);
insert into  pilote values(16, 'Tournesol', '04-AUG-1929', 'Bruxelles','', 15000.6);
insert into  pilote values(17, 'Concorde', '04-AUG-1966', 'Paris', '',21000.6);
insert into  pilote values(18, 'Foudil', '04-AUG-1966', 'Paris', '',21000.6);
insert into  pilote values(19, 'Foudelle', '04-AUG-1966', 'Paris', '',21000.6);
insert into  pilote values(20, 'Zembla', '04-AUG-1966', 'Paris', '',21000.6);


--Exercice 1
SET SERVEROUTPUT ON
DECLARE
  	numero pilote.pl#%TYPE;
	nom pilote.plnom%TYPE;
	dateNaiss pilote.dnaiss%TYPE;
	adresse pilote.adr%TYPE;
	telephone pilote.tel%TYPE;
	salaire pilote.sal%TYPE;
	plnum	pilote.pl#%TYPE:=10;
BEGIN
    SELECT pl#, plnom, dnaiss, adr, tel, sal
    INTO numero, nom, dateNaiss, adresse, telephone, salaire
    FROM pilote
    WHERE pl# = plnum;
    DBMS_OUTPUT.PUT_LINE('Numero pilote     :'|| numero);
    DBMS_OUTPUT.PUT_LINE('Nom pilote     :'|| nom);
    DBMS_OUTPUT.PUT_LINE('Salaire pilote     :'|| salaire);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Le pilote Nr '|| plnum || ' n''existe pas');
            DBMS_OUTPUT.PUT_LINE('sqlcode = ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('sqlerrm = ' || SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ce n''est pas vous c''est nous');
            DBMS_OUTPUT.PUT_LINE('sqlcode = ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('sqlerrm = ' || SQLERRM);
END;

--Autre facon
SET SERVEROUTPUT ON
accept x number prompt 'Enterz le numero du pilote: '
DECLARE
    temp_pilote pilote%ROWTYPE;
    plnum pilote.pl#%TYPE := 10;
BEGIN
    SELECT pl#, plnom, dnaiss, adr, tel, sal
    INTO temp_pilote.pl#, temp_pilote.plnom, temp_pilote.dnaiss, temp_pilote.adr, temp_pilote.tel, temp_pilote.sal
    FROM pilote
    WHERE pl# = &x;
    DBMS_OUTPUT.PUT_LINE('Numero pilote     :'|| temp_pilote.pl#);
    DBMS_OUTPUT.PUT_LINE('Nom pilote     :'|| temp_pilote.plnom);
    DBMS_OUTPUT.PUT_LINE('Salaire pilote     :'|| temp_pilote.sal);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Le pilote Nr '|| plnum || ' n''existe pas');
            DBMS_OUTPUT.PUT_LINE('sqlcode = ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('sqlerrm = ' || SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ce n''est pas vous c''est nous');
            DBMS_OUTPUT.PUT_LINE('sqlcode = ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('sqlerrm = ' || SQLERRM);
END;

