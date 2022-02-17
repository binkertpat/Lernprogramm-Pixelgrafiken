unit u_wissenstest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls;

type

  { Twissenstest }

  Twissenstest = class(TForm)
    B_auswerte: TButton;
    B_beenden: TButton;
    B_naechste: TButton;
    B_pruefe: TButton;
    T_fortschritt: TLabel;
    ProgressBar1: TProgressBar;
    P_obengrau: TPanel;
    P_obenrot: TPanel;
    P_untengrau: TPanel;
    P_untenrot: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    T_copyright: TLabel;
    T_frage: TLabel;
    T_frageindex: TLabel;
    T_richtigfalsch: TLabel;
    T_thema: TLabel;
    T_waehleantwort: TLabel;
    procedure B_auswerteClick(Sender: TObject);
    procedure B_beendenClick(Sender: TObject);
    procedure B_naechsteClick(Sender: TObject);
    procedure B_pruefeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
  startzeit:string; //public variable um zugriff in anderer unit zu ermöglichen
  end;

var
  wissenstest: Twissenstest;

implementation
uses u_startseite_und_navstruktur;  //bezugsunit einbinden
type Tfragenkatalog = record    //record für fragenkatalog
     index: integer;
     frage: string[250];
     antwort1:string[100];
     antwort2:string[100];
     antwort3:string[100];
     loesung:integer;
end;
var  datei:file of Tfragenkatalog;
     datensatz: Tfragenkatalog;
     datum,dateiname:string; //punkte und fragenzaehler, startzeit und datum
     fragenzaehler,fragennummer,punkteglobal,a,b,c,antwortfalscheins,antwortfalschzwei:integer;
     fragenundantworten:array[0..14,0..3] of string; //arrays für fragen, loesungen und schuelerantworten
     loesungen:array[0..14] of integer;
     gestelltefragen:array[0..14] of integer;
     antwortschueler:array[0..14] of integer;
     ergebnisse : textfile; //variablen für textdatei
     zeile:string;

{$R *.lfm}

{ Twissenstest }

function TestObWertInArray(Wert:Integer;Arr:Array of integer):Boolean;
var i:Integer;
begin
 result:=false;
 for i:=Low(Arr) To High(Arr) do  //durchlaeuft das eingegebene array und prueft ob wert enthalten
  begin
   if (Wert=Arr[i]) Then
    begin
     result:=True;   //wenn wert erhalten, dann 'true' als rueckabewert und abbruch
     break;
    end;
  end
end;

function summe1bisn(n:integer):integer;
begin
 if n=0 then result:=0
  else result:=n+summe1bisn(n-1);
end;

procedure richtig;
begin
 wissenstest.B_pruefe.hide;
 wissenstest.T_richtigfalsch.show;
 wissenstest.T_richtigfalsch.caption:='Richtige Antwort!';
 wissenstest.T_richtigfalsch.font.color:=clgreen;
 punkteglobal:=punkteglobal+1;
end;

procedure falsch;
begin
 wissenstest.B_pruefe.hide;
 wissenstest.T_richtigfalsch.show;
 wissenstest.T_richtigfalsch.caption:='Falsche Antwort!';
 wissenstest.T_richtigfalsch.font.color:=clred;
end;

procedure kontrolle;
begin
 //ueberpruefen der abgegeben antwort
 if (wissenstest.FindComponent('RadioButton'+ IntToStr(a)) as TRadioButton).checked then antwortschueler[fragennummer]:=1
 else antwortschueler[fragennummer]:=0;
 //solange nicht die 15. Frage erreicht ist fuehre kontrolle durch und erhoehe fragenzaehler +1
 //wenn 15. Frage erreicht ist, keine erhoehung von frage, anzeigen der auswertung
 if fragenzaehler=14 then
  begin
   if  antwortschueler[fragennummer]=1 then richtig
   else falsch;
   wissenstest.B_auswerte.show;
   wissenstest.B_beenden.hide;
  end
  else
   begin
    if antwortschueler[fragennummer]=1 then richtig
    else falsch;
    wissenstest.B_naechste.show;
   end;
 fragenzaehler:=fragenzaehler+1;  //zaehlt dúrchlaufene fragen, beginnt bei 0 -> 15. Frage=14
end;

procedure fragestellen;
var summefragennummern,i:integer;
begin
 wissenstest.Progressbar1.Min:=0; //progressbar für fortschrittsanzeige
 wissenstest.Progressbar1.Max:=15;
 wissenstest.ProgressBar1.Smooth:=True;
 wissenstest.ProgressBar1.Enabled:=True;
 wissenstest.ProgressBar1.Position:=fragenzaehler+1;
 summefragennummern:=0;
 fragennummer:=random(15);  //zufallszahlen fuer frage
 if fragenzaehler=0 then gestelltefragen[0]:=fragennummer  //ueberpruefung das keine frage gestellt wird die bereits gestellt wurde
 else if fragenzaehler=14 then
  begin
   for i:=0 to 13 do
    begin
     summefragennummern:=summefragennummern+gestelltefragen[i];
    end;
   fragennummer:=summe1bisn(14)-summefragennummern;
  end
  else WHILE TestObWertInArray(fragennummer, gestelltefragen)=true do fragennummer:=random(15);   //erzeuge solange zufallszahlen bis eine Zahl erzeugt wird die noch nicht gestellt wurde
 gestelltefragen[fragenzaehler]:=fragennummer;  //gepruefte fragennummer in array schreiben
 case length(fragenundantworten[fragennummer,0]) of //zeilenumbruch anhand der zeichenkettenlaenge
   1..80: wissenstest.T_frage.height:=25;
   81..160: wissenstest.T_frage.height:=50;
   161..250: wissenstest.T_frage.height:=75;
 end;
 wissenstest.T_frageindex.caption:='Frage ' + inttostr(fragenzaehler+1) + ':';  //auslesen von fragenzahl und fragentext
 wissenstest.T_frage.caption:=fragenundantworten[fragennummer,0]+'?';
 a:=random(3)+1; //zufallszahlen für Radiobuttons, damit bei mehreren versuchen nicht immer die gleiche antwort richtig ist
 case a of
   3: b:=2;
   2: b:=1;
   1: b:=2;
 end;
 c:=6-(a+b);
 case loesungen[fragennummer] of  //arraywerte für die falschen antworten bestimmen
   1: antwortfalscheins:=3;
   2: antwortfalscheins:=1;
   3: antwortfalscheins:=2;
 end;
 antwortfalschzwei:=6-(antwortfalscheins+loesungen[fragennummer]);
 //antworten anzeigen, mit druchschleifen der radiobuttons
(wissenstest.FindComponent('RadioButton'+ IntToStr(a)) as TRadioButton).caption:=fragenundantworten[fragennummer,loesungen[fragennummer]];
(wissenstest.FindComponent('RadioButton'+ IntToStr(b)) as TRadioButton).caption:=fragenundantworten[fragennummer,antwortfalscheins];
(wissenstest.FindComponent('RadioButton'+ IntToStr(c)) as TRadioButton).caption:=fragenundantworten[fragennummer,antwortfalschzwei];
end;

procedure Twissenstest.FormCreate(Sender: TObject);
var i:integer;
begin
 randomize;
 assignfile(datei,'fragenkatalog\fragen_wissenstest.db'); //fuellen des fragen/antworten arrays
 reset(datei);
 seek(datei,0);
 for i:=0 to 14 do
  begin
   seek(datei,i);
   read(datei,datensatz);
   fragenundantworten[i,0]:=datensatz.frage;
   fragenundantworten[i,1]:=datensatz.antwort1;
   fragenundantworten[i,2]:=datensatz.antwort2;
   fragenundantworten[i,3]:=datensatz.antwort3;
  end;
 for i:=0 to 14 do
  begin
   seek(datei,i);
   read(datei,datensatz);
   loesungen[i]:=datensatz.loesung;
  end;
 closefile(datei);
 fragenzaehler:=0;  //initieren der oberflaeche und der fragenvariable
 fragestellen;
 T_richtigfalsch.hide;
 B_naechste.hide;
 datum:=DateToStr(now);  //auslesen vom datum
end;

procedure Twissenstest.B_auswerteClick(Sender: TObject);
var note,i:integer; prozent:real; minuten,sekunden:string;
begin
 minuten:=FormatDateTime('nn',StrToTime(TimeToStr(now))-StrToTime(startzeit));  //mittels startzeit und endzeit benoetigte minuten und sekunden berechnen
 sekunden:=FormatDateTime('ss',StrToTime(TimeToStr(now))-StrToTime(startzeit));
 prozent:=(punkteglobal/15)*100; //Note berechnen
 note:=Round(prozent);
 case note of
   95..100: note:=1;
   80..94: note:=2;
   60..79: note:=3;
   45..59: note:=4;
   25..44: note:=5;
   0..24: note:=6;
 end;
 case note of   //hintergrundfarbe für Panel Abschlusstest, note 1-2:farbe gruen, note 3-4:farbe gelb, note 5-6:farbe rot
   1..2: startseiteundnavstruktur.P_abschlusstest.color:=clgreen;
   3..4: startseiteundnavstruktur.P_abschlusstest.color:=clyellow;
   5..6: startseiteundnavstruktur.P_abschlusstest.color:=clred;
 end;
 if note<=4 then  //name,punkte und note ausgeben als message
  begin
   ShowMessage('Herzlichen Glückwunsch '+ startseiteundnavstruktur.nameglobal+'! Du hast, mit '+inttostr(punkteglobal)+ ' Punkten, die Note '+floattostr(note)+' erreicht!');
   wissenstest.close;
   startseiteundnavstruktur.show;
  end
 else
  begin
   ShowMessage('Schade '+startseiteundnavstruktur.nameglobal+'! Mit '+inttostr(punkteglobal)+ ' Punkten hat es nur für die Note '+floattostr(note)+' gereicht!');
   wissenstest.close;
   startseiteundnavstruktur.show;
  end;
 //datei oeffnen zum schreiben der ergebnisse
 dateiname:='Ergebnisse\ergebnis_von_'+startseiteundnavstruktur.speichername+'_'+datetostr(now)+'.txt';
 assignfile(ergebnisse,dateiname);
 rewrite(ergebnisse);  //name, datum, zeit und klasse schreiben
 zeile:=startseiteundnavstruktur.nameglobal+', Schüler/Schülerin der Klasse '+startseiteundnavstruktur.klasseglobal+', absolvierte am: '+datum+' um '+startzeit+', den Wissenstest!';
 writeln(ergebnisse,zeile);
 zeile:=' ';
 writeln(ergebnisse,zeile);  //ergebnisse fuer jede fragen schreiben
 for i:=0 to 14 do begin
  zeile:='Frage '+inttostr(i+1)+': '+fragenundantworten[gestelltefragen[i],0]+'?';
  writeln(ergebnisse,zeile);
  zeile:=' i) '+fragenundantworten[gestelltefragen[i],1]+' ii) '+fragenundantworten[gestelltefragen[i],2]+' iii) '+fragenundantworten[gestelltefragen[i],3];
  writeln(ergebnisse,zeile);
  if antwortschueler[i]=1 then zeile:='Es wurde die richtige Antwort abgegeben! Diese war: Antwort '+inttostr(loesungen[i])
  else zeile:='Die abgegebene Antwort war falsch! Richtig gewesen wäre: Antwort '+inttostr(loesungen[i]);
  writeln(ergebnisse,zeile);
  zeile:='';
  writeln(ergebnisse,zeile);
 end;
 zeile:='';
 writeln(ergebnisse,zeile);  //note schreiben
 zeile:='Insgesamt wurden dabei '+inttostr(punkteglobal)+' Punkte erreicht, was der Note '+floattostr(note)+' entspricht.';
 writeln(ergebnisse,zeile);  //zeitdauer schreiben
 zeile:='Dafür wurden '+minuten+' Minuten und '+sekunden+' Sekunden benötigt.';
 writeln(ergebnisse,zeile);
 closefile(ergebnisse);
 startseiteundnavstruktur.T_statnote.caption:='Note: ' + floattostr(note);  // statistik auf navstruktur aktualisieren
 startseiteundnavstruktur.T_statpunkte.caption:='Punkte: ' + inttostr(punkteglobal);
 startseiteundnavstruktur.T_statzeit.caption:='Zeit: ' + minuten +' Minuten und ' + sekunden + ' Sekunden';
 fragenzaehler:=0;  //reset für etwaigen naechsten versuch
 punkteglobal:=0;
 fragestellen;
 t_richtigfalsch.hide;
 B_beenden.show;
 B_naechste.hide;
 B_auswerte.hide;
 B_pruefe.show;
 wissenstest.radiobutton1.checked:=false;
 wissenstest.radiobutton2.checked:=false;
 wissenstest.radiobutton3.checked:=false;
end;

procedure Twissenstest.B_beendenClick(Sender: TObject);
var mr: integer;
begin    //warnungsdialog bei klicken des beendenbuttons
  mr:=MessageDlg('Willst du das Programm wirklich beenden? Dabei gehen alle Fortschritte verloren!',mtWarning,[mbOk,mbCancel],0);
  if mr=mrOk then
   begin
    wissenstest.close;
    startseiteundnavstruktur.show;
     fragenzaehler:=0;  //initieren der oberflaeche und der fragenvariable für etwaigen neuen versuch
     fragestellen;
     T_richtigfalsch.hide;
     B_naechste.hide;
     wissenstest.radiobutton1.checked:=false;  //unchecken der radiobuttons, sonst bleibt vorherige auswahl erhalten
     wissenstest.radiobutton2.checked:=false;
     wissenstest.radiobutton3.checked:=false;
     punkteglobal:=0;
   end;
end;

procedure Twissenstest.B_naechsteClick(Sender: TObject);
begin
 fragestellen;  //initieren der oberflaeche
 T_richtigfalsch.hide;
 B_naechste.hide;
 B_pruefe.show;
 wissenstest.radiobutton1.checked:=false;  //unchecken der radiobuttons, sonst bleibt vorherige auswahl erhalten
 wissenstest.radiobutton2.checked:=false;
 wissenstest.radiobutton3.checked:=false;
end;

procedure Twissenstest.B_pruefeClick(Sender: TObject);
begin
 if (radiobutton1.checked=false) AND (radiobutton2.checked=false) AND (radiobutton3.checked=false) then
  begin  //abfangen von nicht auswahl einer antwort
   T_waehleantwort.show;
   T_waehleantwort.caption:='Wähle eine Antwort aus!';
   T_waehleantwort.font.color:=clred;
  end
 else
  begin
   kontrolle;
   T_waehleantwort.hide;
  end;
end;

end.

