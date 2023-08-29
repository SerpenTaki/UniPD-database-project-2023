#include<cstdio>
#include<iostream>
#include<fstream>
#include"libpq/libpq-fe.h"
#include"funzioni_progetto.h"
//using namespace std;
using std::cout;
using std::endl;
using std::string;
using std::cin;

void checkResults( PGresult * res , const PGconn * conn ){
    if ( PQresultStatus( res ) != PGRES_TUPLES_OK ) {
        cout << " Risultati inconsistenti " << PQerrorMessage( conn );
        PQclear( res );
        exit(1) ;
    }
} 

void printLine(int campi, int* maxChar){
    for (int j = 0; j < campi; ++j) {
        cout << '+';
        for (int k = 0; k < maxChar[j] + 2; ++k)
            cout << '-';
    }
    cout << "+\n";
}
void printQuery(PGresult* res){
    // Preparazione dati
    const int tuple = PQntuples(res), campi = PQnfields(res);
    string v[tuple + 1][campi];

    for (int i = 0; i < campi; ++i) {
        string s = PQfname(res, i);
        v[0][i] = s;
    }
    for (int i = 0; i < tuple; ++i)
        for (int j = 0; j < campi; ++j) {
            if (string(PQgetvalue(res, i, j)) == "t" || string(PQgetvalue(res, i, j)) == "f")
                if (string(PQgetvalue(res, i, j)) == "t")
                    v[i + 1][j] = "si";
                else
                    v[i + 1][j] = "no";
            else
                v[i + 1][j] = PQgetvalue(res, i, j);
        }

    int maxChar[campi];
    for (int i = 0; i < campi; ++i)
        maxChar[i] = 0;

    for (int i = 0; i < campi; ++i) {
        for (int j = 0; j < tuple + 1; ++j) {
            int size = v[j][i].size();
            maxChar[i] = size > maxChar[i] ? size : maxChar[i];
        }
    }

    // Stampa effettiva delle tuple
    printLine(campi, maxChar);
    for (int j = 0; j < campi; ++j) {
        cout << "| ";
        cout << v[0][j];
        for (int k = 0; k < maxChar[j] - v[0][j].size() + 1; ++k)
            cout << ' ';
        if (j == campi - 1)
            cout << "|";
    }
    cout << endl;
    printLine(campi, maxChar);

    for (int i = 1; i < tuple + 1; ++i) {
        for (int j = 0; j < campi; ++j) {
            cout << "| ";
            cout << v[i][j];
            for (int k = 0; k < maxChar[j] - v[i][j].size() + 1; ++k)
                cout << ' ';
            if (j == campi - 1)
                cout << "|";
        }
        cout << endl;
    }
    printLine(campi, maxChar);
}

void QUERY_1(PGconn *conn){
    PGresult *p;
    cout<<"I tre corsi con il maggior numero di iscritti sono: "<<endl;
    p = PQexec(conn, "SELECT tipologia, count(*) as num_iscritti FROM iscritto,frequenta, corsi WHERE iscritto.id_iscritto = frequenta.id_iscritto and frequenta.id_attività = corsi.id_attivita GROUP BY tipologia ORDER BY num_iscritti DESC LIMIT 3");
    printQuery(p);
    PQclear(p);
}

void QUERY_2(PGconn *conn){
    PGresult * p;
    cout<<"Tutti gli iscritti che usufruiscono di almeno una prestazione sono: "<<endl;
    p = PQexec(conn, "SELECT nome, cognome, data, orario, tipologia, costo FROM persone, iscritto, usufruisce, prestazioni WHERE persone.id_persona = iscritto.id_iscritto and iscritto.id_iscritto = usufruisce.id_iscritto and prestazioni.id_prestazioni = usufruisce.id_prestazione");
    printQuery(p);
    PQclear(p);
}

void QUERY_3(PGconn *conn){
    PGresult * p;
    cout<<"Trova tutti i contratti scaduti "<<endl;
    p = PQexec(conn, "SELECT num_contratto, cognome, nome, cf, telefono, email, tipologia_contratto, data_assunzione, scadenza_contratto FROM CONTRATTI WHERE num_contratto in (SELECT num_contratto FROM contratti WHERE num_contratto NOT IN ((select matricola from istruttori) UNION (select matricola from professionisti) UNION (select matricola from LAVORATORi)))");
    printQuery(p);
    PQclear(p);
}

void QUERY_4(PGconn *conn){
    PGresult * p;
    cout<<"Il guadagno e la spesa totale dell'azienda sono: "<<endl;
    p = PQexec(conn, "DROP VIEW IF EXISTS guadagno_tot; DROP VIEW IF EXISTS spesa_tot; CREATE VIEW guadagno_tot as ((SELECT sum(costo) as guadagno FROM usufruisce, prestazioni WHERE usufruisce.id_prestazione = prestazioni.id_prestazioni) UNION (SELECT sum(prezzo) as guadagno FROM iscritto, tariffario WHERE iscritto.tip_abbonamento = tariffario.codice)); CREATE VIEW spesa_tot AS (SELECT sum(stipendio) as stipendio FROM contratti WHERE num_contratto IN ((select matricola from istruttori) UNION (select matricola from professionisti) UNION (select matricola from LAVORATORi))); SELECT sum(guadagno_tot.guadagno) as guadagno_totale, sum(spesa_tot.stipendio) as spesa_totale FROM guadagno_tot, spesa_tot ");
    printQuery(p);
    PQclear(p);
}

void QUERY_5(PGconn *conn){
    PGresult * p;
    cout<<"Il nome e cognome degli iscritti che frequentano piu' di un corso sono: "<<endl;
    p = PQexec(conn, "SELECT nome, cognome FROM iscritto, persone WHERE persone.id_persona = iscritto.id_iscritto and id_iscritto IN (SELECT iscritto.id_iscritto FROM iscritto,frequenta, corsi WHERE iscritto.id_iscritto = frequenta.id_iscritto and frequenta.id_attività = corsi.id_attivita GROUP BY iscritto.id_iscritto HAVING count(iscritto.id_iscritto) > 1)");
    printQuery(p);
    PQclear(p);
}

void QUERY_6(PGconn *conn){
    PGresult * p;
    cout<<"Dato un evento x trova L'azienda che vi ha partecipato, il responsabile e il budget"<<endl;
    string querya = "SELECT responsabile as matricola_responsabile, cognome, contratti.nome, azienda, budget FROM CONTRATTI, organizzazione, eventi, sponsor, pubblicizzato WHERE organizzazione.responsabile = contratti.num_contratto and organizzazione.id_evento = eventi.id_evento and eventi.id_evento = pubblicizzato.id_evento and pubblicizzato.p_iva = sponsor.p_iva and eventi.nome = $1 ::varchar";
    PGresult *stmt = PQprepare(conn, "querya", querya.c_str (), 1, NULL);

    string Evento; //inserire evento
    cout << "Inserire nome evento: ";
    cin >> Evento;
    const char * parameter1 = Evento.c_str();
    p = PQexecPrepared(conn, "querya", 1, &parameter1, NULL, 0, 0);
    cout<<"L'azienda, il responsabile e il budget per un evento x sono: "<<endl;
    printQuery(p);
    PQclear(p);
}

void QUERY_7(PGconn *conn){
    cout<<"Dato Nome e Cognome di un iscritto trova la tipologia di abbonamento pagato e i corsi che frequenta"<<endl;
    PGresult * res;
    string query = "SELECT tariffario.tipologia, iscritto.data_inizio, iscritto.scadenza, corsi.tipologia FROM iscritto, frequenta, corsi, tariffario WHERE tariffario.codice = iscritto.tip_abbonamento and iscritto.id_iscritto = frequenta.id_iscritto and frequenta.id_attività = corsi.id_attivita and iscritto.id_iscritto in (select id_persona from persone where nome = $1 ::varchar and cognome = $2 ::varchar)";

    PGresult *stmt = PQprepare(conn, "query", query.c_str (), 2, NULL);

    string Nome, Cognome ; // il nostro parametro
    cout << "Inserire nome: " ;
    cin >> Nome ;
    cout << "Inserire cognome: ";
    cin >> Cognome;
    const char * parameter[2];
    parameter[0] = Nome.c_str() ;
    parameter[1] = Cognome.c_str() ;
    res = PQexecPrepared( conn, "query", 2 , parameter, NULL, 0, 0);
    checkResults( res , conn ) ;

    cout<<"Ecco qui il risultato: "<<endl;
    printQuery(res);
    PQclear(res);
}

void QUERY_8(PGconn *conn){
    PGresult * p;
    cout<<"Data l'azienda x trova che budget essa ha offerto per ogni evento alla quale ha partecipato "<<endl;
    string queryc = "SELECT nome, budget as budget_evento, budget_offerto FROM eventi, sponsor, pubblicizzato WHERE azienda = $1 ::varchar and sponsor.p_iva = pubblicizzato.p_iva and eventi.id_evento = pubblicizzato.id_evento";

    PGresult *stmt = PQprepare(conn, "queryc", queryc.c_str (), 1, NULL);

    string Azienda;
    cout << "Inserire nome azienda: ";
    cin >> Azienda;
    const char * parameter3 = Azienda.c_str();
    p = PQexecPrepared(conn, "queryc", 1, &parameter3, NULL, 0, 0);
    
    cout<<"Il Budget offerto da azienda x ad un determinato evento: "<<endl;
    printQuery(p);
    PQclear(p);
}

void QUERY_9(PGconn *conn){
    PGresult * p;
    cout<<"Trova la media dei budget offerti dalle aziende superiori a una certa soglia inserita dall'utente"<< endl;
    string queryd = "SELECT azienda, avg(pubblicizzato.budget_offerto)::numeric(10,2) as massimo_budget_offerto FROM pubblicizzato,sponsor WHERE sponsor.p_iva = pubblicizzato.p_iva GROUP BY pubblicizzato.p_iva, azienda HAVING avg(pubblicizzato.budget_offerto) > $1::int ORDER BY azienda";

    PGresult *stmt = PQprepare(conn, "queryd", queryd.c_str (), 1, NULL);

    string Soglia;
    cout << "Inserire Soglia (intero non negativo) : ";
    cin >> Soglia;
    const char * parameter4 = Soglia.c_str();
    p = PQexecPrepared(conn, "queryd", 1, &parameter4, NULL, 0, 0);

    cout<<"La media dei budget offerti dalle azienda superiori ad una soglia definta e': "<< endl;
    printQuery(p);
    PQclear(p);
}

void QUERY_10(PGconn *conn){
    PGresult * p;
    cout<<"Dato il professionista trova gli iscritti che hanno usufruito della prestazione e il guadagno totale delle prestazioni"<<endl;
    string querye = "SELECT sum(prestazioni.costo) as Totale_guadagno_del_professionista, count(usufruisce.id_iscritto) as numero_clienti, prestazioni.tipologia FROM contratti, prestazioni, professionisti, usufruisce WHERE contratti.nome = $1 ::varchar and contratti.cognome = $2 ::varchar and contratti.num_contratto = professionisti.matricola and professionisti.matricola = prestazioni.id_professionista and prestazioni.id_prestazioni = usufruisce.id_prestazione GROUP BY prestazioni.tipologia";

    PGresult *stmt = PQprepare(conn, "querye", querye.c_str (), 2, NULL);

    string Nome, Cognome;
    cout << "Inserire Nome professionista: ";
    cin >> Nome;
    cout << "Inserire Cognome professionista: ";
    cin >> Cognome;
    const char * parameter[2];
    parameter[0]= Nome.c_str();
    parameter[1]= Cognome.c_str();
    p = PQexecPrepared( conn, "querye",2 , parameter, NULL, 0,0);
    checkResults( p , conn ) ;

    cout<<"Risultato"<<endl;
    printQuery(p);
    PQclear(p);
}