--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-06-20 11:06:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3494 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 3494
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 861 (class 1247 OID 16470)
-- Name: genere; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.genere AS ENUM (
    'M',
    'F'
);


ALTER TYPE public.genere OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 31279)
-- Name: contratti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contratti (
    num_contratto integer NOT NULL,
    cognome character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    cf character(16) NOT NULL,
    data_di_nascita date NOT NULL,
    eta integer,
    indirizzo character varying(255) NOT NULL,
    telefono character varying(16) NOT NULL,
    email character varying(255),
    tipologia_contratto character varying(255) NOT NULL,
    data_assunzione date NOT NULL,
    scadenza_contratto date,
    stipendio integer NOT NULL
);


ALTER TABLE public.contratti OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 31278)
-- Name: contratti_num_contratto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contratti_num_contratto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contratti_num_contratto_seq OWNER TO postgres;

--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 219
-- Name: contratti_num_contratto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contratti_num_contratto_seq OWNED BY public.contratti.num_contratto;


--
-- TOC entry 224 (class 1259 OID 31316)
-- Name: corsi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.corsi (
    id_attivita integer NOT NULL,
    responsabile integer,
    tipologia character varying(255) NOT NULL,
    edificio character varying(50) NOT NULL
);


ALTER TABLE public.corsi OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 31315)
-- Name: corsi_id_attivita_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.corsi_id_attivita_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.corsi_id_attivita_seq OWNER TO postgres;

--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 223
-- Name: corsi_id_attivita_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.corsi_id_attivita_seq OWNED BY public.corsi.id_attivita;


--
-- TOC entry 230 (class 1259 OID 31380)
-- Name: eventi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eventi (
    id_evento integer NOT NULL,
    nome character varying(255) NOT NULL,
    luogo character varying(255),
    indirizzo character varying(255),
    data date NOT NULL,
    orario time without time zone,
    budget integer NOT NULL
);


ALTER TABLE public.eventi OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 31379)
-- Name: eventi_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eventi_id_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eventi_id_evento_seq OWNER TO postgres;

--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 229
-- Name: eventi_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eventi_id_evento_seq OWNED BY public.eventi.id_evento;


--
-- TOC entry 226 (class 1259 OID 31337)
-- Name: frequenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.frequenta (
    id_iscritto integer NOT NULL,
    "id_attività" integer NOT NULL
);


ALTER TABLE public.frequenta OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 31263)
-- Name: iscritto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iscritto (
    id_iscritto integer NOT NULL,
    tip_abbonamento integer,
    data_inizio date NOT NULL,
    scadenza date NOT NULL
);


ALTER TABLE public.iscritto OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 31431)
-- Name: prestazioni; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prestazioni (
    id_prestazioni integer NOT NULL,
    id_professionista integer,
    tipologia character varying(255),
    costo integer
);


ALTER TABLE public.prestazioni OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 31256)
-- Name: tariffario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariffario (
    codice integer NOT NULL,
    prezzo integer NOT NULL,
    tipologia character varying(50) NOT NULL,
    descrizione character varying(255)
);


ALTER TABLE public.tariffario OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 31442)
-- Name: usufruisce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usufruisce (
    id_prestazione integer NOT NULL,
    id_iscritto integer NOT NULL,
    data date,
    orario time without time zone,
    ambulatorio character varying(15)
);


ALTER TABLE public.usufruisce OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 31458)
-- Name: guadagno_tot; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.guadagno_tot AS
 SELECT sum(prestazioni.costo) AS guadagno
   FROM public.usufruisce,
    public.prestazioni
  WHERE (usufruisce.id_prestazione = prestazioni.id_prestazioni)
UNION
 SELECT sum(tariffario.prezzo) AS guadagno
   FROM public.iscritto,
    public.tariffario
  WHERE (iscritto.tip_abbonamento = tariffario.codice);


ALTER TABLE public.guadagno_tot OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 31352)
-- Name: insegna; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.insegna (
    id_attivita integer NOT NULL,
    id_istruttori integer NOT NULL
);


ALTER TABLE public.insegna OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 31303)
-- Name: istruttori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.istruttori (
    matricola integer NOT NULL,
    mansione character varying(255) NOT NULL,
    diploma character varying(255) NOT NULL,
    certificazione character varying(255)
);


ALTER TABLE public.istruttori OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 31367)
-- Name: lavoratori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lavoratori (
    matricola integer NOT NULL,
    mansione character varying(255) NOT NULL,
    turno_settimanale character varying(255)
);


ALTER TABLE public.lavoratori OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 31327)
-- Name: orari; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orari (
    id_attivita integer NOT NULL,
    giorno character varying(15) NOT NULL,
    orario_inizio time without time zone NOT NULL,
    orario_fine time without time zone NOT NULL
);


ALTER TABLE public.orari OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 31395)
-- Name: organizzazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizzazione (
    id_evento integer NOT NULL,
    matricola integer NOT NULL,
    responsabile integer
);


ALTER TABLE public.organizzazione OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 31244)
-- Name: persone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persone (
    id_persona integer NOT NULL,
    cf character(16) NOT NULL,
    nome character varying(255) NOT NULL,
    cognome character varying(255) NOT NULL,
    data_di_nascita date,
    eta integer,
    sesso character(1),
    telefono character varying(16) NOT NULL,
    residenza character varying(255) NOT NULL,
    CONSTRAINT persone_sesso_check CHECK ((sesso = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.persone OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 31243)
-- Name: persone_id_persona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.persone_id_persona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.persone_id_persona_seq OWNER TO postgres;

--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 215
-- Name: persone_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.persone_id_persona_seq OWNED BY public.persone.id_persona;


--
-- TOC entry 234 (class 1259 OID 31430)
-- Name: prestazioni_id_prestazioni_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prestazioni_id_prestazioni_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prestazioni_id_prestazioni_seq OWNER TO postgres;

--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 234
-- Name: prestazioni_id_prestazioni_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prestazioni_id_prestazioni_seq OWNED BY public.prestazioni.id_prestazioni;


--
-- TOC entry 221 (class 1259 OID 31289)
-- Name: professionisti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professionisti (
    matricola integer NOT NULL,
    titolo_di_studio character varying(255) NOT NULL,
    certificazione character varying(255),
    servizio character varying(255) NOT NULL
);


ALTER TABLE public.professionisti OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 31415)
-- Name: pubblicizzato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pubblicizzato (
    p_iva character(11) NOT NULL,
    id_evento integer NOT NULL,
    budget_offerto integer NOT NULL
);


ALTER TABLE public.pubblicizzato OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 31462)
-- Name: spesa_tot; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.spesa_tot AS
 SELECT sum(contratti.stipendio) AS stipendio
   FROM public.contratti
  WHERE (contratti.num_contratto IN ( SELECT istruttori.matricola
           FROM public.istruttori
        UNION
         SELECT professionisti.matricola
           FROM public.professionisti
        UNION
         SELECT lavoratori.matricola
           FROM public.lavoratori));


ALTER TABLE public.spesa_tot OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 31388)
-- Name: sponsor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sponsor (
    p_iva character(11) NOT NULL,
    azienda character varying(255) NOT NULL,
    telefono character varying(16) NOT NULL
);


ALTER TABLE public.sponsor OWNER TO postgres;

--
-- TOC entry 3254 (class 2604 OID 31282)
-- Name: contratti num_contratto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratti ALTER COLUMN num_contratto SET DEFAULT nextval('public.contratti_num_contratto_seq'::regclass);


--
-- TOC entry 3255 (class 2604 OID 31319)
-- Name: corsi id_attivita; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corsi ALTER COLUMN id_attivita SET DEFAULT nextval('public.corsi_id_attivita_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 31383)
-- Name: eventi id_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventi ALTER COLUMN id_evento SET DEFAULT nextval('public.eventi_id_evento_seq'::regclass);


--
-- TOC entry 3253 (class 2604 OID 31247)
-- Name: persone id_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persone ALTER COLUMN id_persona SET DEFAULT nextval('public.persone_id_persona_seq'::regclass);


--
-- TOC entry 3257 (class 2604 OID 31434)
-- Name: prestazioni id_prestazioni; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestazioni ALTER COLUMN id_prestazioni SET DEFAULT nextval('public.prestazioni_id_prestazioni_seq'::regclass);


--
-- TOC entry 3472 (class 0 OID 31279)
-- Dependencies: 220
-- Data for Name: contratti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.contratti VALUES (1, 'Mancini', 'Emilia', 'MNCMLE72L56A182I', '1972-07-16', 50, 'Via Acrone, 101', '386 7892835', 'EmiliaMancini@armyspy.com', 'Chiamata', '2020-05-03', '2020-09-30', 1600);
INSERT INTO public.contratti VALUES (2, 'Toscano', 'Nino', 'TSCNNI66L11G942K', '1966-07-11', 56, 'Discesa Gaiola, 83', '317 9183145', 'NinoToscano@teleworm.us', 'Tempo indeterminato', '2020-01-10', NULL, 1800);
INSERT INTO public.contratti VALUES (3, 'Cattaneo', 'Affiano', 'CTTFFN88T15H703Z', '1988-12-15', 34, 'Vicolo Cieco Fondachetto, 139', '377 5167345', 'AffianoCattaneo@teleworm.us', 'Tempo indeterminato', '2015-05-27', NULL, 1600);
INSERT INTO public.contratti VALUES (4, 'Udinese', 'Benigna', 'DNSBGN61D65D810X', '1961-04-25', 62, 'Corso Garibaldi, 121', '321 9963880', 'BenignaUdinese@dayrep.com', 'Tempo determinato', '2017-01-01', '2017-12-22', 1200);
INSERT INTO public.contratti VALUES (5, 'Padovesi', 'Alfonso', 'PDVLNS92R29D150Y', '1992-10-29', 30, 'Via Alfredo Fusco, 26', '325 3217653', 'AlfonsoPadovesi@teleworm.us', 'Collaborazione sportiva', '2012-04-05', '2020-07-15', 1500);
INSERT INTO public.contratti VALUES (6, 'Ferri', 'Placido', 'FRRPCD89L01I829N', '1989-07-01', 33, 'Strada Bresciana, 96', '368 8220520', 'PlacidoFerri@armyspy.com', 'Collaborazione sportiva', '2015-07-02', '2024-07-03', 1300);
INSERT INTO public.contratti VALUES (7, 'Trentino', 'Terzo', 'TRNTRZ01M01F979V', '2001-08-01', 21, 'Corso Novara, 105', '342 2856941', 'TerzoTrentino@dayrep.com', 'Collaborazione sportiva', '2023-01-27', '2024-01-30', 1000);
INSERT INTO public.contratti VALUES (8, 'Nucci', 'Azzurra', 'NCCZRR87D58F158H', '1987-04-18', 36, 'Via Antonio da Legnago, 32', '376 2450140', 'AzzurraNucci@rhyta.com', 'Collaborazione sportiva', '2012-06-05', '2026-05-31', 1600);
INSERT INTO public.contratti VALUES (9, 'Padovano', 'Berenice', 'PDVBNC02S49A952G', '2002-11-09', 20, 'Via Nazionale, 38', '375 1190379', 'BerenicePadovano@dayrep.com', 'Collaborazione sportiva', '2023-01-27', '2024-01-30', 1000);
INSERT INTO public.contratti VALUES (10, 'Li Fonti', 'Bruto', 'LFNBRT68A01G273C', '1968-01-01', 55, 'Via Genova, 27', '371 1928051', 'BrutoLiFonti@jourrapide.com', 'Tempo determinato', '2020-05-15', '2021-05-15', 900);
INSERT INTO public.contratti VALUES (11, 'Conti', 'Diego', 'CNTDGI53A11F158B', '1953-01-11', 70, 'Via Giulio Camuzzoni, 104', '360 0577971', 'DiegoConti@teleworm.us', 'Tempo indeterminato', '2012-02-14', NULL, 1400);
INSERT INTO public.contratti VALUES (12, 'Cattaneo', 'Rina', 'CTTRNI92A49F839Y', '1992-01-09', 31, 'Via Guantai Nuovi, 138', '356 2358346', 'RinaCattaneo@armyspy.com', 'Tempo indeterminato', '2016-06-07', NULL, 1200);
INSERT INTO public.contratti VALUES (13, 'Davide', 'Susanna', 'DVDSNN04D53A859Z', '2004-04-13', 19, 'Strada Statale, 4', '352 6838179', 'SusannaDavide@teleworm.us', 'Stagista', '2023-01-15', '2023-07-15', 600);
INSERT INTO public.contratti VALUES (14, 'Mazzi', 'Anastasio', 'MZZNTS44T27F205Y', '1944-12-27', 78, 'Via Palermo, 133', '375 3947035', 'AnastasioMazzi@armyspy.com', 'Tempo indeterminato', '2010-01-01', NULL, 2500);
INSERT INTO public.contratti VALUES (15, 'Milani', 'Gabriella', 'MLNGRL80P65A390C', '1980-09-25', 42, 'Via del Caggio, 90', '345 0118108', 'GabriellaMilani@jourrapide.com', 'Tempo indeterminato', '2012-04-05', NULL, 1900);
INSERT INTO public.contratti VALUES (16, 'Di Pietro', 'Gabriele', 'DPTGRL91S11F158V', '1991-11-11', 31, 'Via Belviglieri, 102', '375 6698380', 'GabrieleDiPietro@dayrep.com', 'Tempo indeterminato', '2012-04-28', NULL, 700);


--
-- TOC entry 3476 (class 0 OID 31316)
-- Dependencies: 224
-- Data for Name: corsi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.corsi VALUES (1, 6, 'Nuoto', 'Vasca 1');
INSERT INTO public.corsi VALUES (2, 6, 'Nuoto_bambini', 'Vasca 3');
INSERT INTO public.corsi VALUES (3, 7, 'Apnea', 'Vasca 2');
INSERT INTO public.corsi VALUES (4, 6, 'PallaNuoto', 'Vasca 3');
INSERT INTO public.corsi VALUES (5, 6, 'PallaNuoto_bambini', 'Vasca 3');
INSERT INTO public.corsi VALUES (6, 7, 'Acquagym', 'Vasca 3');
INSERT INTO public.corsi VALUES (7, 6, 'Sincronizzato', 'Vasca 1');
INSERT INTO public.corsi VALUES (8, 7, 'Tuffi', 'Vasca 2');
INSERT INTO public.corsi VALUES (9, 7, 'SUB', 'Vasca 2');
INSERT INTO public.corsi VALUES (10, NULL, 'Nuoto_libero', 'Vasca 1');
INSERT INTO public.corsi VALUES (11, 6, 'Nuoto', 'Vasca 1');
INSERT INTO public.corsi VALUES (12, 6, 'Nuoto_bambini', 'Vasca 3');
INSERT INTO public.corsi VALUES (13, 7, 'Apnea', 'Vasca 2');
INSERT INTO public.corsi VALUES (14, 6, 'PallaNuoto', 'Vasca 3');
INSERT INTO public.corsi VALUES (15, 6, 'PallaNuoto_bambini', 'Vasca 3');
INSERT INTO public.corsi VALUES (16, 7, 'Acquagym', 'Vasca 3');
INSERT INTO public.corsi VALUES (17, 6, 'Sincronizzato', 'Vasca 1');
INSERT INTO public.corsi VALUES (18, 7, 'Tuffi', 'Vasca 2');
INSERT INTO public.corsi VALUES (19, 7, 'SUB', 'Vasca 2');
INSERT INTO public.corsi VALUES (20, NULL, 'Nuoto_libero', 'Vasca 1');


--
-- TOC entry 3482 (class 0 OID 31380)
-- Dependencies: 230
-- Data for Name: eventi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.eventi VALUES (1, 'Memorial_Mario_Zanchi', 'Vasca 3', 'Indoor', '2023-05-07', '10:30:00', 200);
INSERT INTO public.eventi VALUES (2, 'Campionato_regionale apnea', 'Y-40', 'Via Torquato Tasso, 30. Montegrotto terme, Pd', '2022-04-28', '08:30:00', 1000);
INSERT INTO public.eventi VALUES (3, 'Dimostrazione_nuoto sincronizzato', 'Vasca 2', 'Indoor', '2023-01-25', '20:30:00', 0);
INSERT INTO public.eventi VALUES (4, 'Partita_pallanuoto', 'Oasi 2000', 'Via Dante Alighieri, 1. Padova ', '2023-07-14', '11:00:00', 500);
INSERT INTO public.eventi VALUES (5, 'IRONMAN_70.3', 'Jesolo, Ve', 'Via Giovanni Giolitti, 20', '2021-09-04', '07:00:00', 2000);
INSERT INTO public.eventi VALUES (6, 'Giornata_gioco-nuoto', 'Vasca 3', 'Indoor', '2022-08-16', '10:00:00', 150);
INSERT INTO public.eventi VALUES (7, 'Duathlon_2023', 'Via Rolando,55', 'Rimini', '2022-05-12', '08:00:00', 700);
INSERT INTO public.eventi VALUES (8, 'Campionato_regionale_Tuffi', 'Vasca 1', 'Indoor', '2023-09-16', '09:00:00', 250);


--
-- TOC entry 3478 (class 0 OID 31337)
-- Dependencies: 226
-- Data for Name: frequenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.frequenta VALUES (1, 1);
INSERT INTO public.frequenta VALUES (2, 6);
INSERT INTO public.frequenta VALUES (3, 3);
INSERT INTO public.frequenta VALUES (4, 3);
INSERT INTO public.frequenta VALUES (4, 10);
INSERT INTO public.frequenta VALUES (5, 4);
INSERT INTO public.frequenta VALUES (6, 1);
INSERT INTO public.frequenta VALUES (6, 8);
INSERT INTO public.frequenta VALUES (7, 4);
INSERT INTO public.frequenta VALUES (8, 7);
INSERT INTO public.frequenta VALUES (9, 7);
INSERT INTO public.frequenta VALUES (11, 7);
INSERT INTO public.frequenta VALUES (11, 10);
INSERT INTO public.frequenta VALUES (14, 8);
INSERT INTO public.frequenta VALUES (15, 8);
INSERT INTO public.frequenta VALUES (16, 3);
INSERT INTO public.frequenta VALUES (17, 4);
INSERT INTO public.frequenta VALUES (17, 3);
INSERT INTO public.frequenta VALUES (19, 9);
INSERT INTO public.frequenta VALUES (20, 1);
INSERT INTO public.frequenta VALUES (21, 8);
INSERT INTO public.frequenta VALUES (22, 4);
INSERT INTO public.frequenta VALUES (22, 10);
INSERT INTO public.frequenta VALUES (25, 9);
INSERT INTO public.frequenta VALUES (30, 4);
INSERT INTO public.frequenta VALUES (31, 9);
INSERT INTO public.frequenta VALUES (31, 10);
INSERT INTO public.frequenta VALUES (32, 6);
INSERT INTO public.frequenta VALUES (34, 6);
INSERT INTO public.frequenta VALUES (35, 8);
INSERT INTO public.frequenta VALUES (35, 10);


--
-- TOC entry 3479 (class 0 OID 31352)
-- Dependencies: 227
-- Data for Name: insegna; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.insegna VALUES (1, 6);
INSERT INTO public.insegna VALUES (1, 9);
INSERT INTO public.insegna VALUES (2, 9);
INSERT INTO public.insegna VALUES (3, 7);
INSERT INTO public.insegna VALUES (4, 6);
INSERT INTO public.insegna VALUES (5, 6);
INSERT INTO public.insegna VALUES (5, 9);
INSERT INTO public.insegna VALUES (6, 8);
INSERT INTO public.insegna VALUES (7, 6);
INSERT INTO public.insegna VALUES (8, 7);
INSERT INTO public.insegna VALUES (8, 8);
INSERT INTO public.insegna VALUES (9, 7);
INSERT INTO public.insegna VALUES (9, 8);


--
-- TOC entry 3470 (class 0 OID 31263)
-- Dependencies: 218
-- Data for Name: iscritto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.iscritto VALUES (1, 258, '2022-09-08', '2023-09-08');
INSERT INTO public.iscritto VALUES (2, 258, '2022-12-15', '2023-12-05');
INSERT INTO public.iscritto VALUES (3, 258, '2022-06-10', '2023-06-10');
INSERT INTO public.iscritto VALUES (5, 276, '2023-06-04', '2023-07-04');
INSERT INTO public.iscritto VALUES (4, 459, '2023-02-14', '2023-07-14');
INSERT INTO public.iscritto VALUES (6, 673, '2023-01-25', '2023-06-25');
INSERT INTO public.iscritto VALUES (8, 828, '2023-02-28', '2024-02-28');
INSERT INTO public.iscritto VALUES (7, 673, '2023-04-05', '2023-10-05');
INSERT INTO public.iscritto VALUES (17, 276, '2023-05-16', '2023-06-16');
INSERT INTO public.iscritto VALUES (19, 459, '2023-06-15', '2023-12-15');
INSERT INTO public.iscritto VALUES (20, 258, '2022-09-07', '2023-09-07');
INSERT INTO public.iscritto VALUES (21, 828, '2023-05-18', '2023-07-18');
INSERT INTO public.iscritto VALUES (22, 673, '2023-01-05', '2023-07-05');
INSERT INTO public.iscritto VALUES (11, 387, '2023-05-04', '2023-08-04');
INSERT INTO public.iscritto VALUES (25, 673, '2023-02-15', '2023-08-15');
INSERT INTO public.iscritto VALUES (15, 258, '2022-07-02', '2023-07-02');
INSERT INTO public.iscritto VALUES (16, 459, '2023-04-19', '2023-10-19');
INSERT INTO public.iscritto VALUES (14, 459, '2023-05-02', '2023-10-02');
INSERT INTO public.iscritto VALUES (31, 673, '2023-06-05', '2023-12-05');
INSERT INTO public.iscritto VALUES (34, 828, '2022-09-08', '2023-09-08');
INSERT INTO public.iscritto VALUES (35, 828, '2022-10-01', '2023-10-01');
INSERT INTO public.iscritto VALUES (30, 258, '2022-09-05', '2023-09-05');
INSERT INTO public.iscritto VALUES (32, 387, '2023-03-06', '2023-06-06');
INSERT INTO public.iscritto VALUES (9, 387, '2023-04-12', '2023-07-12');


--
-- TOC entry 3474 (class 0 OID 31303)
-- Dependencies: 222
-- Data for Name: istruttori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.istruttori VALUES (6, 'Allenatore', 'Istruttore di nuoto', 'BLSD');
INSERT INTO public.istruttori VALUES (7, 'Alenatore', 'Istruttore di sub, II livello', 'Assistente bagnanti');
INSERT INTO public.istruttori VALUES (8, 'Aiuto-allenatore', 'Istruttore sub, base', 'BLSD');
INSERT INTO public.istruttori VALUES (9, 'Aiuto-allenatore', 'Istruttore nuoto sincronizzato', 'BLS');


--
-- TOC entry 3480 (class 0 OID 31367)
-- Dependencies: 228
-- Data for Name: lavoratori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lavoratori VALUES (11, 'Impiegato', '8.00-17.00');
INSERT INTO public.lavoratori VALUES (12, 'Impiegato', '8.00-17.00');
INSERT INTO public.lavoratori VALUES (13, 'Impiegato', '9.00-18.00');
INSERT INTO public.lavoratori VALUES (14, 'Direttore', NULL);
INSERT INTO public.lavoratori VALUES (15, 'Segretaria', '9.00-18.00');
INSERT INTO public.lavoratori VALUES (16, 'Bidello', '9.00-18.00');


--
-- TOC entry 3477 (class 0 OID 31327)
-- Dependencies: 225
-- Data for Name: orari; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orari VALUES (1, 'Lunedì', '20:00:00', '21:00:00');
INSERT INTO public.orari VALUES (1, 'Lunedì', '09:00:00', '10:00:00');
INSERT INTO public.orari VALUES (2, 'Lunedì', '16:00:00', '17:00:00');
INSERT INTO public.orari VALUES (3, 'Lunedì', '18:30:00', '20:00:00');
INSERT INTO public.orari VALUES (3, 'Lunedì', '11:00:00', '12:30:00');
INSERT INTO public.orari VALUES (4, 'Martedì', '20:30:00', '22:00:00');
INSERT INTO public.orari VALUES (5, 'Martedì', '16:00:00', '17:00:00');
INSERT INTO public.orari VALUES (6, 'Martedì', '18:00:00', '19:00:00');
INSERT INTO public.orari VALUES (6, 'Martedì', '09:00:00', '10:00:00');
INSERT INTO public.orari VALUES (7, 'Lunedì', '18:30:00', '20:00:00');
INSERT INTO public.orari VALUES (8, 'Lunedì', '20:00:00', '22:00:00');
INSERT INTO public.orari VALUES (9, 'Mercoledì', '20:00:00', '22:00:00');
INSERT INTO public.orari VALUES (1, 'Giovedì', '20:00:00', '21:00:00');
INSERT INTO public.orari VALUES (1, 'Giovedì', '09:00:00', '10:00:00');
INSERT INTO public.orari VALUES (2, 'Giovedì', '16:00:00', '17:00:00');
INSERT INTO public.orari VALUES (3, 'Giovedì', '18:30:00', '20:00:00');
INSERT INTO public.orari VALUES (3, 'Giovedì', '11:00:00', '12:30:00');
INSERT INTO public.orari VALUES (4, 'Venerdì', '20:30:00', '22:00:00');
INSERT INTO public.orari VALUES (5, 'Venerdì', '16:00:00', '17:00:00');
INSERT INTO public.orari VALUES (6, 'Venerdì', '18:00:00', '19:00:00');
INSERT INTO public.orari VALUES (6, 'Venerdì', '09:00:00', '10:00:00');
INSERT INTO public.orari VALUES (7, 'Giovedì', '18:30:00', '20:00:00');
INSERT INTO public.orari VALUES (8, 'Giovedì', '20:00:00', '22:00:00');
INSERT INTO public.orari VALUES (9, 'Venerdì', '20:00:00', '22:00:00');
INSERT INTO public.orari VALUES (10, 'Lunedì', '11:00:00', '18:00:00');
INSERT INTO public.orari VALUES (10, 'Giovedì', '11:00:00', '18:00:00');
INSERT INTO public.orari VALUES (10, 'Martedì', '09:00:00', '22:00:00');
INSERT INTO public.orari VALUES (10, 'Mercoledì', '09:00:00', '22:00:00');
INSERT INTO public.orari VALUES (10, 'Venerdì', '09:00:00', '22:00:00');


--
-- TOC entry 3484 (class 0 OID 31395)
-- Dependencies: 232
-- Data for Name: organizzazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organizzazione VALUES (1, 12, 14);
INSERT INTO public.organizzazione VALUES (2, 12, 14);
INSERT INTO public.organizzazione VALUES (2, 11, 14);
INSERT INTO public.organizzazione VALUES (3, 11, 12);
INSERT INTO public.organizzazione VALUES (4, 13, 11);
INSERT INTO public.organizzazione VALUES (5, 11, 14);
INSERT INTO public.organizzazione VALUES (5, 12, 14);
INSERT INTO public.organizzazione VALUES (5, 14, 14);
INSERT INTO public.organizzazione VALUES (6, 11, 11);
INSERT INTO public.organizzazione VALUES (7, 11, 11);
INSERT INTO public.organizzazione VALUES (7, 12, 11);
INSERT INTO public.organizzazione VALUES (8, 12, 14);
INSERT INTO public.organizzazione VALUES (8, 14, 14);


--
-- TOC entry 3468 (class 0 OID 31244)
-- Dependencies: 216
-- Data for Name: persone; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.persone VALUES (1, 'LMBSRN87P16L103O', 'Severino', 'Lombardi', '1987-09-16', 35, 'M', '335 9180284', 'Stradone Antonio Provolo, 75');
INSERT INTO public.persone VALUES (2, 'BCCGNR96L01H501X', 'Gennaro', 'Bucchio', '1996-07-01', 26, 'M', '398 7542801', 'Via Longhena, 138');
INSERT INTO public.persone VALUES (3, 'ZTTSRG03C27L781W', 'Eustorgio', 'Zetticci', '2003-03-27', 20, 'M', '376 6039295', 'Via Rocca de Baldi, 62');
INSERT INTO public.persone VALUES (4, 'PLRDNS57S53L750L', 'Dionisia', 'Palerma', '1957-11-13', 65, 'F', '330 7695746', 'Piazza San Carlo, 13');
INSERT INTO public.persone VALUES (5, 'PDVLVE80A01F257P', 'Elvio', 'Padovano', '1980-01-01', 43, 'M', '332 0011903', 'Piazza Bovio, 91');
INSERT INTO public.persone VALUES (6, 'MNFSNN66H04H703R', 'Susanna', 'Manfrin', '1966-06-04', 56, 'F', '349 0545477', 'Via Rosmini, 122');
INSERT INTO public.persone VALUES (7, 'CLMDND91A44L331N', 'Adelinda', 'Colombo', '1991-01-04', 32, 'F', '355 4724570', 'Via del Pontiere, 7');
INSERT INTO public.persone VALUES (8, 'SCLMRC98S08L736Q', 'Merico', 'Siciliani', '1998-11-08', 24, 'M', '370 5010522', 'Via Antonio Cecchi, 99');
INSERT INTO public.persone VALUES (9, 'CSTRNN91S63A479P', 'Arianna', 'Castiglione', '1991-11-23', 31, 'F', '321 6129492', 'Via Roma, 53');
INSERT INTO public.persone VALUES (10, 'RCRRLL95L64A479C', 'Ornella', 'Arcuri', '1995-07-24', 27, 'F', '387 3977587', 'Via Roma, 77');
INSERT INTO public.persone VALUES (11, 'FRRMNL88D06I452B', 'Manuel', 'Ferri', '1988-04-06', 35, 'M', '313 3468171', 'Via Carlo Cattaneo, 139');
INSERT INTO public.persone VALUES (12, 'BNOTNZ89L19A859F', 'Terenzio', 'Boni', '1989-07-19', 33, 'M', '359 0482277', 'Strada Statale, 46');
INSERT INTO public.persone VALUES (13, 'MRCMDE05S12E472I', 'Emidio', 'Marcelo', '2005-11-12', 17, 'M', '389 6242936', 'Piazza Garibaldi, 146');
INSERT INTO public.persone VALUES (14, 'PLRCRO91A44F205B', 'Cora', 'Palerma', '1991-01-04', 32, 'F', '310 7756261', 'Via Palermo, 43');
INSERT INTO public.persone VALUES (15, 'SPSLSA84T50F205Y', 'Alosia', 'Esposito', '1984-12-10', 38, 'F', '363 1587822', 'Via Nazario Sauro, 44');
INSERT INTO public.persone VALUES (16, 'GRCPRN01P30A944M', 'Pierino', 'Greece', '2001-09-30', 21, 'M', '392 6785009', 'Via Vicenza, 86');
INSERT INTO public.persone VALUES (17, 'LCCLRC81B28D612T', 'Learco', 'Lucciano', '1981-02-28', 42, 'M', '346 9925054', 'Via Nuova Agnano, 30');
INSERT INTO public.persone VALUES (18, 'FRNCSP83A07G388D', 'Crispino', 'Fiorentino', '1983-01-07', 40, 'M', '348 5360483', 'Vico Giganti, 121');
INSERT INTO public.persone VALUES (19, 'CTTMRA82R68A859B', 'Maria', 'Cattaneo', '1982-10-28', 40, 'F', '322 0137045', 'Strada Statale, 87');
INSERT INTO public.persone VALUES (20, 'CRAFFN65T31H620M', 'Affiano', 'Acuri', '1965-12-31', 57, 'M', '334 4288868', 'Via Valpantena, 25');
INSERT INTO public.persone VALUES (21, 'CTTLBR86H15D810Q', 'Libero', 'Cattaneo', '1986-06-15', 36, 'M', '387 0334927', 'Corso Garibaldi, 121');
INSERT INTO public.persone VALUES (22, 'PGLGLN89T07H282Q', 'Gianleone', 'Pugliesi', '1989-12-07', 39, 'M', '366 8822817', 'Via Goffredo Mameli, 3');
INSERT INTO public.persone VALUES (23, 'TRVLEI88R20I829B', 'Elio', 'Trevisan', '1988-10-20', 34, 'M', '397 1300864', 'Strada Bresciana, 12');
INSERT INTO public.persone VALUES (24, 'FRRGNN64H06L378Q', 'Ferri', 'Gianni', '1964-06-06', 58, 'M', '392 6322066', 'Via Torricelli, 84');
INSERT INTO public.persone VALUES (25, 'TSCLTR00H18D205I', 'Eleuterio', 'Toscano', '2000-06-18', 22, 'M', '314 3564545', 'Via Bernardino Rota, 9');
INSERT INTO public.persone VALUES (26, 'FRNGRR87A11B354B', 'Gherardo', 'Fiorentino', '1987-01-11', 36, 'M', '367 6657501', 'Via del Viminale, 25');
INSERT INTO public.persone VALUES (27, 'GNVBGN98E19L331S', 'Benigno', 'Genovesi', '1998-05-19', 25, 'M', '344 0497530', 'Vicolo Calcirelli, 24');
INSERT INTO public.persone VALUES (28, 'MNFLVS59T46D643L', 'Alvisa', 'Manfrin', '1959-12-06', 63, 'F', '350 1417337', 'Via Nuova Agnano, 29');
INSERT INTO public.persone VALUES (29, 'FRRTNQ88A61L483G', 'Tranquillina', 'Ferri', '1988-01-21', 35, 'F', '360 1341593', 'Via Sacchi, 85');
INSERT INTO public.persone VALUES (30, 'CCCRSN00D10L407X', 'Arsenio', 'Cocci', '2000-04-10', 23, 'M', '382 8164759', 'Vicolo Tre Marchetti, 14');
INSERT INTO public.persone VALUES (31, 'MRCGCM72M30D612Y', 'Giacomo', 'Marchesi', '1972-09-30', 39, 'M', '371 4503979', 'Via Nuova Agnano, 115');
INSERT INTO public.persone VALUES (32, 'CNTCML86C71G388K', 'Camelia', 'Conti', '1986-03-31', 37, 'F', '314 7482281', 'Via Alessandro Manzoni, 54');
INSERT INTO public.persone VALUES (33, 'ZTILNI92H68D205E', 'Ilenia', 'Zito', '1992-06-28', 39, 'F', '334 6184982', 'Piazza Trieste e Trento, 103');
INSERT INTO public.persone VALUES (34, 'SPSMNL94M21G478M', 'Manuel', 'Esposito', '1994-08-21', 28, 'M', '320 8126713', 'Via Tasso, 84');
INSERT INTO public.persone VALUES (35, 'TRVFNC80A41F205L', 'Francesca', 'Trevisan', '1968-08-09', 54, 'F', '366 3868639', 'Via San Pietro Ad Aram, 104');


--
-- TOC entry 3487 (class 0 OID 31431)
-- Dependencies: 235
-- Data for Name: prestazioni; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.prestazioni VALUES (1, 2, 'Seduta osteopaitca', 50);
INSERT INTO public.prestazioni VALUES (2, 1, 'Piano alimentare', 80);
INSERT INTO public.prestazioni VALUES (3, 3, 'Visita medica agonistica', 75);
INSERT INTO public.prestazioni VALUES (4, 3, 'Visita medica', 50);
INSERT INTO public.prestazioni VALUES (5, 2, 'Fisioterapia', 60);


--
-- TOC entry 3473 (class 0 OID 31289)
-- Dependencies: 221
-- Data for Name: professionisti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.professionisti VALUES (1, 'Biologo nutrizionista', 'Master in alimentazione sportiva', 'Piani alimentari');
INSERT INTO public.professionisti VALUES (2, 'Fisioterapista', 'Certificato di osteopatia', 'Trattamento manuale');
INSERT INTO public.professionisti VALUES (3, 'Medicina sportiva', NULL, 'Visite mediche');


--
-- TOC entry 3485 (class 0 OID 31415)
-- Dependencies: 233
-- Data for Name: pubblicizzato; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pubblicizzato VALUES ('44127690699', 1, 150);
INSERT INTO public.pubblicizzato VALUES ('22051770141', 2, 600);
INSERT INTO public.pubblicizzato VALUES ('50261720036', 2, 250);
INSERT INTO public.pubblicizzato VALUES ('33203070579', 4, 375);
INSERT INTO public.pubblicizzato VALUES ('63722920756', 5, 400);
INSERT INTO public.pubblicizzato VALUES ('22051770141', 5, 250);
INSERT INTO public.pubblicizzato VALUES ('23172560627', 5, 600);
INSERT INTO public.pubblicizzato VALUES ('33203070579', 5, 380);
INSERT INTO public.pubblicizzato VALUES ('44127690699', 5, 250);
INSERT INTO public.pubblicizzato VALUES ('72680940524', 6, 70);
INSERT INTO public.pubblicizzato VALUES ('44127690699', 7, 500);
INSERT INTO public.pubblicizzato VALUES ('73465920541', 8, 200);


--
-- TOC entry 3483 (class 0 OID 31388)
-- Dependencies: 231
-- Data for Name: sponsor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sponsor VALUES ('63722920756', 'Lorefice&Ponzio_Srl', '356 8757084');
INSERT INTO public.sponsor VALUES ('23172560627', 'Gioielleria_Duca_Srl', '342 5963188');
INSERT INTO public.sponsor VALUES ('79043300916', 'New_Truck_Srl', '398 7514241');
INSERT INTO public.sponsor VALUES ('22051770141', 'I.C.E._Srl', '367 5013990');
INSERT INTO public.sponsor VALUES ('44127690699', 'Alternativa_Impianti', '352 1091782');
INSERT INTO public.sponsor VALUES ('72680940524', 'Macelleria_Mosca_Snc', '331 0952763');
INSERT INTO public.sponsor VALUES ('56424590836', 'Marchiol_Spa', '368 1858270');
INSERT INTO public.sponsor VALUES ('50261720036', 'Relax_Voyage', '335 5839896');
INSERT INTO public.sponsor VALUES ('73465920541', 'Maylor_Srls', '344 2912949');
INSERT INTO public.sponsor VALUES ('33203070579', 'La_Fenice_Srl', '326 5068537');


--
-- TOC entry 3469 (class 0 OID 31256)
-- Dependencies: 217
-- Data for Name: tariffario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tariffario VALUES (258, 500, 'Annuale', NULL);
INSERT INTO public.tariffario VALUES (459, 320, 'Semestrale', NULL);
INSERT INTO public.tariffario VALUES (828, 180, 'Trimestrale', NULL);
INSERT INTO public.tariffario VALUES (276, 65, 'Mensile', NULL);
INSERT INTO public.tariffario VALUES (673, 70, '10 entrate', 'Aventi validità 7 mesi');
INSERT INTO public.tariffario VALUES (387, 45, '6 entrate', 'Aventi validità 4 mesi');


--
-- TOC entry 3488 (class 0 OID 31442)
-- Dependencies: 236
-- Data for Name: usufruisce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usufruisce VALUES (3, 4, '2023-07-02', '15:00:00', 'A1');
INSERT INTO public.usufruisce VALUES (2, 7, '2023-06-30', '16:30:00', 'A2');
INSERT INTO public.usufruisce VALUES (1, 19, '2023-05-31', '14:00:00', 'A1');
INSERT INTO public.usufruisce VALUES (4, 11, '2023-05-22', '13:30:00', 'A1');
INSERT INTO public.usufruisce VALUES (5, 34, '2023-05-07', '14:30:00', 'A1');
INSERT INTO public.usufruisce VALUES (5, 32, '2023-05-07', '15:10:00', 'A1');
INSERT INTO public.usufruisce VALUES (3, 9, '2023-05-06', '10:30:00', 'A1');
INSERT INTO public.usufruisce VALUES (2, 14, '2023-02-18', '09:00:00', 'A2');
INSERT INTO public.usufruisce VALUES (2, 1, '2023-01-05', '11:00:00', 'A2');


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 219
-- Name: contratti_num_contratto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contratti_num_contratto_seq', 16, true);


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 223
-- Name: corsi_id_attivita_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.corsi_id_attivita_seq', 20, true);


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 229
-- Name: eventi_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventi_id_evento_seq', 8, true);


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 215
-- Name: persone_id_persona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.persone_id_persona_seq', 35, true);


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 234
-- Name: prestazioni_id_prestazioni_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prestazioni_id_prestazioni_seq', 5, true);


--
-- TOC entry 3271 (class 2606 OID 31286)
-- Name: contratti contratti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratti
    ADD CONSTRAINT contratti_pkey PRIMARY KEY (num_contratto);


--
-- TOC entry 3273 (class 2606 OID 31288)
-- Name: contratti contratti_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratti
    ADD CONSTRAINT contratti_telefono_key UNIQUE (telefono);


--
-- TOC entry 3281 (class 2606 OID 31321)
-- Name: corsi corsi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corsi
    ADD CONSTRAINT corsi_pkey PRIMARY KEY (id_attivita);


--
-- TOC entry 3291 (class 2606 OID 31387)
-- Name: eventi eventi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventi
    ADD CONSTRAINT eventi_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 3285 (class 2606 OID 31341)
-- Name: frequenta frequenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.frequenta
    ADD CONSTRAINT frequenta_pkey PRIMARY KEY (id_iscritto, "id_attività");


--
-- TOC entry 3287 (class 2606 OID 31356)
-- Name: insegna insegna_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insegna
    ADD CONSTRAINT insegna_pkey PRIMARY KEY (id_attivita, id_istruttori);


--
-- TOC entry 3269 (class 2606 OID 31267)
-- Name: iscritto iscritto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT iscritto_pkey PRIMARY KEY (id_iscritto);


--
-- TOC entry 3279 (class 2606 OID 31309)
-- Name: istruttori istruttori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istruttori
    ADD CONSTRAINT istruttori_pkey PRIMARY KEY (matricola);


--
-- TOC entry 3289 (class 2606 OID 31373)
-- Name: lavoratori lavoratori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lavoratori
    ADD CONSTRAINT lavoratori_pkey PRIMARY KEY (matricola);


--
-- TOC entry 3283 (class 2606 OID 31331)
-- Name: orari orari_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orari
    ADD CONSTRAINT orari_pkey PRIMARY KEY (id_attivita, giorno, orario_inizio);


--
-- TOC entry 3297 (class 2606 OID 31399)
-- Name: organizzazione organizzazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizzazione
    ADD CONSTRAINT organizzazione_pkey PRIMARY KEY (id_evento, matricola);


--
-- TOC entry 3261 (class 2606 OID 31252)
-- Name: persone persone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persone
    ADD CONSTRAINT persone_pkey PRIMARY KEY (id_persona);


--
-- TOC entry 3263 (class 2606 OID 31254)
-- Name: persone persone_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persone
    ADD CONSTRAINT persone_telefono_key UNIQUE (telefono);


--
-- TOC entry 3301 (class 2606 OID 31436)
-- Name: prestazioni prestazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestazioni
    ADD CONSTRAINT prestazioni_pkey PRIMARY KEY (id_prestazioni);


--
-- TOC entry 3275 (class 2606 OID 31295)
-- Name: professionisti professionisti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionisti
    ADD CONSTRAINT professionisti_pkey PRIMARY KEY (matricola);


--
-- TOC entry 3277 (class 2606 OID 31297)
-- Name: professionisti professionisti_servizio_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionisti
    ADD CONSTRAINT professionisti_servizio_key UNIQUE (servizio);


--
-- TOC entry 3299 (class 2606 OID 31419)
-- Name: pubblicizzato pubblicizzato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubblicizzato
    ADD CONSTRAINT pubblicizzato_pkey PRIMARY KEY (p_iva, id_evento);


--
-- TOC entry 3293 (class 2606 OID 31392)
-- Name: sponsor sponsor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsor
    ADD CONSTRAINT sponsor_pkey PRIMARY KEY (p_iva);


--
-- TOC entry 3295 (class 2606 OID 31394)
-- Name: sponsor sponsor_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsor
    ADD CONSTRAINT sponsor_telefono_key UNIQUE (telefono);


--
-- TOC entry 3265 (class 2606 OID 31260)
-- Name: tariffario tariffario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffario
    ADD CONSTRAINT tariffario_pkey PRIMARY KEY (codice);


--
-- TOC entry 3267 (class 2606 OID 31262)
-- Name: tariffario tariffario_tipologia_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffario
    ADD CONSTRAINT tariffario_tipologia_key UNIQUE (tipologia);


--
-- TOC entry 3303 (class 2606 OID 31446)
-- Name: usufruisce usufruisce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usufruisce
    ADD CONSTRAINT usufruisce_pkey PRIMARY KEY (id_prestazione, id_iscritto);


--
-- TOC entry 3259 (class 1259 OID 31255)
-- Name: indice_persone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indice_persone ON public.persone USING btree (nome, cognome);


--
-- TOC entry 3308 (class 2606 OID 31322)
-- Name: corsi corsi_responsabile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corsi
    ADD CONSTRAINT corsi_responsabile_fkey FOREIGN KEY (responsabile) REFERENCES public.istruttori(matricola);


--
-- TOC entry 3310 (class 2606 OID 31347)
-- Name: frequenta frequenta_id_attività_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.frequenta
    ADD CONSTRAINT "frequenta_id_attività_fkey" FOREIGN KEY ("id_attività") REFERENCES public.corsi(id_attivita);


--
-- TOC entry 3311 (class 2606 OID 31342)
-- Name: frequenta frequenta_id_iscritto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.frequenta
    ADD CONSTRAINT frequenta_id_iscritto_fkey FOREIGN KEY (id_iscritto) REFERENCES public.iscritto(id_iscritto);


--
-- TOC entry 3312 (class 2606 OID 31357)
-- Name: insegna insegna_id_attivita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insegna
    ADD CONSTRAINT insegna_id_attivita_fkey FOREIGN KEY (id_attivita) REFERENCES public.corsi(id_attivita);


--
-- TOC entry 3313 (class 2606 OID 31362)
-- Name: insegna insegna_id_istruttori_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insegna
    ADD CONSTRAINT insegna_id_istruttori_fkey FOREIGN KEY (id_istruttori) REFERENCES public.istruttori(matricola);


--
-- TOC entry 3304 (class 2606 OID 31268)
-- Name: iscritto iscritto_id_iscritto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT iscritto_id_iscritto_fkey FOREIGN KEY (id_iscritto) REFERENCES public.persone(id_persona);


--
-- TOC entry 3305 (class 2606 OID 31273)
-- Name: iscritto iscritto_tip_abbonamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT iscritto_tip_abbonamento_fkey FOREIGN KEY (tip_abbonamento) REFERENCES public.tariffario(codice);


--
-- TOC entry 3307 (class 2606 OID 31310)
-- Name: istruttori istruttori_matricola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istruttori
    ADD CONSTRAINT istruttori_matricola_fkey FOREIGN KEY (matricola) REFERENCES public.contratti(num_contratto);


--
-- TOC entry 3314 (class 2606 OID 31374)
-- Name: lavoratori lavoratori_matricola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lavoratori
    ADD CONSTRAINT lavoratori_matricola_fkey FOREIGN KEY (matricola) REFERENCES public.contratti(num_contratto);


--
-- TOC entry 3309 (class 2606 OID 31332)
-- Name: orari orari_id_attivita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orari
    ADD CONSTRAINT orari_id_attivita_fkey FOREIGN KEY (id_attivita) REFERENCES public.corsi(id_attivita);


--
-- TOC entry 3315 (class 2606 OID 31400)
-- Name: organizzazione organizzazione_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizzazione
    ADD CONSTRAINT organizzazione_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.eventi(id_evento);


--
-- TOC entry 3316 (class 2606 OID 31405)
-- Name: organizzazione organizzazione_matricola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizzazione
    ADD CONSTRAINT organizzazione_matricola_fkey FOREIGN KEY (matricola) REFERENCES public.lavoratori(matricola);


--
-- TOC entry 3317 (class 2606 OID 31410)
-- Name: organizzazione organizzazione_responsabile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizzazione
    ADD CONSTRAINT organizzazione_responsabile_fkey FOREIGN KEY (responsabile) REFERENCES public.lavoratori(matricola);


--
-- TOC entry 3320 (class 2606 OID 31437)
-- Name: prestazioni prestazioni_id_professionista_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestazioni
    ADD CONSTRAINT prestazioni_id_professionista_fkey FOREIGN KEY (id_professionista) REFERENCES public.professionisti(matricola);


--
-- TOC entry 3306 (class 2606 OID 31298)
-- Name: professionisti professionisti_matricola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionisti
    ADD CONSTRAINT professionisti_matricola_fkey FOREIGN KEY (matricola) REFERENCES public.contratti(num_contratto);


--
-- TOC entry 3318 (class 2606 OID 31425)
-- Name: pubblicizzato pubblicizzato_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubblicizzato
    ADD CONSTRAINT pubblicizzato_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.eventi(id_evento);


--
-- TOC entry 3319 (class 2606 OID 31420)
-- Name: pubblicizzato pubblicizzato_p_iva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubblicizzato
    ADD CONSTRAINT pubblicizzato_p_iva_fkey FOREIGN KEY (p_iva) REFERENCES public.sponsor(p_iva);


--
-- TOC entry 3321 (class 2606 OID 31452)
-- Name: usufruisce usufruisce_id_iscritto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usufruisce
    ADD CONSTRAINT usufruisce_id_iscritto_fkey FOREIGN KEY (id_iscritto) REFERENCES public.iscritto(id_iscritto);


--
-- TOC entry 3322 (class 2606 OID 31447)
-- Name: usufruisce usufruisce_id_prestazione_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usufruisce
    ADD CONSTRAINT usufruisce_id_prestazione_fkey FOREIGN KEY (id_prestazione) REFERENCES public.prestazioni(id_prestazioni);


-- Completed on 2023-06-20 11:06:36

--
-- PostgreSQL database dump complete
--

--QUERY 1: I TRE CORSI CON IL MAGGIOR NUMERO DI ISCRITTI 

SELECT tipologia, count(*) as num_iscritti
FROM iscritto,frequenta, corsi
WHERE iscritto.id_iscritto = frequenta.id_iscritto
	  and frequenta.id_attività = corsi.id_attivita
GROUP BY tipologia 
ORDER BY num_iscritti DESC
LIMIT 3 

--QUERY 2:TUTTI GLI ISCRITTI CHE USUFRUISCONO DI ALMENO UNA PRESTAZIONE

SELECT nome, cognome, data, orario, tipologia, costo 
FROM persone, iscritto, usufruisce, prestazioni
WHERE persone.id_persona = iscritto.id_iscritto and iscritto.id_iscritto = usufruisce.id_iscritto and
	  prestazioni.id_prestazioni = usufruisce.id_prestazione 
					   
--QUERY 3: CONTRATTI SCADUTI

SELECT num_contratto, cognome, nome, cf, telefono, email, tipologia_contratto, data_assunzione, scadenza_contratto
FROM CONTRATTI
WHERE num_contratto in (SELECT num_contratto
						FROM contratti
						WHERE num_contratto NOT IN ((select matricola
 													 from istruttori) 
													 UNION 
													 (select matricola
 													  from professionisti)  
													  UNION 
													 (select matricola
 													  from LAVORATORi)))
													  
													  
--QUERY 4: TROVARE GUADAGNO E SPESA TOTALE DELL'AZIENDA

DROP VIEW IF EXISTS guadagno_tot;
DROP VIEW IF EXISTS spesa_tot;
CREATE VIEW guadagno_tot as
((SELECT sum(costo) as guadagno
FROM usufruisce, prestazioni
WHERE usufruisce.id_prestazione = prestazioni.id_prestazioni)
UNION
(SELECT sum(prezzo) as guadagno
FROM iscritto, tariffario
WHERE iscritto.tip_abbonamento = tariffario.codice));

CREATE VIEW spesa_tot AS
(SELECT sum(stipendio) as stipendio
FROM contratti
WHERE num_contratto IN ((select matricola
							 from istruttori) 
							 UNION 
    						 (select matricola
 							 from professionisti)  
    						 UNION 
						     (select matricola
 							  from LAVORATORi)));

SELECT sum(guadagno_tot.guadagno) as guadagno_totale, sum(spesa_tot.stipendio) as spesa_totale
FROM guadagno_tot, spesa_tot

--QUERY 5: NOME E COGNOME DEGLI ISCRITTI CHE FREQUENTANO PIÙ DI UN CORSO

SELECT nome, cognome
FROM iscritto, persone
WHERE persone.id_persona = iscritto.id_iscritto and id_iscritto IN (SELECT iscritto.id_iscritto
					   FROM iscritto,frequenta, corsi
					   WHERE iscritto.id_iscritto = frequenta.id_iscritto
	  				   and frequenta.id_attività = corsi.id_attivita 
					   GROUP BY iscritto.id_iscritto
					   HAVING count(iscritto.id_iscritto) > 1)
					   
-- QUERY 6: Dato un evento inserito dall'utente ritorna la mtraicola,il nome e il cognome del responsabile, lo sponsor e il budget

SELECT responsabile as matricola_responsabile, cognome, contratti.nome, azienda, budget
FROM CONTRATTI, organizzazione, eventi, sponsor, pubblicizzato
WHERE organizzazione.responsabile = contratti.num_contratto
and organizzazione.id_evento = eventi.id_evento
 and eventi.id_evento = pubblicizzato.id_evento 
 and pubblicizzato.p_iva = sponsor.p_iva and eventi.nome='Memorial_Mario_Zanchi'

-- QUERY 7: DATI NOME E COGNOME DI UN ISCRITTO TROVA CHE TIPOLOGIA DI TARIFFARIO HA PAGATO E CHE CORSI FREQUENTA

SELECT tariffario.tipologia, iscritto.data_inizio, iscritto.scadenza, corsi.tipologia
FROM iscritto, frequenta, corsi, tariffario
WHERE tariffario.codice = iscritto.tip_abbonamento and iscritto.id_iscritto = frequenta.id_iscritto and frequenta.id_attività = corsi.id_attivita 
	  and iscritto.id_iscritto in (select id_persona 
								   from persone
								   where nome = 'Gennaro' and cognome = 'Bucchio') 
								   
--QUERY 8: DATA L'AZIENDA TROVARE CHE BUDGET ESSA HA OFFERTO PER OGNI EVENTO ALLA QUALE HA PARTECIPATO

SELECT nome, budget as budget_evento, budget_offerto
FROM eventi, sponsor, pubblicizzato
WHERE azienda = 'I.C.E._Srl' and sponsor.p_iva = pubblicizzato.p_iva and eventi.id_evento = pubblicizzato.id_evento


--QUERY 9: TROVARE LA MEDIA DEI BUDGET OFFERTI DELLE AZIENDE SUPERIORI A UN CERTO VALORE INSERITO DALL'UTENTE

SELECT azienda, avg(pubblicizzato.budget_offerto)::numeric(10,2) as massimo_budget_offerto 
FROM pubblicizzato,sponsor
WHERE sponsor.p_iva = pubblicizzato.p_iva
GROUP BY pubblicizzato.p_iva, azienda
HAVING avg(pubblicizzato.budget_offerto) > '400'
ORDER BY azienda

--QUERY 10: Dato il nome e il cognome del professionista ritorna il guadagno del professionista e il numero dei suoi clienti diviso per tipologia di servizio

SELECT sum(prestazioni.costo) as Totale_guadagno_del_professionista, count(usufruisce.id_iscritto) as numero_clienti, prestazioni.tipologia
FROM contratti, prestazioni, professionisti, usufruisce
WHERE contratti.nome ='Nino' and contratti.cognome ='Toscano' and contratti.num_contratto = professionisti.matricola
	  and professionisti.matricola = prestazioni.id_professionista and prestazioni.id_prestazioni = usufruisce.id_prestazione
GROUP BY prestazioni.tipologia 