#include<cstdio>
#include<iostream>
#include<fstream>
#include<string>
#include<sstream>
#include<limits>
#include"libpq/libpq-fe.h"
#include"funzioni_progetto.h"
#define PG_HOST "localhost" // oppure " localhost " o " postgresql "
#define PG_USER "postgres" // il vostro nome utente
#define PG_DB "postgres" // il nome del database
#define PG_PASS "DieD10.1" // la vostra password
#define PG_PORT 5432
//using namespace std ;
using std::cout;
using std::endl;
using std::string;
using std::cin;
using std::stringstream;

//la funzione controlla_stringa prende la stringa in input e la converte in int
//PRE: prende input una stringa e un numero intero

int controlla_stringa(string stringa, int scelta){
    stringstream ss;
    ss << stringa;
    ss >> scelta;
    if(scelta == 0){
        return 0;
    }
    else if (scelta < 0 || scelta > 10){
        return 11;
    } 
    else{
        return scelta;
    }
        
}
//POST: restituisce 0 se scelta = 0 (quindi o è stato inserito 0 o una stringa contenente caratteri),
//restituisce 11 se il numero inserito è negativo o maggiore di 10, restituisce scelta

int main( int argc , char * argv[]) {
    //cout<< " Start " << endl ;

   /* string a;
    cout<<"inserisci stringa:";
    cin>>a;
    cout<<a;*/

    char conninfo[250];

    sprintf(conninfo, "user=%s password=%s dbname=%s host=%s port =%d", PG_USER , PG_PASS , PG_DB , PG_HOST , PG_PORT);

    PGconn *conn = PQconnectdb(conninfo);

    if( PQstatus(conn) != CONNECTION_OK ) {
        cout<< "Errore di connessione \n" << PQerrorMessage( conn );
        PQfinish( conn );
        exit(1) ;
    }
    cout<< "Connessione avvenuta correttamente "<< endl ;
    cout<<"Benvenuti nel gestionale Active Pool"<<endl;

    string stringa;
    int scelta = 0;
    bool x = true;
    cout<<"Inserire il numero della query desiderata [1-10], [0] o un carattere chiudono il programma"<<endl;

    while( x == true){//il ciclo si ripete finche x == vero , se viene inserita una stringa o lo 0 si esce dal programma terminandolo
        scelta = 0;
        

        cout<<""<<endl;
        cout<<"1) QUERY_1: I tre corsi con il maggior numero di iscritti"<<endl;
        cout<<"2) QUERY_2: Tutti gli iscritti che usufruiscono di almeno una prestazione"<<endl;
        cout<<"3) QUERY_3: Trova i contratti scaduti"<<endl;
        cout<<"4) QUERY_4: Trova Guadagno e Spesa totale dell'azienda"<<endl;
        cout<<"5) QUERY_5: Trova Nome e Cognome degli iscritti che frequentano piu' di un corso"<<endl;
        cout<<"6) QUERY_6: Dato un evento trova L'azienda che vi ha partecipato, il responsabile e il budget"<<endl;
        cout<<"7) QUERY_7: Dato Nome e Cognome di un iscritto trova la tipologia di abbonamento pagato e i corsi che frequenta"<<endl;
        cout<<"8) QUERY_8: Data l'azienda trova che budget essa ha offerto per ogni evento alla quale ha partecipato "<<endl;
        cout<<"9) QUERY_9: Trova la media dei budget offerti dalle aziende superiori a una certa soglia inserita dall'utente"<<endl;
        cout<<"10) QUERY_10: Dato il professionista trova il numero_clienti e il guadagno totale delle prestazioni\n"<<endl;
        cout<<"Quale query si vuole visualizzare: ";
        cin>>stringa;
        scelta = controlla_stringa(stringa, scelta);
        
        cin.ignore(80,'\n');

            switch(scelta){
                case 0://Caso di uscita
                    cout<<"Arrivederci"<<endl;
                    x = false;
                    return 0;
                break;
                case 11://Caso di restart per far provare all'utente che magari ha sbagliato a digitare
                    cout<<"Fuori range riprova"<<endl;
                break;
                case 1://funziona
                    QUERY_1(conn);
                break;
                case 2://funziona
                    QUERY_2(conn);
                break;
                case 3://funziona
                    QUERY_3(conn);
                break;
                 case 4://funziona
                    QUERY_4(conn);
                break;
                case 5://funziona
                    QUERY_5(conn);
                break;
                case 6://funziona
                    QUERY_6(conn);
                break;
                case 7://funziona
                    QUERY_7(conn);
                break;
                case 8://funziona
                    QUERY_8(conn);
                break;
                case 9://funziona
                    QUERY_9(conn);
                break;
                case 10://funziona
                    QUERY_10(conn);
                break; 
                default://chiude il programma
                    cout<<"Arrivederci"<<endl;
                    x = false;
                    //cin.clear();
                    //cin.ignore(1000, '\n');
                break;
        }
    }
}
