unit u_startseite_und_navstruktur;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;
 
procedure uebungsaufgabestellen(n:integer);  //ermöglicht Zugriff aus anderer Unit
procedure themengebietanzeigen(n:integer);

type

  { Tstartseiteundnavstruktur }

  Tstartseiteundnavstruktur = class(TForm)
    B_abschlusstest: TButton;
    B_lehrerlogin: TButton;
    B_beenden: TButton;
    B_mario: TImage;
    B_starten: TButton;
    B_thema1: TButton;
    B_thema2: TButton;
    B_thema3: TButton;
    B_thema4: TButton;
    B_thema5: TButton;
    B_ueb1: TButton;
    B_ueb2: TButton;
    B_ueb3: TButton;
    B_ueb4: TButton;
    B_ueb5: TButton;
    B_ueb6: TButton;
    E_klassenstufe: TEdit;
    E_nachname: TEdit;
    E_vorname: TEdit;
    P_abschlusstest: TPanel;
    P_thema1: TPanel;
    P_thema2: TPanel;
    P_thema3: TPanel;
    P_thema4: TPanel;
    P_thema5: TPanel;
    P_trennbalken1: TPanel;
    P_trennbalken2: TPanel;
    P_trennbalken3: TPanel;
    P_ueb1: TPanel;
    P_ueb2: TPanel;
    P_ueb3: TPanel;
    P_ueb4: TPanel;
    P_ueb5: TPanel;
    P_ueb6: TPanel;
    T_abschlusstest: TLabel;
    T_statzeit: TLabel;
    T_statpunkte: TLabel;
    T_statnote: TLabel;
    T_themengebiete: TLabel;
    T_uebungen: TLabel;
    T_vorname: TLabel;
    T_nachname: TLabel;
    T_klassenstufe: TLabel;
    T_alleDaten: TLabel;
    P_obengrau: TPanel;
    P_obenrot: TPanel;
    P_untengrau: TPanel;
    P_untenrot: TPanel;
    T_begruessung: TLabel;
    T_copyright: TLabel;
    T_dateneintragen: TLabel;
    T_thema: TLabel;
    T_ueberschrift: TLabel;
    T_stat: TLabel;
    procedure B_abschlusstestClick(Sender: TObject);
    procedure B_beendenClick(Sender: TObject);
    procedure B_lehrerloginClick(Sender: TObject);
    procedure B_startenClick(Sender: TObject);
    procedure B_thema1Click(Sender: TObject);
    procedure B_thema2Click(Sender: TObject);
    procedure B_thema3Click(Sender: TObject);
    procedure B_thema4Click(Sender: TObject);
    procedure B_thema5Click(Sender: TObject);
    procedure B_ueb1Click(Sender: TObject);
    procedure B_ueb2Click(Sender: TObject);
    procedure B_ueb3Click(Sender: TObject);
    procedure B_ueb4Click(Sender: TObject);
    procedure B_ueb5Click(Sender: TObject);
    procedure B_ueb6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
  nameglobal, speichername, klasseglobal,uebungsnummer:string; //public variablen um zugriff in anderer unit zu ermöglichen
  themennummer:integer;
  end;

var
  startseiteundnavstruktur: Tstartseiteundnavstruktur;

implementation
uses u_fragenkatalog, u_wissenstest, u_uebungen, u_themengebiete; //andere units einbinden
{$R *.lfm}

{ Tstartseiteundnavstruktur }
procedure uebungsaufgabestellen(n:integer);  //wird bei bei uebungsaufgabenbuttons ausgefuehrt
var fragentext,hinweistext:string;
begin
 uebungsaufgaben.T_frageindex.caption:='Übungsaufgabe: ' + inttostr(n);
 case n of  //Fragen für die jeweiligen Übungsfragennummern
   1: fragentext:='Ein Fernsehgerät mit „Full-HD“-Technik hat eine maximale Auflösung von 1920 x 1080 Pixel. Ermitteln Sie das Seitenverhältnis des dargestellten Bildes.';
   2: fragentext:='Berechnen Sie die Auflösung in Megapixel, die Sie an einem digitalen Fotoapparat einstellen müssten, um das Bild am Full-HD-Fernseher auf der gesamten Bildfläche verlustfrei ansehen zu können.';
   3: fragentext:='Ein Bild mit einer Auflösung von 8 MP im Seitenverhältnis 4:3 wird mit einer Farbtiefe von 24 Bit gespeichert. Wie groß ist der Speicherbedarf in Megabyte?';
   4: fragentext:='Eine Videokamera vom System „MiniDV“ hat eine Auflösung von 720 x 576 Pixeln. In welchem Seitenverhältnis steht das Bild?';
   5: fragentext:='Ein digitaler Fotoapparat ist für eine Auflösung von 12 Megapixel eingestellt. Wie sind die Pixelzahlen in horizontaler und vertikaler Richtung verteilt, bei einem Seitenverhältnis von 16:9.';
   6: fragentext:='Wie viel Prozent Bildfläche nimmt ein Bild mit einer Auflösung von 720 x 576 Pixeln auf einer Full-HD-Anzeige in Ansprung?';
 end;
 case n of  //Hinweise für die Eingabe des Ergenisses
   1: hinweistext:='Gib dein Ergebnis in folgender Form ein:  XX:YY.';
   2: hinweistext:='Gib dein Ergebnis ungerundet mit allen Nachkommastellen und ohne Einheit ein.';
   3: hinweistext:='Gib dein Ergebnis ungerundet mit allen Nachkommastellen und ohne Einheit ein.';
   4: hinweistext:='Gib dein Ergebnis in folgender Form ein:  XX:YY.';
   5: hinweistext:='Gib dein Ergebnis in folgender Form ein:  ZZZZ x YYYY.';
   6: hinweistext:='Gib dein Ergebnis als ganze Zahl in Prozent ein.';
 end;
 uebungsaufgaben.T_frage.caption:=fragentext;   //fuellt uebungsaufgabenseite mit inhalt
 uebungsaufgaben.T_hinweis.caption:=hinweistext;
 case length(fragentext) of //zeilenumbruch anhand der zeichenkettenlaenge
   1..80: uebungsaufgaben.T_frage.height:=25;
   81..160: uebungsaufgaben.T_frage.height:=50;
   161..250: uebungsaufgaben.T_frage.height:=75;
 end;
 uebungsaufgaben.E_loesung.text:='';
 if n=6 then uebungsaufgaben.B_naechste.enabled:=false  //de-/aktivieren des buttons wenn letzte aufgabe (nicht) erreicht
 else uebungsaufgaben.B_naechste.enabled:=true;
 if n=1 then uebungsaufgaben.B_zurueck.enabled:=false   //de-/aktivieren des buttons wenn letzte aufgabe (nicht) erreicht
 else uebungsaufgaben.B_zurueck.enabled:=true;
end;

procedure themengebietanzeigen(n:integer);
begin
 themengebiete.thema1.tabvisible:=false;  //ausblenden aller tabs der pagecontrol
 themengebiete.thema2.tabvisible:=false;
 themengebiete.thema3.tabvisible:=false;
 themengebiete.thema4.tabvisible:=false;
 themengebiete.thema5.tabvisible:=false;
 themengebiete.thema6.tabvisible:=false;
 themengebiete.thema7.tabvisible:=false;
 themengebiete.thema8.tabvisible:=false;
 themengebiete.thema9.tabvisible:=false;
 themengebiete.thema10.tabvisible:=false;
 themengebiete.thema11.tabvisible:=false;
 themengebiete.thema12.tabvisible:=false;
 (startseiteundnavstruktur.FindComponent('P_thema'+inttostr(n)) as TPanel).Color:=clgreen; //gruene panelfaerbung bei bearbeiteten themen
 case n of
   1: begin //themenspezifisches einblenden der tabs der pagecontrol
       themengebiete.thema1.tabvisible:=true;
       themengebiete.thema2.tabvisible:=true;
      end;
   2: begin
       themengebiete.thema3.tabvisible:=true;
       themengebiete.thema4.tabvisible:=true;
       themengebiete.thema5.tabvisible:=true;
       themengebiete.thema6.tabvisible:=true;
      end;
   3: begin
       themengebiete.thema7.tabvisible:=true;
       themengebiete.thema8.tabvisible:=true;
      end;
   4: begin
       themengebiete.thema9.tabvisible:=true;
       themengebiete.thema10.tabvisible:=true;
      end;
   5: begin
       themengebiete.thema11.tabvisible:=true;
       themengebiete.thema12.tabvisible:=true;
      end;
 end;
 if n=5 then themengebiete.B_naechste.enabled:=false  //de-/aktivieren des buttons wenn letzte aufgabe (nicht) erreicht
 else themengebiete.B_naechste.enabled:=true;
 if n=1 then themengebiete.B_zurueck.enabled:=false   //de-/aktivieren des buttons wenn letzte aufgabe (nicht) erreicht
 else themengebiete.B_zurueck.enabled:=true;
end;

procedure Tstartseiteundnavstruktur.B_beendenClick(Sender: TObject);
var mr: integer;
begin    //warnungsdialog bei klicken des beendenbuttons
  mr:=MessageDlg('Willst du das Programm wirklich beenden? Dabei gehen alle Fortschritte verloren!',mtWarning,[mbOk,mbCancel],0);
  if mr=mrOk then
   begin
    startseiteundnavstruktur.close;
   end;
end;

procedure Tstartseiteundnavstruktur.B_abschlusstestClick(Sender: TObject);
begin
  wissenstest.startzeit:=TimeToStr(now); //auslesen fuer zeitmessung uebergabe an wissenstestunit
  wissenstest.show;
  startseiteundnavstruktur.hide;
end;

procedure Tstartseiteundnavstruktur.B_lehrerloginClick(Sender: TObject);
begin
  fragenkat.show;
  startseiteundnavstruktur.hide;
end;

procedure Tstartseiteundnavstruktur.B_startenClick(Sender: TObject);
var i:integer;
begin
//fehlermeldung wenn nicht alle daten eingegeben wurden
if (E_vorname.text='') OR (E_nachname.text='') OR (E_klassenstufe.text='') then
 begin
  B_starten.left:=520;
  T_alledaten.show;
 end
else
 begin
  nameglobal:=E_vorname.text + ' ' + E_nachname.text;  //speichern von name und klasse
  speichername:=lowercase(E_vorname.text) + '_' + lowercase(E_nachname.text);  //gesonderter name für textdateiname
  klasseglobal:=E_klassenstufe.text;
  T_ueberschrift.hide;  //verstecken der begruessungselemente
  T_begruessung.hide;
  T_dateneintragen.hide;
  T_vorname.hide;
  T_nachname.hide;
  T_klassenstufe.hide;
  B_starten.hide;
  E_vorname.hide;
  E_nachname.hide;
  E_klassenstufe.hide;
  T_alledaten.hide;
  for i:=1 to 6 do  //anzeigen der navstruktur
   begin
    (FindComponent('P_ueb'+inttostr(i)) as TPanel).visible:=true;
    (FindComponent('P_ueb'+inttostr(i)) as TPanel).color:=clWhite;
    (FindComponent('B_ueb'+inttostr(i)) as TButton).visible:=true;
   end;
  for i:=1 to 5 do
   begin
   (FindComponent('P_thema'+inttostr(i)) as TPanel).visible:=true;
   (FindComponent('P_thema'+inttostr(i)) as TPanel).color:=clWhite;
   (FindComponent('B_thema'+inttostr(i)) as TButton).visible:=true;
   end;
  for i:=1 to 3 do (FindComponent('P_trennbalken'+inttostr(i)) as TPanel).visible:=true;
  P_abschlusstest.show;
  P_abschlusstest.color:=clWhite;
  B_abschlusstest.show;
  T_themengebiete.show;
  T_uebungen.show;
  T_abschlusstest.show;
  T_stat.show;
  T_statnote.show;
  T_statpunkte.show;
  T_statzeit.show;
  B_mario.top:=256;   //mariobild verschieben
  B_mario.left:=672;
 end;
end;

procedure Tstartseiteundnavstruktur.B_thema1Click(Sender: TObject);
begin
 themengebiete.show;
 startseiteundnavstruktur.hide;
 themengebietanzeigen(1);  //aufruf der themengebietsprozedur mit den jeweiligen indizies der themen
 themennummer:=1;
end;

procedure Tstartseiteundnavstruktur.B_thema2Click(Sender: TObject);
begin
 themengebiete.show;
 startseiteundnavstruktur.hide;
 themengebietanzeigen(2);  //aufruf der themengebietsprozedur mit den jeweiligen indizies der themen
 themennummer:=2;
end;

procedure Tstartseiteundnavstruktur.B_thema3Click(Sender: TObject);
begin
 themengebiete.show;
 startseiteundnavstruktur.hide;
 themengebietanzeigen(3);  //aufruf der themengebietsprozedur mit den jeweiligen indizies der themen
 themennummer:=3;
end;

procedure Tstartseiteundnavstruktur.B_thema4Click(Sender: TObject);
begin
 themengebiete.show;
 startseiteundnavstruktur.hide;
 themengebietanzeigen(4);  //aufruf der themengebietsprozedur mit den jeweiligen indizies der themen
 themennummer:=4;
end;

procedure Tstartseiteundnavstruktur.B_thema5Click(Sender: TObject);
begin
 themengebiete.show;
 startseiteundnavstruktur.hide;
 themengebietanzeigen(5);  //aufruf der themengebietsprozedur mit den jeweiligen indizies der themen
 themennummer:=5;
end;

procedure Tstartseiteundnavstruktur.B_ueb1Click(Sender: TObject);
begin
 uebungsaufgaben.show;
 startseiteundnavstruktur.hide;
 uebungsaufgabestellen(1);  //aufruf der uebungsaufgabenprozedur mit den jeweiligen indizies der uebungen
 uebungsnummer:=inttostr(1);
end;

procedure Tstartseiteundnavstruktur.B_ueb2Click(Sender: TObject);
begin
 uebungsaufgaben.show;
 startseiteundnavstruktur.hide;
 uebungsaufgabestellen(2);    //aufruf der uebungsaufgabenprozedur mit den jeweiligen indizies der uebungen
 uebungsnummer:=inttostr(2);
end;

procedure Tstartseiteundnavstruktur.B_ueb3Click(Sender: TObject);
begin
 uebungsaufgaben.show;
 startseiteundnavstruktur.hide;
 uebungsaufgabestellen(3);  //aufruf der uebungsaufgabenprozedur mit den jeweiligen indizies der uebungen
 uebungsnummer:=inttostr(3);
end;

procedure Tstartseiteundnavstruktur.B_ueb4Click(Sender: TObject);
begin
 uebungsaufgaben.show;
 startseiteundnavstruktur.hide;
 uebungsaufgabestellen(4);  //aufruf der uebungsaufgabenprozedur mit den jeweiligen indizies der uebungen
 uebungsnummer:=inttostr(4);
end;

procedure Tstartseiteundnavstruktur.B_ueb5Click(Sender: TObject);
begin
 uebungsaufgaben.show;
 startseiteundnavstruktur.hide;
 uebungsaufgabestellen(5);  //aufruf der uebungsaufgabenprozedur mit den jeweiligen indizies der uebungen
 uebungsnummer:=inttostr(5);
end;

procedure Tstartseiteundnavstruktur.B_ueb6Click(Sender: TObject);
begin
 uebungsaufgaben.show;
 startseiteundnavstruktur.hide;
 uebungsaufgabestellen(6);  //aufruf der uebungsaufgabenprozedur mit den jeweiligen indizies der uebungen
 uebungsnummer:=inttostr(6);
end;

procedure Tstartseiteundnavstruktur.FormCreate(Sender: TObject);
var i:integer;
begin
 uebungsnummer:='1';  //init themen und uebungsnummer
 themennummer:=1;
 for i:=1 to 6 do   //navstruktur verstecken
  begin
   (FindComponent('B_ueb'+inttostr(i)) as TButton).visible:=false;
   (FindComponent('P_ueb'+inttostr(i)) as TPanel).visible:=false;
  end;
 for i:=1 to 5 do
  begin
   (FindComponent('B_thema'+inttostr(i)) as TButton).visible:=false;
   (FindComponent('P_thema'+inttostr(i)) as TPanel).visible:=false;
  end;
 for i:=1 to 3 do (FindComponent('P_trennbalken'+inttostr(i)) as TPanel).visible:=false;
 B_abschlusstest.hide;
 P_abschlusstest.hide;
 T_themengebiete.hide;
 T_uebungen.hide;
 T_abschlusstest.hide;
 B_mario.picture.loadfromfile('images/mario_pixel.png');  //mariobild anzeigen
end;

end.

