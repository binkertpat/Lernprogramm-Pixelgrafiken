unit u_uebungen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tuebungsaufgaben }

  Tuebungsaufgaben = class(TForm)
    B_zurueck: TButton;
    B_naechste: TButton;
    B_beenden: TButton;
    B_pruefe: TButton;
    E_loesung: TEdit;
    P_obengrau: TPanel;
    P_obenrot: TPanel;
    P_untengrau: TPanel;
    P_untenrot: TPanel;
    T_copyright: TLabel;
    T_frage: TLabel;
    T_uebhinweis: TLabel;
    T_pruefeantwort: TLabel;
    T_hinweis: TLabel;
    T_frageindex: TLabel;
    T_richtigfalsch: TLabel;
    T_thema: TLabel;
    procedure B_zurueckClick(Sender: TObject);
    procedure B_naechsteClick(Sender: TObject);
    procedure B_beendenClick(Sender: TObject);
    procedure B_pruefeClick(Sender: TObject);
  private

  public

  end;

var
  uebungsaufgaben: Tuebungsaufgaben;

implementation
uses u_startseite_und_navstruktur;

{$R *.lfm}

{ Tuebungsaufgaben }

procedure Tuebungsaufgaben.B_beendenClick(Sender: TObject);
begin
 T_richtigfalsch.hide;  //Label für richtig/falsch für etwaigen Neustart entfernen
 uebungsaufgaben.close;
 startseiteundnavstruktur.show;
end;

procedure Tuebungsaufgaben.B_naechsteClick(Sender: TObject);
begin
 uebungsaufgabestellen(strtoint(startseiteundnavstruktur.uebungsnummer)+1); //Einbindung aus anderer Unit
 startseiteundnavstruktur.uebungsnummer:=inttostr(strtoint(startseiteundnavstruktur.uebungsnummer)+1);
 T_richtigfalsch.hide;  //Label für richtig/falsch aus vorheriger Aufgabe entfernen
end;

procedure Tuebungsaufgaben.B_zurueckClick(Sender: TObject);
begin
 uebungsaufgabestellen(strtoint(startseiteundnavstruktur.uebungsnummer)-1); //Einbindung aus anderer Unit
 startseiteundnavstruktur.uebungsnummer:=inttostr(strtoint(startseiteundnavstruktur.uebungsnummer)-1);
 T_richtigfalsch.hide;  //Label für richtig/falsch aus vorheriger Aufgabe entfernen
end;

procedure Tuebungsaufgaben.B_pruefeClick(Sender: TObject);
var antwort:string;
begin
 case strtoint(startseiteundnavstruktur.uebungsnummer) of   //Lösungen für die Aufgaben
   1: antwort:='16:9';
   2: antwort:='2,0736';
   3: antwort:='22,89';
   4: antwort:='5:4';
   5: antwort:='4618 x 2598';
   6: antwort:='20';
 end;
 if E_loesung.text=antwort then //Überprüfung des Ergebnisses
  begin
   T_richtigfalsch.show;
   T_richtigfalsch.caption:='Deine Antwort war richtig!';
   T_richtigfalsch.Font.color:=clgreen;
   (startseiteundnavstruktur.FindComponent('P_ueb'+startseiteundnavstruktur.uebungsnummer) as TPanel).Color:=clgreen;  //Panelfarbe auf Navigationsstruktur
  end
 else
  begin
    T_richtigfalsch.show;
    T_richtigfalsch.caption:='Das war leider falsch...!';
    T_richtigfalsch.Font.color:=clred;
    (startseiteundnavstruktur.FindComponent('P_ueb'+startseiteundnavstruktur.uebungsnummer) as TPanel).Color:=clred;  //Panelfarbe auf Navigationsstruktur
  end;
end;

end.

