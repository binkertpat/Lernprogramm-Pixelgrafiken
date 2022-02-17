unit u_fragenkatalog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls;

type

  { Tfragenkat }

  Tfragenkat = class(TForm)
    Button1: TButton;
    B_zurueck: TButton;
    B_checklogin: TButton;
    B_aendere: TButton;
    B_anlegen: TButton;
    B_auslesen: TButton;
    B_close: TButton;
    B_schreibe: TButton;
    B_vorhdateiauslesen: TButton;
    E_passwort: TEdit;
    E_benutzername: TEdit;
    E_antwort1: TEdit;
    E_antwort2: TEdit;
    E_antwort3: TEdit;
    E_frage: TEdit;
    E_index: TEdit;
    E_loesung: TEdit;
    L_leererindex: TLabel;
    L_falsch: TLabel;
    L_antwort1: TLabel;
    L_antwort2: TLabel;
    L_antwort3: TLabel;
    L_ausgabegeschriebenedatei: TLabel;
    L_dateigroesse: TLabel;
    L_dateiname: TLabel;
    L_frage: TLabel;
    L_index: TLabel;
    L_loesung: TLabel;
    L_manipulation: TLabel;
    Memo1: TMemo;
    P_obengrau: TPanel;
    P_obenrot: TPanel;
    P_untengrau: TPanel;
    P_untenrot: TPanel;
    StringGrid1: TStringGrid;
    T_copyright: TLabel;
    T_thema: TLabel;
    T_benutzername: TLabel;
    T_passwort: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure B_aendereClick(Sender: TObject);
    procedure B_anlegenClick(Sender: TObject);
    procedure B_auslesenClick(Sender: TObject);
    procedure B_checkloginClick(Sender: TObject);
    procedure B_closeClick(Sender: TObject);
    procedure B_schreibeClick(Sender: TObject);
    procedure B_vorhdateiauslesenClick(Sender: TObject);
    procedure B_zurueckClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fragenkat: Tfragenkat;

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

{$R *.lfm}

{ Tfragenkat }

procedure Tfragenkat.FormCreate(Sender: TObject);
begin
  stringgrid1.hide;     //elemente ausblenden, damit nur login erscheint
  B_vorhdateiauslesen.hide;
  B_schreibe.hide;
  B_anlegen.hide;
end;

procedure Tfragenkat.B_zurueckClick(Sender: TObject);
begin
 startseiteundnavstruktur.show;
 fragenkat.close;
end;

procedure Tfragenkat.B_checkloginClick(Sender: TObject);
begin
if (E_benutzername.text='LEHRER')AND(E_passwort.text='LEMPEL') THEN  //check der anmeldeinfos
 begin
  stringgrid1.show;   //loginelemente ausblenden, fragenkatalog vollstaendig einblenden
  B_schreibe.show;
  B_anlegen.show;
  E_benutzername.hide;
  E_passwort.hide;
  B_checklogin.hide;
  B_zurueck.hide;
  T_benutzername.hide;
  T_passwort.hide;
  L_falsch.hide;
  fragenkat.height:=796;
  fragenkat.width:=1332;
  if FileExists('fragenkatalog/fragen_wissenstest.db') then  //ist die datei existent -> button auslesen, ist die datei nicht existent -> button anlegen
   begin
    b_anlegen.hide;
    B_vorhdateiauslesen.show;
   end;
  Memo1.clear; //memo leeren
 end
 else L_falsch.show;
end;

procedure Tfragenkat.B_closeClick(Sender: TObject);
var mr: integer;
begin    //warnungsdialog bei klicken des beendenbuttons
 mr:=MessageDlg('Willst du das Programm wirklich beenden? Dabei gehen alle nicht gespeicherten Fortschritte verloren!',mtWarning,[mbOk,mbCancel],0);
 if mr=mrOk then
  begin
   startseiteundnavstruktur.show;
   fragenkat.close;
  end;
end;

procedure Tfragenkat.B_aendereClick(Sender: TObject);
var i:integer;
begin
 if E_index.text='' then L_leererindex.show //fehlermeldung falls kein index zum auslesen eingetragen wurde
 else
  begin
   if (strtoint(E_index.text)>15) OR (strtoint(E_index.text)<1) then L_leererindex.show
   else
    begin
     i:=strtoint(E_index.text);  //i=index entspricht der zeile
     stringgrid1.cells[0,i]:=E_index.text;  //datenmanipulation in tabelle
     stringgrid1.cells[1,i]:=E_frage.text;
     stringgrid1.cells[2,i]:=E_antwort1.text;
     stringgrid1.cells[3,i]:=E_antwort2.text;
     stringgrid1.cells[4,i]:=E_antwort3.text;
     stringgrid1.cells[5,i]:=E_loesung.text;
     L_leererindex.hide;
    end;
  end;
end;

procedure Tfragenkat.Button1Click(Sender: TObject);
var i:integer;
begin
 if E_index.text='' then L_leererindex.show //fehlermeldung falls kein index zum auslesen eingetragen wurde
 else
  begin
   if (strtoint(E_index.text)>15) OR (strtoint(E_index.text)<1) then L_leererindex.show
   else
    begin
     i:=strtoint(E_index.text);  //i=index entspricht der zeile
     E_index.text:=stringgrid1.cells[0,i]; //tabelle in manipulationsfelder ueberfuehren
     E_frage.text:=stringgrid1.cells[1,i];
     E_antwort1.text:=stringgrid1.cells[2,i];
     E_antwort2.text:=stringgrid1.cells[3,i];
     E_antwort3.text:=stringgrid1.cells[4,i];
     E_loesung.text:=stringgrid1.cells[5,i];
     L_leererindex.hide;
    end;
  end;
end;

procedure Tfragenkat.B_anlegenClick(Sender: TObject);
var i:integer;
begin
 assignfile(datei,'fragenkatalog/fragen_wissenstest.db'); //datei anlegen
 rewrite(datei);
 closefile(datei);
 B_vorhdateiauslesen.show;
 assignfile(datei,'fragenkatalog/fragen_wissenstest.db'); //grundlegende daten eintragen, vor allem aber die indizies
 rewrite(datei);
 for i:= 1 to 15 do
  begin
   datensatz.index:=i;
   datensatz.frage:='-';
   datensatz.antwort1:='-';       1..2: start.panel6.color:=clgreen;
   datensatz.antwort2:='-';
   datensatz.antwort3:='-';
   datensatz.loesung:=1;
   write(datei,datensatz);
  end;
 closefile(datei);
 L_dateigroesse.show; //nach erfolgreichem erstellen, dateigroesse und dateiname als feedback ausgeben
 L_dateigroesse.caption:='Die Datei *fragen_wissenstest.db* wurde mit neuem Inhalt beschrieben. Dateigröße: ' + floattostr(filesize('fragenkatalog/fragen_wissenstest.db')) + ' Byte';
end;

procedure Tfragenkat.B_auslesenClick(Sender: TObject);
var i:integer; dsindexfrage, dsantworten:string;
begin
 Memo1.clear;  //memo leeren falls vorher bereits schon einmal ausgelesen wurde
 assignfile(datei,'fragenkatalog/fragen_wissenstest.db'); //datei auslesen und memo fuellen
 reset(datei);
 i:=0;
 seek(datei,0);
  while not eof(datei) do begin
   seek(datei,i);
   read(datei,datensatz);
   dsindexfrage:=inttostr(datensatz.index)+'. Frage: '+datensatz.frage+'?';
   dsantworten:='i) '+datensatz.antwort1+' ii) '+datensatz.antwort2+' iii) '+datensatz.antwort3+' -> Lösung: '+inttostr(datensatz.loesung);
   Memo1.lines.add(dsindexfrage);
   Memo1.lines.add(dsantworten);
   Memo1.lines.add('');
   i:=i+1;
  end;
 closefile(datei);
end;

procedure Tfragenkat.B_schreibeClick(Sender: TObject);
var i:integer; leeretabelle:boolean;
begin
 leeretabelle:=false;
  for i:=1 to 15 do
  begin
   if stringgrid1.cells[0,i]='' then leeretabelle:=true;   //uepruefe ob tabelle leer
  end;
 assignfile(datei,'fragenkatalog/fragen_wissenstest.db'); //datei mit inhalt beschreiben
 rewrite(datei);
 if leeretabelle=false then  //fuehre nur aus wenn tabelle nicht leer
 begin
   for i:= 1 to 15 do
    begin
     datensatz.index:=strtoint(stringgrid1.cells[0,i]);
     datensatz.frage:=stringgrid1.cells[1,i];
     datensatz.antwort1:=stringgrid1.cells[2,i];
     datensatz.antwort2:=stringgrid1.cells[3,i];
     datensatz.antwort3:=stringgrid1.cells[4,i];
     datensatz.loesung:=strtoint(stringgrid1.cells[5,i]);
     write(datei,datensatz);
    end;
  end;
 closefile(datei);
 //anzeige von dateiname und dateigroesse
 L_dateigroesse.caption:='Die Datei *fragen_wissenstest.db* wurde mit neuem Inhalt beschrieben. Dateigröße: ' + floattostr(filesize('fragenkatalog/fragen_wissenstest.db')) + ' Byte';
 L_dateigroesse.Font.color:=clgreen;
 L_dateigroesse.font.style:=[fsBold];
end;

procedure Tfragenkat.B_vorhdateiauslesenClick(Sender: TObject);
var i:integer;
begin
 assignfile(datei,'fragenkatalog/fragen_wissenstest.db'); //auslesen der vorhandenen datei und fuwllen der tabelle
 reset(datei);
 i:=0;
 seek(datei,0);
  while not eof(datei) do begin
   seek(datei,i);
   read(datei,datensatz);
   stringgrid1.cells[0,i+1]:=inttostr(datensatz.index);
   stringgrid1.cells[1,i+1]:=datensatz.frage;
   stringgrid1.cells[2,i+1]:=datensatz.antwort1;
   stringgrid1.cells[3,i+1]:=datensatz.antwort2;
   stringgrid1.cells[4,i+1]:=datensatz.antwort3;
   stringgrid1.cells[5,i+1]:=inttostr(datensatz.loesung);
   i:=i+1;
  end;
 closefile(datei);
 L_dateigroesse.show;  //bei bestehender datei dateigroesse ausgeben
 L_dateigroesse.caption:='Die Datei *fragen_wissenstest.db* existiert bereits. Dateigröße: ' + floattostr(filesize('fragenkatalog/fragen_wissenstest.db')) + ' Byte';
end;

end.

