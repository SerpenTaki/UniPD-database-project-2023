DROP TABLE IF EXISTS Organizzazione CASCADE;
DROP TABLE IF EXISTS Contratti CASCADE;
DROP TABLE IF EXISTS Corsi CASCADE;
DROP TABLE IF EXISTS Eventi CASCADE;
DROP TABLE IF EXISTS Frequenta CASCADE;
DROP TABLE IF EXISTS Insegna CASCADE;
DROP TABLE IF EXISTS Iscritto CASCADE;
DROP TABLE IF EXISTS Istruttori CASCADE;
DROP TABLE IF EXISTS Lavoratori CASCADE;
DROP TABLE IF EXISTS Persone CASCADE;
DROP TABLE IF EXISTS Prestazioni CASCADE;
DROP TABLE IF EXISTS Professionisti CASCADE;
DROP TABLE IF EXISTS Pubblicizzato CASCADE;
DROP TABLE IF EXISTS Sponsor CASCADE;
DROP TABLE IF EXISTS Tariffario CASCADE;
DROP TABLE IF EXISTS Usufruisce CASCADE;
DROP TABLE IF EXISTS Orari CASCADE;

CREATE TABLE IF NOT EXISTS Persone( 
	ID_persona serial,
	CF char(16) NOT NULL,
	Nome varchar(255) NOT NULL,
	Cognome varchar(255) NOT NULL,
	Data_di_nascita date,
	Eta int, 
	Sesso char(1), 
	Telefono varchar(16) NOT NULL UNIQUE,
	Residenza varchar(255) NOT NULL,
	primary key(ID_persona),
	CHECK(Sesso in ('M','F'))
);

CREATE INDEX indice_persone ON Persone(Nome , Cognome);

CREATE TABLE IF NOT EXISTS Tariffario(  
	Codice int NOT NULL,
	Prezzo int NOT NULL,
	Tipologia varchar(50) NOT NULL UNIQUE,
	Descrizione varchar(255),
	PRIMARY KEY(Codice)
);

CREATE TABLE IF NOT EXISTS Iscritto(  
	ID_iscritto int REFERENCES Persone(ID_persona),
	tip_abbonamento int REFERENCES Tariffario(Codice),
	Data_inizio date NOT NULL,
	Scadenza date NOT NULL,
	PRIMARY KEY(ID_iscritto)
);


CREATE TABLE IF NOT EXISTS Contratti(  
	Num_contratto serial,
	Cognome varchar(255) NOT NULL,
	Nome varchar(255) NOT NULL,
	CF char(16) NOT NULL,
	Data_di_nascita date NOT NULL,
	Eta int,
	Indirizzo varchar(255) NOT NULL,
	Telefono varchar(16) NOT NULL UNIQUE,
	Email varchar(255),
	Tipologia_contratto varchar(255) NOT NULL,
	Data_assunzione date NOT NULL,
	Scadenza_contratto date,
	Stipendio int NOT NULL,
	PRIMARY KEY(Num_contratto)
);

CREATE TABLE IF NOT EXISTS Professionisti(  
	Matricola int REFERENCES Contratti(Num_contratto),
	Titolo_di_studio varchar(255) NOT NULL,
	Certificazione varchar(255),
	Servizio varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY(Matricola)
);

CREATE TABLE IF NOT EXISTS Istruttori( --ok 
	Matricola int REFERENCES Contratti(Num_contratto),
	Mansione varchar(255) NOT NULL,
	Diploma varchar(255) NOT NULL,
	Certificazione varchar(255),
	PRIMARY KEY(Matricola)
);

CREATE TABLE IF NOT EXISTS Corsi( --ok 
	ID_attivita serial, 
	Responsabile int REFERENCES Istruttori(Matricola),
	Tipologia varchar(255) NOT NULL,
	Edificio varchar(50) NOT NULL,
	PRIMARY KEY(ID_attivita)
);

CREATE TABLE IF NOT EXISTS Orari(
	ID_attivita int REFERENCES Corsi(ID_attivita),
	Giorno varchar(15) NOT NULL,
	Orario_inizio time NOT NULL,
	Orario_fine time NOT NULL,
	PRIMARY KEY(ID_attivita, Giorno, Orario_inizio)
);

CREATE TABLE IF NOT EXISTS Frequenta( 
	ID_iscritto int REFERENCES Iscritto(ID_iscritto),
	ID_attività int REFERENCES Corsi(ID_attivita),
	PRIMARY KEY(ID_iscritto, ID_attività)
);

CREATE TABLE IF NOT EXISTS Insegna(  
	ID_attivita int REFERENCES Corsi(ID_attivita),
	ID_istruttori int REFERENCES Istruttori(Matricola),
	PRIMARY KEY(ID_attivita, ID_istruttori)
);

CREATE TABLE IF NOT EXISTS Lavoratori( 
	Matricola int REFERENCES Contratti(Num_contratto),
	Mansione varchar(255) NOT NULL,
	Turno_settimanale varchar(255),
	PRIMARY KEY(Matricola)
);

CREATE TABLE IF NOT EXISTS Eventi(  
	ID_evento serial,
	Nome varchar(255) NOT NULL,
	Luogo varchar(255),
	Indirizzo varchar(255),
	Data date NOT NULL,
	Orario time,
	Budget int NOT NULL,
	PRIMARY KEY(ID_evento)
);

CREATE TABLE IF NOT EXISTS Sponsor( 
	P_iva char(11) NOT NULL,
	Azienda varchar(255) NOT NULL,
	Telefono varchar(16) NOT NULL UNIQUE,
	PRIMARY KEY(P_IVA)
);

CREATE TABLE IF NOT EXISTS Organizzazione(
	ID_evento int REFERENCES Eventi(ID_evento) ,
	Matricola int REFERENCES Lavoratori(Matricola),
	Responsabile int REFERENCES Lavoratori(Matricola),
	PRIMARY KEY(ID_evento, Matricola)
);

CREATE TABLE IF NOT EXISTS Pubblicizzato(  
	P_iva char(11) REFERENCES Sponsor(P_iva),
	ID_evento int REFERENCES Eventi(ID_evento),
	Budget_offerto int NOT NULL,
	PRIMARY KEY(P_iva, ID_evento)
);

CREATE TABLE IF NOT EXISTS Prestazioni( 
	ID_prestazioni serial,
	Id_professionista int REFERENCES Professionisti(Matricola),
	Tipologia varchar(255),
	Costo int,
	PRIMARY KEY(ID_prestazioni)
);

CREATE TABLE IF NOT EXISTS Usufruisce( 
	ID_prestazione int NOT NULL REFERENCES Prestazioni(ID_prestazioni),
	ID_iscritto int NOT NULL REFERENCES Iscritto(ID_iscritto),
	Data date,
	Orario time,
	Ambulatorio varchar(15),
	PRIMARY KEY(ID_prestazione, ID_iscritto)
);