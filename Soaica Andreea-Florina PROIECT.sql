DROP DATABASE IF EXISTS redactie_antena1;
CREATE DATABASE IF NOT EXISTS redactie_antena1;
USE redactie_antena1;


#cerinta 2: creare tabele

CREATE TABLE IF NOT EXISTS departamente (
	id_departament SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    denumire VARCHAR(35),
    birou VARCHAR(5)
);

CREATE TABLE IF NOT EXISTS angajati (
	id_angajat SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(40) NOT NULL,
    prenume VARCHAR(40) NOT NULL,
    data_nastere DATE,
    email VARCHAR(45) UNIQUE,
    telefon VARCHAR(20) UNIQUE,
    salariu FLOAT(7,2),
    superior_id SMALLINT,
    departament_id SMALLINT,
    FOREIGN KEY (departament_id) REFERENCES departamente (id_departament),
    FOREIGN KEY (superior_id) REFERENCES angajati (id_angajat)
);


CREATE TABLE IF NOT EXISTS parteneri (
	id_partener SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(40) NOT NULL,
    prenume VARCHAR(40) NOT NULL,
    telefon VARCHAR(20) UNIQUE,
    email VARCHAR(40) UNIQUE,
    departament_id SMALLINT,
    FOREIGN KEY (departament_id) REFERENCES departamente (id_departament)
);



CREATE TABLE IF NOT EXISTS date_parteneriat (
	id_parteneriat SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_incepere DATE NOT NULL,
    data_incheiere DATE,
    buget FLOAT(7,2),
    partener_id SMALLINT,
    FOREIGN KEY (partener_id) REFERENCES parteneri (id_partener)
);
	

CREATE TABLE IF NOT EXISTS date_de_personal (
	id_personal SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_incepere DATE NOT NULL,
    data_demisie DATE,
    status ENUM ('Activ', 'Inactiv'),
    angajat_id SMALLINT,
    FOREIGN KEY (angajat_id) REFERENCES angajati (id_angajat)
);



CREATE TABLE IF NOT EXISTS adrese (
	id_adresa SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    strada VARCHAR(55),
    numar VARCHAR(5),
    etaj VARCHAR(2),
	bloc VARCHAR(7),
    scara VARCHAR(7),
    apartament VARCHAR(4),
    oras VARCHAR(20),
    judet VARCHAR(20),
    tara VARCHAR(20) DEFAULT 'Romania',
    cod_postal VARCHAR(10),
    angajat_id SMALLINT,
    FOREIGN KEY (angajat_id) REFERENCES angajati (id_angajat)
);


CREATE TABLE IF NOT EXISTS concedii (
	id_concediu SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_incepere DATE,
    data_final DATE,
    zile_ramase_concediu VARCHAR(3)
);

#cerianta 2: drop table
DROP TABLE concedii;

#cerinta 2: alter table1
ALTER TABLE adrese
	CHANGE strada strada VARCHAR(30) NOT NULL;
    
#cerinta 2: alter table2
ALTER TABLE date_de_personal
	RENAME TO date_personal;
    
#cerinta 2: alter table3
ALTER TABLE date_parteneriat
	ADD perioada ENUM ('Determinata', 'Nedeterminata'),
    CHANGE buget buget FLOAT(7,2) NOT NULL;
    
#cerinta 2: alter table4
ALTER TABLE date_personal
	CHANGE id_personal id_personal SMALLINT NOT NULL,
    DROP PRIMARY KEY;
    
#cerinta 2: alter table5
ALTER TABLE date_personal
	CHANGE id_personal id_personal SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY;
    
#cerinta 2: alter table6
ALTER TABLE adrese
	MODIFY COLUMN oras VARCHAR(30) NOT NULL;
    
#cerinta 2: alter table7
ALTER TABLE date_personal
	MODIFY COLUMN status ENUM ('Activ', 'Inactiv') NOT NULL;
 
#cerinta 2: alter table8 
ALTER TABLE angajati
	DROP FOREIGN KEY angajati_ibfk_1,
    ADD FOREIGN KEY (departament_id) REFERENCES departamente (id_departament) ON DELETE CASCADE ON UPDATE CASCADE;
    
    
#cerinta 2: alter table9
ALTER TABLE parteneri
	DROP FOREIGN KEY parteneri_ibfk_1,
    ADD FOREIGN KEY (departament_id) REFERENCES departamente (id_departament) ON DELETE CASCADE ON UPDATE CASCADE;


#cerinta 2: alter table10
ALTER TABLE date_parteneriat
	DROP FOREIGN KEY date_parteneriat_ibfk_1,
    ADD FOREIGN KEY (partener_id) REFERENCES parteneri (id_partener) ON DELETE CASCADE ON UPDATE CASCADE;
    
#cerinta 2: alter table11    
ALTER TABLE adrese
	DROP FOREIGN KEY adrese_ibfk_1;
    
ALTER TABLE adrese
	ADD FOREIGN KEY (angajat_id) REFERENCES angajati (id_angajat) ON DELETE CASCADE;    
    
#cerinta 2: alter table12
ALTER TABLE date_personal
	DROP FOREIGN KEY date_personal_ibfk_1,
    ADD FOREIGN KEY (angajat_id) REFERENCES angajati (id_angajat) ON DELETE CASCADE;

#cerinta 3: inserturi

INSERT INTO departamente (denumire, birou)
	VALUES
    ('Director', '001'),  #1
	('Redactor-sef', '002'),  #2
    ('Producator general', '003'),  #3
    ('Editor', '004'),  #4
    ('Sef departament', '007'),  #5
    ('Prezentator', '008'),  #6
    ('Producator executiv', '005'),  #7
    ('Politic', '010'),  #8
    ('Economic', '010'),  #9
    ('Social', '010'),  #10
    ('Eveniment', '010'),  #11
    ('Sport', '010'),  #12
    ('Meteo', '010'),  #13
    ('Externe', '010'),  #14
    ('Regizor emisie', '012'),  #15
    ('Asistent de productie', '014'),  #16
    ('Sunetist', '015'),  #17
    ('Operator', '015'),  #18
    ('Producator Package', '015'),  #19
    ('Editor voce', '015'),  #20
    ('Editor imagine', '015');  #21


INSERT INTO angajati (nume, prenume, data_nastere, email, telefon, departament_id, salariu)
	VALUES
	('Dobrescu', 'Maria', '1990-12-08', 'dobrescu.maria@yahoo.com', '0724456732', 14, 2350), #externe
	('Danielescu', 'Cristi', '1992-09-09', 'cristi.dan@yahoo.com', '0732432643', 15, 3270), #regizor emisie
	('Marculescu', 'Andreea', '1995-08-25', 'deea_marculescu@yahoo.com', '0755421764', 8, 2120),  #politic
	('Alescu', 'Sabin', '1994-10-03', 'sabin_alescu@gmail.com', '0764123234', 12, 1680),  #sport
	('Badea', 'Cristian', '1976-02-11', 'badea.cristian@gmail.com', '0721764822', 3, 5620), #producator general
	('Cristescu', 'Daniela', '1964-08-11', 'cristescu_daniela@gmail.com', '0733322566', 2, 4890),  #redactor sef
	('Naftanaila', 'Georgiana', '1991-06-23', 'georgiana.naftanaila@yahoo.com', '0725543245', 4, 2710), #editor
	('Lacramioara', 'Constantina', '1993-07-14', 'lacramioara_constantina@gmail.com', '0733645112', 16, 1600), #asistent de productie
	('Cristea', 'Razvan', '1986-03-29', 'razvan.cristea@yahoo.com', '0733234643', 19, 2550), #producator package
	('Macedon', 'Bogdan', '1988-05-21', 'macedon_bogdan@yahoo.com', '0754678901', 21, 2290), #editor imagine
	('Popescu', 'Crina', '1994-02-13', 'crina_popescu@yahoo.com', '0722321432', 9, 2760),  #economic
	('Popescu', 'Anda', '1994-11-25', 'popescu.anda@gmail.com', '0742456665', 13, 2120), #meteo
	('Radulescu', 'Marian', '1956-07-10', 'radulescu_marian@yahoo.com', '0722432121', 1, 7300), #director
	('Stanciulescu', 'Daria', '1980-01-01', 'stanciulescu@yahoo.com', '0743456879', 5, 3580), #sef departament
	('Minculescu', 'Robert', '1979-01-02', 'minculescu_robert', '0721345115', 10, 2900), #social
	('Orza', 'Sebastian', '1987-09-19', 'orza.sebastian@yahoo.com', '0744532123', 14, 2350), #externe
	('Soaica', 'Andreea', '1995-08-25', 'andreea.soaica@yahoo.com', '0725531737', 7, 2935), #producator executiv
	('Vasilescu', 'Emilia', '1967-02-03', 'emilia.vasilescu@gmail.com', '0743445678', 11, 2920), #eveniment
	('Sava', 'Sabin', '1988-04-18', 'sava_sabin@yahoo.com', '0734556753', 20, 2300), #editor voce
	('Gingasu', 'Costin', '1990-01-02', 'gingasu_costin@yahoo.com', '0722134467', 18, 2410), #operator
	('Dincu', 'Florina', '1977-08-12', 'dincu_flo@gmail.ro', '0720345001', 17, 2880), #sunetist
	('Laftaru', 'Monica', '1976-09-24', 'laftaru.monica@yahoo.com', '0743567422', 10, 2310), #social
	('Ciresaru', 'Adina', '1991-02-12', 'adina.ciresaru@yahoo.com', '0744689986', 6, 3890), #prezentator
	('Anghel', 'Horia', '1980-10-30', 'anghel.horia@yahoo.com', '0733244321', 6, 4100), #prezentator
	('Rosu', 'Bianca', '1992-09-05', 'bianca_rosu@gmail.com', '0775223112', 8, 2500), #politic
	('Savulescu', 'Cristina', '1989-09-22', 'savulescu_cristina@yahoo.com', '0732233322', 4, 3100), #editor
	('Ditcov', 'Dan', '1968-04-14', 'danditcov@gmail.com', '0733989070', 18, 2520), #operator
	('Piloc', 'Mihai', '1987-05-25', 'piloc_mihai@gmail.com', '0722355211', 13, 2700), #meteo
	('Stefan', 'Teodora', '1996-07-29', 'stefan.teo@yahoo.com', '0766783331', 9, 2900), #economic
	('Nastase', 'Georgian', '1977-06-22', 'georgian_nastase@gmail.ro', '0766423223', 12, 2360), #sport
	('Marin', 'Grigore', '1987-12-01', 'laco.grigore@gmail.ro', '0734751123', 16, 3120), #asistent de productie
	('Cristescu', 'Ana', '1990-12-07', 'cristescu_ana@yahoo.com', '0722345123', 11, 2500), #eveniment
	('Niculescu', 'Sabrina', '1991-12-08', 'niculescu.sabrina@yahoo.com', '0765534432', 11, 2500), #eveniment
	('Pipa', 'Cristi', '1988-11-07', 'cristi_pipa@yahoo.com', '0722323341', 8, 2000), #politic
	('Badea', 'Lavinia', '1987-10-09', 'badea_lavinia@yahoo.com', '0754456765', 5, 4000), #sef departament
	('Puiu', 'Alexandru', '1995-08-24', 'puiu_alex@yahoo.com', '0721123765', 17, 2700), #sunetist
	('Constantini', 'Serban', '1993-02-01', 'constantini.serban', '0723642399', 18, 2570), #operator
	('Smalbergher', 'Alexandra', '1995-08-21', 'smal_alex@gmail.com', '0729989001', 18, 2650); #operator
    

    
INSERT INTO adrese (strada, numar, etaj, bloc, scara, apartament, oras, judet, tara, cod_postal, angajat_id)    
	VALUES
    ('Str. Banu Maracine', NULL, '1', 'E11', 'D', '8', 'Curtea de Arges', 'Arges', NULL, '115300', 1),
    ('Str. Valea Sasului', '28', NULL, NULL, NULL, NULL, 'Curtea de Arges', 'Arges', NULL, '115300', 2),
    ('Str. Scoala Floreasca', '24', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '122343', 3),
    ('Bd. Crizantema Rosie', NULL, '4', 'B21', 'E', '32', 'Bucuresti', NULL, NULL, '122343', 4),
    ('Str. Girofar', '30', NULL, NULL, NULL, NULL, 'Pitesti', 'Arges', NULL, '115355', 5),
    ('Str. Marea Unire', NULL, '9', 'A1', 'K', '10', 'Alba-Iulia', 'Alba', NULL, '544321', 6),
    ('Bd. Dambovicioarei', '25', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '122321', 7),
    ('Str. Regele Mihai', NULL, 1, 'E12', 'C', '5', 'Bucuresti', NULL, NULL, '122321', 8),
    ('Bd. Avram Iancu', NULL, 2, 'A11', 'B', '23', 'Bucuresti', NULL, NULL, '122464', 9),
    ('Bd. Caderea Bastiliei', '12B', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '112332', 10),
    ('Bd. Gheorghe Lazar', '12A', NULL, NULL, NULL, NULL, 'Slobozia', 'Ialominta', NULL, '233221', 11),
    ('Str. Elena Vacarescu', NULL, '8', 'B22', 'D', '89', 'Bucuresti', NULL, NULL, '112321', 12),
    ('Str. Monica Vasilache', NULL, '2', 'C01', 'A8', '23', 'Bucuresti', NULL, NULL, '112322', 13),
    ('Bd. Pechea', '13', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '133421', 14),
    ('Bd. Dragomirescu', '9A', '1', NULL, NULL, '15', 'Bucuresti', NULL, NULL, '114566', 15),
    ('Str. Doamnei', '15C', NULL, NULL, NULL, NULL, 'Curtea de Arges', 'Arges', NULL, '115300', 16),
    ('Bd. Stefan cel Mare', '43B', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '112321', 17),
    ('Str. Rovinari', NULL, '4', 'B21', 'D', '54', 'Bucuresti', NULL, NULL, '113212', 18),
    ('Bd. Lovinescu', '44A', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '112343', 19),
    ('Bd. Petrache Poenaru', NULL, '1', 'A28', 'D', '11', 'Bucuresti', NULL, NULL, '112223', 20),
    ('Str. Paul Urechescu', '2', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '112345', 21),
    ('Str. Rabat', '21', '2', NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '112332', 22),
    ('Str. Nicolae Caramfil', NULL, '4', 'B2', '1', '53', 'Slobozia', 'Ialomita', NULL, '112643', 23),
    ('Str. Aleea Alexandru', '51', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '114554', 24),
    ('Sos. Pantelimon', '10', '2', NULL, NULL, '12', 'Bucuresti', NULL, NULL, '115432', 25),
    ('Str. Polizu', '28', NULL, NULL, NULL, NULL, 'Curtea de Arges', 'Arges', NULL, '115300', 26),
    ('Str. Barbu Delavrancea', '15B', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '112322', 27),
    ('Str. Mihai Eminescu', '45', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '112334', 28),
    ('Bd. Costache Negri', '5C', NULL, NULL, NULL, NULL, 'Bucuresti', NULL, NULL, '114332', 29),
    ('Str. Grigore Mora', NULL, '3', 'B24', 'A', '39', 'Bucuresti', NULL, NULL, 112345, 30),
    ('Str. Grigore Alexandrescu', '98', '1', NULL, NULL, '10', 'Bucuresti', NULL, NULL, 119832, 31),
	('Bd. Unirii', NULL, '5', 'B19', '4', '50', 'Bucuresti', NULL, NULL, 119832, 32),
    ('Bd. Constantin Georgian', '5A', NULL, NULL, NULL, NULL, 'Constanta', 'Constanta', NULL, 432112, 33),
    ('Str. Ion Damian', 'A15', NULL, NULL, NULL, NULL, 'Curtea de Arges', 'Arges', NULL, 115300, 34),
    ('Str. Nicolae Iorga', NULL, '2', 'B1', 'D', '28', 'Bucuresti', NULL, NULL, 114321, 35),
    ('Str. Lungescu', NULL, '1', 'A27', '2', '13', 'Bucuresti', NULL, NULL, 114321, 36),
    ('Str. Nichita Stanescu', '87A', '2', NULL, NULL, '20', 'Bucuresti', NULL, NULL, 114321, 37),
    ('Str. Mihai Eminescu', '76C', NULL, NULL, NULL, '3', 'Bucuresti', NULL, NULL, 114321, 38);


INSERT INTO parteneri (nume, prenume, telefon, email, departament_id)
	VALUES
    ('Serban', 'Nicoleta', '0767665112', 'serban.nicoleta@gmail.com', 9),
    ('Constantin', 'Mircea', '0756653221', 'constantin_mircea@gmail.com', 8),
	('Nastasoi', 'Laurentiu', '0721223112', 'lau_nastasoi@yahoo.com', 10),
    ('Nicolaescu', 'Sergiu', '0725544321', 'nicolaescu_g@yahoo.com', 10),
    ('Silvastone', 'Liliana', '0744090128', 'silva_liliana@yahoo.com', 18),
    ('Inelaru', 'Andreea', '0725543117', 'andreea.inelaru@gmail.com', 14),
    ('Manea', 'Florin', '0733432876', 'manea_florin@yahoo.com', 12),
    ('Stanciulescu', 'Ioana', '0744878102', 'stanciulescu.ioana@yahoo.com', 11),
    ('Manea', 'Laura', '0722311275', 'laura.manea@gmail.com', 8),
    ('Dragnea', 'Darius', '0736904126', 'dragnea_darius@yahoo.com', 10),
    ('Dumitru', 'Carmen', '0722541994', 'carmen.dumitru@gmail.com', 13),
    ('Lungu', 'Mariana', '0733642224', 'lungu.mariana@gmail.com', 13),
    ('Lamorfe', 'Cristian', '0733876123', 'lamorfe_cristian@yahoo.com', 18),
    ('Fricosu', 'Ciprian', '0722154341', 'ciprian_fricosu@yahoo.com', 14),
    ('Ilie', 'Marcu', '0739996164', 'ilie.marcu@gmail.com', 8),
    ('Obrica', 'Roxana', '0722947445', 'roxana.obrica@yahoo.com', 11);
    

INSERT INTO date_parteneriat (data_incepere, data_incheiere, buget, perioada, partener_id)
	VALUES
    ('2012-08-12', NULL, 2100, 'Nedeterminata', 1),
    ('2015-01-23', NULL, 1300, 'Nedeterminata', 2),
    ('2017-02-17', '2018-02-17', 2530, 'Determinata', 3),
    ('2017-04-05', '2017-12-27', 1800, 'Determinata', 4),
    ('2017-01-02', '2017-12-22', 2500, 'Determinata', 5),
    ('2013-04-20', NULL, 2300, 'Nedeterminata', 6),
    ('2014-06-01', NULL, 1300, 'Nedeterminata', 7),
    ('2014-07-23', '2017-12-23', 2000, 'Determinata', 8),
    ('2017-04-11', NULL, 1800, 'Nedeterminata', 9),
    ('2017-11-01', '2017-12-23', 1580, 'Determinata', 10),
    ('2016-10-15', '2017-10-02', 1600, 'Determinata', 11),
    ('2016-11-12', '2017-12-01', 2040, 'Determinata', 12),
    ('2013-03-28', NULL, 2600, 'Nedeterminata', 13),
    ('2017-12-01', '2017-12-25', 1300, 'Determinata', 14),
    ('2015-02-09', NULL, 2330, 'Nedeterminata', 15),
    ('2017-11-01', '2017-12-23', 1550, 'Determinata', 16);
    
INSERT INTO date_personal (data_incepere, data_demisie, status, angajat_id)
	VALUES
    ('2017-01-02', NULL, 'Activ', 1),
    ('2014-03-10', NULL, 'Activ', 2),
    ('2013-02-23', NULL, 'Activ', 3),
    ('2017-10-04', '2017-12-24', 'Inactiv', 4),
    ('2014-01-10', NULL, 'Activ', 5),
    ('2015-11-29', NULL, 'Activ' ,6),
    ('2016-12-03', '2017-04-25', 'Inactiv' ,7),
    ('2016-08-15', NULL, 'Inactiv', 8),
    ('2015-02-10', NULL, 'Inactiv', 9),
    ('2014-05-25', NULL, 'Activ', 10),
    ('2017-03-13', '2017-06-04', 'Inactiv', 11),
    ('2015-03-10', NULL, 'Activ', 12),
    ('2013-05-10', NULL, 'Activ', 13),
    ('2017-02-01', NULL, 'Activ', 14),
    ('2016-09-30', NULL, 'Inactiv', 15),
    ('2017-02-11', NULL, 'Inactiv', 16),
    ('2014-10-23', '2017-01-23', 'Inactiv', 17),
    ('2015-10-21', '2017-10-20', 'Inactiv', 18),
    ('2015-08-12', NULL, 'Activ', 19),
    ('2017-04-19', NULL, 'Activ', 20),
    ('2014-05-27', NULL, 'Inactiv', 21),
    ('2015-07-03', NULL, 'Activ', 22),
    ('2014-02-20', '2017-11-10', 'Inactiv', 23),
    ('2013-12-05', NULL, 'Activ', 24),
    ('2016-05-12', NULL, 'Inactiv', 25),
    ('2017-03-11', '2017-09-25', 'Inactiv', 26),
    ('2015-10-30', NULL, 'Activ', 27),
    ('2014-10-21', NULL, 'Activ', 28),
    ('2015-04-12', NULL, 'Activ', 29),
    ('2015-01-25', NULL, 'Inactiv', 30),
    ('2016-07-14', NULL, 'Inactiv', 31),
    ('2014-12-20', '2017-12-23', 'Inactiv', 32),
    ('2015-06-15', NULL, 'Activ', 33),
    ('2014-06-27', '2017-11-20', 'Inactiv', 34),
    ('2016-10-20', NULL, 'Activ', 35),
    ('2015-02-19', NULL, 'Activ', 36),
    ('2015-04-10', NULL, 'Activ', 37),
    ('2015-10-24', NULL, 'Activ', 38);
  
  
  

#update data_demisie si status pentru persoana cu numele Naftanaila Georgiana
UPDATE date_personal
	INNER JOIN angajati
		ON angajati.id_angajat = date_personal.angajat_id
	SET data_demisie = NULL,
		status = 'Activ'
	WHERE angajati.id_angajat = (SELECT id_angajat FROM angajati
								WHERE nume = 'Naftanaila' AND prenume = 'Georgiana');


#update data_demisie si status pentru persoana care este angajat ca producator executiv
UPDATE date_personal
	INNER JOIN angajati
		ON angajati.id_angajat = date_personal.angajat_id
	SET
		data_demisie = NULL,
        status = 'Activ'
	WHERE angajati.id_angajat = (
		SELECT id_angajat
        FROM angajati
			INNER JOIN departamente
				ON departamente.id_departament = angajati.departament_id
        WHERE denumire = 'Producator executiv');
        
        
        

#update salariu cu 250 lei tuturor editorilor
UPDATE angajati
    INNER JOIN departamente
		ON angajati.departament_id = departamente.id_departament
	SET salariu = salariu + 250
WHERE departamente.id_departament =
	(SELECT id_departament
    FROM departamente
    WHERE departamente.denumire = 'Editor');
    
    
#update: inlocuim partenerul cu id 4 cu o persoana noua
UPDATE parteneri
	SET
		nume = 'Lunganu',
        prenume = 'Denis',
        email = 'lunganu.denis@yahoo.com',
        telefon = '0721230990',
        departament_id = 10
WHERE id_partener = 4;



#stergem persoana cu id = 1
DELETE angajati, adrese, date_personal
	FROM angajati
	INNER JOIN adrese
		ON adrese.angajat_id = angajati.id_angajat
	INNER JOIN date_personal
		ON date_personal.angajat_id = angajati.id_angajat
WHERE id_angajat = 1;


#delete pe Sabin Alecsu din lista de angajati (id = 4)
DELETE angajati, adrese, date_personal
	FROM angajati
	LEFT JOIN adrese
		ON adrese.angajat_id = angajati.id_angajat
	LEFT JOIN date_personal
		ON date_personal.angajat_id = angajati.id_angajat
WHERE id_angajat = 4;


#delete partenerul Silvastone Liliana cu id 4
DELETE parteneri, date_parteneriat
FROM parteneri
INNER JOIN date_parteneriat
			ON date_parteneriat.partener_id = parteneri.id_partener
WHERE parteneri.id_partener = 4;





#join - in ce departament lucreaza si unde locuieste Cristescu Daniela
SELECT nume, prenume, denumire, strada, numar, scara, bloc, etaj, apartament, oras
FROM angajati
	RIGHT JOIN departamente
		ON angajati.departament_id = departamente.id_departament
	RIGHT JOIN adrese
		ON adrese.angajat_id = angajati.id_angajat
WHERE nume = 'Cristescu' and prenume = 'Daniela';


    
#join + operatori-
#adresele angajatilor care lucreaza in prezent pe postul de operator
SELECT nume, prenume, strada, numar, bloc, scara, etaj, apartament, oras
FROM angajati
	LEFT JOIN adrese
		ON angajati.id_angajat = adrese.angajat_id
	INNER JOIN departamente
		ON angajati.departament_id = departamente.id_departament
	INNER JOIN date_personal
		ON date_personal.angajat_id = angajati.id_angajat
WHERE departamente.denumire = 'Operator' AND data_demisie IS NULL;


#subinterogare + functii de grup + join + - 
#al doilea cel mai mare buget (salariu) primit de parteneri
SELECT CONCAT(nume, ' ', prenume, ' ', 'are ', buget) AS "Al doilea cel mare buget"
FROM parteneri
	INNER JOIN date_parteneriat
		ON parteneri.id_partener = date_parteneriat.partener_id
WHERE buget < (
		SELECT MAX(buget) FROM date_parteneriat)
ORDER BY buget DESC
LIMIT 1;


#join + functii de grup - 
#cel mai mic salariu din departamentul economic
SELECT CONCAT(nume, ' ', prenume) AS Angajat, MIN(salariu) AS salariu_minim
FROM angajati
	INNER JOIN departamente
		ON departament_id = id_departament
WHERE denumire = 'Economic';



#join + subselect + functii + operatori
#numele persoanelor (scrise invers) care lucreaza din 2015 in prezent
#si care au salariul mai mare decat cel mai mare salariu dintre parteneri
SELECT CONCAT(REVERSE(nume), ' ', REVERSE(prenume)) AS Nume_si_prenume_inversate,
		data_incepere AS "Data de incepere",
        salariu
FROM angajati
INNER JOIN date_personal
	ON date_personal.angajat_id = angajati.id_angajat
WHERE data_incepere BETWEEN '2015-01-01' AND curdate()
            AND salariu >= (SELECT MAX(buget)
							FROM date_parteneriat)
ORDER BY salariu ASC;



# sa se afiseze persoanele care au ziua datei de nastere para 
#si care si-au serbat data de nastere in anul curent
SELECT CONCAT(nume, ' ', prenume, ' si-a serbat ziua de nastere') AS 'Zile aniversare', data_nastere
FROM angajati
WHERE (MONTH(data_nastere)) <= MONTH(curdate()) AND (DAY(data_nastere) < DAY(curdate()))
GROUP BY data_nastere
HAVING DAY(data_nastere) % 2 = 0;


UPDATE angajati
	SET superior_id = CASE
			WHEN (id_angajat = 2) THEN 17
            WHEN (id_angajat = 3) THEN 14
            WHEN (id_angajat = 5) THEN 13
            WHEN (id_angajat = 6) THEN 13
            WHEN (id_angajat = 7) THEN 6
            WHEN (id_angajat = 8) THEN 17
            WHEN (id_angajat = 9) THEN 5
            WHEN (id_angajat = 10) THEN 9
            WHEN (id_angajat = 11) THEN 35
            WHEN (id_angajat = 12) THEN 14
            WHEN (id_angajat = 13) THEN NULL
            WHEN (id_angajat = 14) THEN 6
            WHEN (id_angajat = 15) THEN 35
            WHEN (id_angajat = 16) THEN 14
            WHEN (id_angajat = 17) THEN 5
            WHEN (id_angajat = 18) THEN 35
            WHEN (id_angajat = 19) THEN 9
            WHEN (id_angajat = 20) THEN 17
            WHEN (id_angajat = 21) THEN 17
            WHEN (id_angajat = 22) THEN 14
            WHEN (id_angajat = 23) THEN 6
            WHEN (id_angajat = 24) THEN 6
            WHEN (id_angajat = 25) THEN 35
            WHEN (id_angajat = 26) THEN 6
            WHEN (id_angajat = 27) THEN 17
            WHEN (id_angajat = 28) THEN 35
            WHEN (id_angajat = 29) THEN 14
            WHEN (id_angajat = 30) THEN 35
            WHEN (id_angajat = 31) THEN 17
            WHEN (id_angajat = 32) THEN 14
            WHEN (id_angajat = 33) THEN 14
            WHEN (id_angajat = 34) THEN 35
            WHEN (id_angajat = 35) THEN 6
            WHEN (id_angajat = 36) THEN 17
            WHEN (id_angajat = 37) THEN 17
            WHEN (id_angajat = 38) THEN 17
    END
WHERE id_angajat IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
					20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
                    37, 38, 39, 40);


#VIEW 1
#lista cu superiorii fiecarei persoane
CREATE VIEW lista_superiori AS
	SELECT GROUP_CONCAT(subordonati.nume, ' ', subordonati.prenume, ' ') AS subordonat,
	   CONCAT(superiori.nume, ' ', superiori.prenume) AS superior
	FROM angajati AS subordonati, angajati AS superiori
	WHERE subordonati.superior_id = superiori.id_angajat
	GROUP BY superior;

SELECT * FROM lista_superiori;



#VIEW 2
#partenerii care sunt activi, sortati dupa departamentul caruia apartin
CREATE VIEW lista_parteneri_activi AS
	SELECT nume, prenume, denumire
    FROM parteneri
    INNER JOIN departamente
		ON parteneri.departament_id = departamente.id_departament
	INNER JOIN date_parteneriat
		ON date_parteneriat.partener_id = parteneri.id_partener
	WHERE data_incheiere IS NULL
	ORDER BY parteneri.departament_id;
    
SELECT * FROM lista_parteneri_activi;
    


#FUNCTIE 1
#sa se afle suma bugetului total al partenerilor
DELIMITER //

CREATE FUNCTION afla_buget_parteneri()
	RETURNS VARCHAR(100)
BEGIN
	DECLARE mesaj VARCHAR(100);
    DECLARE buget_parteneri FLOAT(8,2);
    DECLARE nr_parteneri TINYINT;

    
	SELECT SUM(buget), COUNT(partener_id)
			INTO buget_parteneri, nr_parteneri
    FROM date_parteneriat
    INNER JOIN parteneri
		ON date_parteneriat.partener_id = parteneri.id_partener;

	SET mesaj = CONCAT('Bugetul total este de ',buget_parteneri, ' pentru ', nr_parteneri, ' parteneri.');

	RETURN mesaj;
END;
//

DELIMITER ;

SELECT afla_buget_parteneri() AS buget_partener;



#FUNCTIE 2
#nr angajatilor activi care au salariul peste medie
DELIMITER //

CREATE FUNCTION afla_angajati_salariu_avg ()
	RETURNS VARCHAR(50)
BEGIN
	DECLARE mesaj VARCHAR(50);
    DECLARE nr_angajati VARCHAR(3);


	SELECT COUNT(id_angajat) INTO nr_angajati
    FROM angajati
    INNER JOIN date_personal
		ON angajati.id_angajat = date_personal.angajat_id
	WHERE salariu > (SELECT AVG(salariu)
						FROM angajati) 
			AND data_demisie IS NOT NULL;
    
    
    SET mesaj = CONCAT(nr_angajati, ' angajati au salariu peste medie');
    
	RETURN mesaj;
END;
//
DELIMITER ;
SELECT afla_angajati_salariu_avg ();



#FUNCTIE 3
#functie care primeste id unui angajat si o suma data de la tastatura
#daca salariul e mai mic decat suma precizata, se va afisa acest lucru printr-un mesaj

DELIMITER //
CREATE FUNCTION salariu_angajat (id_ang SMALLINT, salariu_ang FLOAT(7,2))
	RETURNS VARCHAR(100)
BEGIN
	DECLARE salariu_v FLOAT(7,2);
    DECLARE mesaj VARCHAR(100);
    DECLARE id_v SMALLINT;

	
	SELECT salariu
		INTO salariu_v
	FROM angajati
    WHERE id_angajat = id_ang;
    
    IF salariu_ang < salariu_v THEN
		SET mesaj = CONCAT('Salariul angajatului este mai mare decat suma precizata: ', salariu_v);
	ELSE
		SET mesaj = CONCAT('Salariul angajatului e mai mic decat suma precizata: ', salariu_v);
	
    END IF;
    
	RETURN mesaj;

END;

//

DELIMITER ;
SELECT salariu_angajat (9, 2000);



#PROCEDURA 1
#afiseaza adresa unui angajat cu nume si prenume date de la tastatura

DELIMITER //
CREATE PROCEDURE afla_adresa_angajat (IN nume_ang VARCHAR(40),
									  IN prenume_ang VARCHAR(40))
BEGIN

	DECLARE nume_v VARCHAR(40);
    DECLARE prenume_v VARCHAR(40);
    DECLARE strada_v VARCHAR(55);
    DECLARE numar_v VARCHAR(5);
    DECLARE etaj_v VARCHAR(2);
    DECLARE bloc_v VARCHAR(7);
    DECLARE scara_v VARCHAR(7);
    DECLARE apartament_v VARCHAR(4);
    DECLARE oras_v VARCHAR(20);
    DECLARE judet_v VARCHAR(20);
    DECLARE mesaj VARCHAR(220);

	SELECT nume, prenume, strada, numar, etaj, bloc, scara, apartament, oras, judet
		INTO nume_v, prenume_v, strada_v, numar_v, etaj_v, bloc_v, scara_v, apartament_v, oras_v, judet_v
    FROM angajati
    LEFT JOIN adrese
		ON angajati.id_angajat = adrese.angajat_id
	WHERE nume_ang = angajati.nume AND angajati.prenume = prenume_ang;

	 SET mesaj = REPLACE(CONCAT_WS(' ', nume_v, prenume_v, 'locuieste la adresa:', strada_v,
					numar_v, etaj_v, bloc_v, scara_v, apartament_v, oras_v), 'NULL', '-');
     
    
    SELECT mesaj AS adresa;
END;
//

DELIMITER ;
CALL afla_adresa_angajat('Soaica', 'Andreea');



#PROCEDURA 2
#afiseaza pe ce perioada lucreaza partenerul cu numele si prenumele date ca parametri

DELIMITER //
CREATE PROCEDURE afla_partener_dept(IN id_part SMALLINT)
BEGIN

	DECLARE nume_var VARCHAR(40);
    DECLARE prenume_var VARCHAR(40);
    DECLARE denumire_var VARCHAR(40);
    DECLARE mesaj VARCHAR(100);


	SELECT parteneri.nume, parteneri.prenume, denumire
		INTO nume_var, prenume_var, denumire_var
	FROM parteneri
    INNER JOIN departamente
		ON departamente.id_departament = parteneri.departament_id
	WHERE id_part = parteneri.id_partener;
    
    
	SET mesaj = CONCAT('Persoana lucreaza pentru departamentul: ', denumire_var);
    
	IF id_part NOT IN (SELECT departament_id FROM parteneri) THEN
		SET mesaj = CONCAT('Persoana mentionata nu este partener.');
	END IF;
	SELECT mesaj AS Rezultat;
END;
//

DELIMITER ;
CALL afla_partener_dept(12);



#PROCEDURA 3
#afiseaza data de incepere a fiecarui angajat cu nume si prenume date ca parametri

DELIMITER //
CREATE PROCEDURE afla_data_incepere_ANG (IN nume_v VARCHAR(30),
										 IN prenume_v VARCHAR(30))
BEGIN

    DECLARE mesaj VARCHAR(100);
    DECLARE data_incepere_var DATE;

	SELECT data_incepere
		INTO data_incepere_var
	FROM angajati
    INNER JOIN date_personal
		ON angajati.id_angajat = date_personal.angajat_id
	WHERE angajati.nume = nume_v AND angajati.prenume = prenume_v;
    
	SET mesaj = CONCAT(nume_v, ' ', prenume_v, ' ', 'a inceput pe data de: ', data_incepere_var);
    
	SELECT mesaj as Rezultat;

END;

//

DELIMITER ;
CALL afla_data_incepere_ANG('Minculescu', 'Robert');



#CURSOR 1
#se insereaza intr-o tabela noua temporara toti partenerii pentru fiecare dintre id_departament dat ca parametru.

DELIMITER //
CREATE PROCEDURE lista_parteneri (IN id_dept SMALLINT)
BEGIN
	DECLARE nume_part VARCHAR(40);
    DECLARE prenume_part VARCHAR(40);
    DECLARE ok BOOLEAN DEFAULT TRUE;
    
	DECLARE parteneri_dept CURSOR FOR
	SELECT parteneri.nume, parteneri.prenume
	FROM departamente
    LEFT JOIN parteneri
		ON parteneri.departament_id = departamente.id_departament
	WHERE id_dept = departamente.id_departament;

	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET ok = false;
        
	DROP TABLE IF EXISTS part_temporar;
    CREATE TEMPORARY TABLE IF NOT EXISTS part_temporar (
	part_id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume_part VARCHAR(40),
    prenume_part VARCHAR(40)
    );
        
	OPEN parteneri_dept;
    TRUNCATE part_temporar;
		lista_parteneri: LOOP
	
	FETCH parteneri_dept 
			INTO nume_part, prenume_part;
	IF ok = false THEN
		LEAVE lista_parteneri;
	ELSE
		IF id_dept IN (SELECT id_departament FROM departamente) THEN
			INSERT INTO part_temporar (nume_part, prenume_part)
			 SELECT nume_part, prenume_part;
		END IF;

	END IF;
	END LOOP;
    
 SELECT * FROM part_temporar;
	
    CLOSE parteneri_dept;

END;
//
DELIMITER ;
CALL lista_parteneri (11);



#CURSOR 2
#toate persoanele care sunt operatori primesc o crestere de salariu cu 15%
    
DELIMITER //

CREATE PROCEDURE crestere_salariu_operatori ()
BEGIN
	DECLARE nume_var VARCHAR(40);
    DECLARE prenume_var VARCHAR(40);
    DECLARE denumire_var VARCHAR(40);
    DECLARE salariu_var FLOAT(7,2);
	DECLARE ok BOOLEAN DEFAULT TRUE;
    DECLARE lista_operatori VARCHAR(230);


	DECLARE x CURSOR FOR
	SELECT angajati.nume, angajati.prenume, angajati.salariu, departamente.denumire
	FROM angajati
	INNER JOIN departamente
		ON angajati.departament_id = departamente.id_departament
	WHERE id_departament = 18;
            
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET ok = false;        
            
	OPEN x;
		crestere_salariu: LOOP
        FETCH x INTO
			nume_var, prenume_var, salariu_var, denumire_var;
		IF ok = false THEN
			LEAVE crestere_salariu;
		
        ELSE
				SET salariu_var = salariu_var * 1.5;
                SET lista_operatori = CONCAT_WS(' ', nume_var, prenume_var, salariu_var, denumire_var, lista_operatori);
                
		END IF;
    
    END LOOP;

SELECT lista_operatori;

    CLOSE x;


END;
//
DELIMITER ;

CALL crestere_salariu_operatori();



#CURSOR 3
#sa se insereze intr-o tabela noua contracte_incheiate_parteneri toti partenerii care au plecat.

DELIMITER //
CREATE PROCEDURE contracte_incheiate_parteneri ()
BEGIN
	DECLARE nume_part VARCHAR(40);
    DECLARE prenume_part VARCHAR(40);
	DECLARE ok BOOLEAN DEFAULT TRUE;

	DECLARE parteneri CURSOR FOR
		SELECT nume, prenume
        FROM parteneri
        INNER JOIN date_parteneriat
			ON date_parteneriat.partener_id = parteneri.id_partener
        WHERE data_incheiere < curdate() AND perioada = 'Determinata';
         
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET ok = false;
        
    DROP TABLE IF EXISTS contract_partener;
    CREATE TABLE IF NOT EXISTS contract_partener (
    part_id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume_part VARCHAR(40),
    prenume_part VARCHAR(40),
    status VARCHAR(20) DEFAULT 'Contract incheiat'
    );    
        
    OPEN parteneri;
		TRUNCATE contract_partener;
  
    lista_contracte: LOOP    
		FETCH parteneri INTO nume_part, prenume_part;
    IF ok = false THEN
		LEAVE lista_contracte;
	ELSE
		INSERT INTO contract_partener(nume_part, prenume_part)
		   SELECT nume_part, prenume_part;
			
	END IF;
        
    END LOOP;
    
    SELECT * FROM contract_partener;
    
    CLOSE parteneri;
	
END;
//
DELIMITER ;

CALL contracte_incheiate_parteneri();



#TRIGGER 1
#daca salariul unui angajat inserat e mai mic decat salariu minim pe economie, salariul sa fie setat pe 1900

DELIMITER //
CREATE TRIGGER insert_angajati_before BEFORE INSERT ON angajati FOR EACH ROW
    
BEGIN
    
    IF NEW.salariu < 1900 THEN
		SET NEW.salariu = 1900;
	END IF;

END;
//

DELIMITER ;
DROP TRIGGER insert_angajati_before;

INSERT INTO angajati (nume, prenume, salariu)
	VALUES
    ('Bercea', 'Lavinia', 1500);
    
SELECT id_angajat, nume, prenume, salariu FROM angajati;



   
#TRIGGER 2
#sa se insereze in tabela update_salariu toate modificarile salariale ale angajatilor
DELIMITER //
CREATE TRIGGER before_angajati_update BEFORE UPDATE ON angajati FOR EACH ROW
BEGIN
	
	
    IF OLD.salariu <> NEW.salariu THEN
		INSERT INTO update_salariu (salariu_actual, id_ang)
			VALUES (NEW.salariu, OLD.id_angajat);
	END IF;

END;
//
DELIMITER ;

    
  CREATE TABLE IF NOT EXISTS update_salariu(
  id_update_sal SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  salariu_actual FLOAT(7,2),
  id_ang SMALLINT,
  FOREIGN KEY (id_ang) REFERENCES angajati (id_angajat)
  );


UPDATE angajati
	SET salariu = 2300
    WHERE id_angajat = 10;

SELECT * FROM update_salariu;



#TRIGGER 3
#daca se vor sterge angajati, sa se insereze datele acestora in tabela angajati_stersi
DELIMITER //
CREATE TRIGGER after_angajati_delete AFTER DELETE ON angajati FOR EACH ROW
BEGIN
    
	INSERT INTO angajati_stersi (nume, prenume, dept_id)
		VALUES
			(OLD.nume, OLD.prenume, OLD.departament_id);

END;
//

DELIMITER ;
CREATE TABLE IF NOT EXISTS angajati_stersi (
	id_ang_sters SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(40),
    prenume VARCHAR(40),
    dept_id SMALLINT,
    FOREIGN KEY (dept_id) REFERENCES departamente (id_departament)
);

DELETE FROM angajati
WHERE id_angajat = 2;

SELECT * FROM angajati_stersi;