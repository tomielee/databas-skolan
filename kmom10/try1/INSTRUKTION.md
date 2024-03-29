---
author:
    - mos
category:
    - kurs databas
    - examination
revision:
    "2019-03-28": "(A, mos) Examinationen 28 mars 2019."
...
Examination 28 mars 2019
=======================================

Detta är den individuella examinationen som är en del av kmom10.

<!--
Du kan läsa detta dokumentet i webbläsaren via länken "[Examination 28 mars 2019](https://dbwebb.se/kurser/databas-v1/kmom10/tentamen/sapo)"
-->

Uppgifterna skall lösas individuellt och du får inte prata, diskutera eller chatta med någon för att ta hjälp. Fråga läraren om något är oklart med uppgifterna. Om du är distansstudent så kan du använda kursens Gitter-kanal, eller forumet, för att ställa allmänna frågor till läraren.

Övriga hjälpmedel är tillåtna, inklusive egen dator, access till Internet och tillgång till tidigare kursmoment och ditt kursrepo.

Examinationen är begränsad till 5 timmar. 

Du kan maximalt få 30 poäng. Du behöver samla minst 18 poäng (60%) för att bli godkänd på tentamen. Samla fler poäng för att nå ett högre slutbetyg på kursen. 

<!--more-->


Du har troligen redan gjort `dbwebb exam checkout try1`.

Spara all kod i `me/kmom10/try1`.

Missa inte att läsa sista stycket om hur du skall lämna in din examination.

Innan du börjar, läs igenom hela dokumentet så att du får en uppfattning om uppgifterna, poängfördelningen och vad uppgifterna omfattar.



Inledning {#inledning}
---------------------------------------

Du har fått ett jobb på [Säkerhetspolisens (SÄPO)](https://www.sakerhetspolisen.se) hemliga avdelning för att utreda samband mellan olika brott och förberedelser till brott. Det är första veckan på jobbet och du vill framstå som en god databasprogrammerare.

Chefen har gett dig [ett excelark med lite data](https://docs.google.com/spreadsheets/d/1D7gi8G7WDlgkdKoLx9gT2NEq6IKEg4i3DcpPGGoSeME/edit?usp=sharing) och bett dig "fixa lite snygga rapporter" inför veckans avdelningsmöte.

Du är redo, du har gjort sånt här förut, så du tar datat och påbörjar arbetet att slänga ihop en databas, här tänker du glänsa.



Uppgift 1 (20p) {#u1}
---------------------------------------

Bygg en databas med en webbklient och en terminalklient.



### Kodstandard små bokstäver {#sma}

Kom ihåg att vi använder en rekommenderad kodstandard som säger små bokstäver på tabeller, vyer, procedurer, triggers och kolumnnamn, eventuellt separerade med _.

Vad du än gör, var noggrann och konsekvent i hur du använder stora/små bokstäver, annars går det inte rätta din inlämning.



### Generella krav {#generellt}

1. Din katalog innehåller en `package.json` med samtliga externa moduler som används.

1. Inloggningsdetaljer till databasen skall sparas i `config/db/sapo.json`.

1. Javascript-kod som delas mellan klienterna, eller extra moduler, lägger du i katalogen `src`.



### Databasmodell {#databasmodell}

Du tittar i Excelfilen och skapar dig en bild av informationen.

Det finns en logg som sparar händelser där SÄPO-agenter har noterat misstänkt bottslighetet.

Loggen är kopplad mot Personer och Organisationer och varje händelse är av en Kategori.

1. Rita ett logiskt ER diagram över databasens tabeller. Spara diagrammet som `doc/er.pdf`.



### Databas {#databas}

Skapa databasen och fyll den med data.

1. SQL-filer lägger du i `sql/sapo`. Skapa filen `setup.sql` för att skapa databasen och användaren. Låt din databas heta `sapo` och ge användaren `user` full tillgång till databasen.

1. Skapa filen `ddl.sql` där du samlar all kod som skapar tabeller, vyer, procedurer, triggers och liknande. Använd den filen för att skapa databasens schema.

1. Skapa filen `insert.sql` med SQL-kod för att lägga in innehåll i tabellerna, motsvarande det som syns i Excelfilen. Innehållet kan du läsa in från CSV-filer eller manuellt via egenskapade INSERT-satser. CSV-filerna sparar du i samma katalog som sql-filerna (tänk på radbrytningar alá LF).

1. Om du skapar extra SQL-kod för att testa tabellerna, till exempel vanlig SELECT, så sparar du den koden i `dml.sql`.



### Webbklient {#webbklient}

Bygg en webbklient.

1. Skapa en webbklient med Express. Servern startas via `node index.js` och skall snurra på porten 1337.

1. Alla sidor skall ha en navigeringsdel så det går att klicka sig fram mellan sidorna, via navigeringen.

1. I webbklienten, skapa routen `/sapo/index` som visar en välkomstssida. Välj själv vad du visar på förstasidan.

1. All access från klienten mot databasen skall gå via lagrade procedurer.

1. Skapa routen `/sapo/logg` som visar en rapport från tabellen `logg` tillsammans med organisationens namn, personens fulla namn och nivå på brottskategorin.

1. Lägg till länken i navbaren.



### Terminalklient {#terminalklient}

1. Bygg ett terminalprogram och spara main-funktionen i `cli.js`. Terminalprogrammet skall startas med `node cli.js`.

1. All access från klienten mot databasen skall gå via lagrade procedurer.

1. Ditt terminalprogram skall fungera som en oändlig kommandoloop där man kan skriva in kommandon som programmet utför. Det skall finnas ett kommando `menu` som visar menyn med samtliga kommandon. När man skriver kommandot `exit` skall programmet avslutas.

1. Skapa kommandot `logg` som visar en rapport från tabellen `logg` tillsammans med organisationens namn, personens fulla namn och nivå på brottskategorin.

1. Lägg till kommandot så det syns när man kör `menu`.



### Backup med lagrade procedurer {#backproc}

Skapa en backup av din databas och spara den i `sql/sapo/backup.sql`.

Så här gör du för att få med de lagrade procedurerna.

```text
mysqldump -udbwebb -p --routines sapo > backup.sql
# alterativt
mysqldump -udbwebb -p --routines --result-file=backup.sql sapo
```

Om du använder en specifik CHARSET/COLLATION när du gör CREATE DATABASE, så behöver du ta din backup så här.

```text
mysqldump -udbwebb -p --routines --add-drop-database --databases sapo > backup.sql
# alterativt
mysqldump -udbwebb -p --routines --add-drop-database --result-file=backup.sql --databases sapo
```

Är din backup felaktig går det inte att rätta din inlämning.

Inspektera gärna din backupfil innan du känner dig nöjd (titta på den i texteditorn).



Uppgift 2 (5p) {#u2}
---------------------------------------

Chefen kommer förbi och hävdar bestämt att det behövs en sökfunktion i ditt verktyg som visar loggen. Man skall kunna söka på delsträngar av kategorier, personer (id, fornamn, efternamn), organisationer (id, namn) och loggtexten (vad) samt exakt sökning på säkerhetsnivån (kategorin).

1. I webbklienten, skapa routen `sapo/search` där man i ett formulär kan ange en söksträng. Visa samma rapport som du skapade tidigare, men visa enbart de rader som matchar söksträngen.

1. Lägg till länken i navbaren.

1. I terminalklienten, skapa kommandot `search <str>` som visar motsvarande.

1. Lägg till kommandot så det syns när man kör `menu`.



Uppgift 3 (5p) {#u2}
---------------------------------------

Denna uppgiften är lite extra svår och kan tvinga dig att pilla lite extra med din SQL-konstruktion, kanske till och med googla lite ny information.

Chefen är stressad och precis innan mötet börjar så kommer han till dig och ber om en mycket specifik rapport. Han säger "rapporten måste se ut EXAKT som den jag visar här". Du gör som han säger, även om rapporten ser aningen udda ut.

Det handlar om att visa alla personer och visa antalet händelser de eventuellt varit inblandade i och vilka organisationer de varit kopplade till.

Studera utskriften nedan extra noggrant, skriv sedan SQL-kod som löser EXAKT samma rapport med EXAKT samma utskrift.

```text
+----------------------------+-------+---------------------------------------------------+
| Namn                       | Antal | Organisation                                      |
+----------------------------+-------+---------------------------------------------------+
| Mumintrollet Mumin (mumin) |     2 | Henriks Änglar                                    |
| Mikael  Roos (mos)         |     2 | Internationell pengatvätt + Pensionerade spioner  |
| John Doe (jodoe)           |     1 | Pensionerade spioner                              |
| Jane Doe (jadoe)           |     0 | NULL                                              |
+----------------------------+-------+---------------------------------------------------+
```



Inlämning {#inlamning}
---------------------------------------

Läs noggrant, checka av varje punkt innan du är klar.

1. Innan du lämnar in så skall du se till att din kod validerar via `dbwebb validate`. Varje valideringsfel ger normalt avdrag med 1 poäng.

1. Uppdatera din databasbackup i `sql/sapo/backup.sql` så att den är aktuell.

1. Lämna slutligen in genom att göra `dbwebb exam seal try1`.

1. När du är helt klar så går du in på Canvas och "lämnar in" tentan genom att skriva "KLAR!" följt av din akronym. Om det är något särskilt som läraren behöver veta om din inlämning så skriver du det.

Vid problem, gör en `dbwebb upload` och maila sedan mos@bth.se och berätta vad som hänt och ange ditt namn och studentakronym.
