#ifndef FUNZIONI_PROGETTO_H
#define FUNZIONI_PROGETTO_H
#include"libpq/libpq-fe.h"

void checkResults( PGresult * res , const PGconn * conn );
void printLine(int campi, int* maxChar);
void printQuery(PGresult* res);
void QUERY_1(PGconn *conn);//I tre corsi con il maggior numero di iscritti
void QUERY_2(PGconn *conn);//Tutti gli iscritti che usufruiscono di almeno una prestazione
void QUERY_3(PGconn *conn);//Contratti scaduti
void QUERY_4(PGconn *conn);//Trovare guadagno e spesa totale dell'azienda
void QUERY_5(PGconn *conn);//Trovare Nome e cognome degli iscritti che frequentano più di un corso
void QUERY_6(PGconn *conn);//Dato un evento trovare L'azienda, il responsabile e il budget 
void QUERY_7(PGconn *conn);//Dati nome e cognome di un iscritto trova che tipologia di tariffario ha pagato e che corsi frequenta
void QUERY_8(PGconn *conn);//Data l'azienda trovare che budget essa ha offerto per ogni evento alla quale ha partecipato
void QUERY_9(PGconn *conn);//Trovare la media dei budget offerti delle aziende superiori a un certo valore inserito dall'utente
void QUERY_10(PGconn *conn);//Dato il professionista mi ritorna gli iscritti che hanno usufruito della specifica prestazione e il guadagno totale delle prestazioni

#endif
