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