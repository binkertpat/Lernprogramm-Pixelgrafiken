unit u_themengebiete;

{$mode objfpc}{$H+}

interface

uses
  Classes, LCLIntf, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls;

type

  { Tthemengebiete }

  Tthemengebiete = class(TForm)
    B_beenden: TButton;
    B_irfranview: TImage;
    B_mario: TImage;
    B_naechste: TButton;
    B_cmyk: TImage;
    B_photoscape: TImage;
    B_zurueck: TButton;
    E_ausgaberot: TEdit;
    E_ausgabegruen: TEdit;
    E_ausgabeblau: TEdit;
    B_rgb: TImage;
    B_farbraum: TImage;
    B_gimp: TImage;
    B_paintnet: TImage;
    B_dateiformate: TImage;
    B_vektorpixel: TImage;
    L_kompression: TLabel;
    L_textkompression1: TLabel;
    L_vektor: TLabel;
    L_textkompression: TLabel;
    L_vektor1: TLabel;
    L_werkzeuge: TLabel;
    L_dateiformate: TLabel;
    L_farbtiefe: TLabel;
    L_farbtiefe1: TLabel;
    L_bildbearbeitung: TLabel;
    L_substfrabmtext: TLabel;
    L_gruen: TLabel;
    L_blau: TLabel;
    L_farbmischer: TLabel;
    L_auflundseitv: TLabel;
    L_defpixel: TLabel;
    L_beispielaufgabe: TLabel;
    L_ausgabe: TLabel;
    L_farbe: TLabel;
    L_komplementaer: TLabel;
    L_eingabe: TLabel;
    L_rot: TLabel;
    L_textwerkzeuge: TLabel;
    L_textwerkzeugeuntertitelbilder: TLabel;
    L_textfarbtiefe: TLabel;
    L_textfarbtiefe1: TLabel;
    L_textbearbeitung: TLabel;
    L_textpixelgrafiken: TLabel;
    L_textauflundseitv: TLabel;
    L_allgtext: TLabel;
    L_addfarbmtext: TLabel;
    L_addfarbm: TLabel;
    L_allgfarbmodell: TLabel;
    L_textveransch: TLabel;
    L_substfarbm: TLabel;
    P_rgbfarbe: TPanel;
    P_komplementaer: TPanel;
    SB_rot: TScrollBar;
    SB_gruen: TScrollBar;
    SB_blau: TScrollBar;
    thema12: TTabSheet;
    thema11: TTabSheet;
    thema10: TTabSheet;
    thema9: TTabSheet;
    thema8: TTabSheet;
    thema7: TTabSheet;
    thema6: TTabSheet;
    thema3: TTabSheet;
    thema4: TTabSheet;
    thema5: TTabSheet;
    themen: TPageControl;
    P_obengrau: TPanel;
    P_obenrot: TPanel;
    P_untengrau: TPanel;
    P_untenrot: TPanel;
    thema1: TTabSheet;
    thema2: TTabSheet;
    T_copyright: TLabel;
    T_thema: TLabel;
    procedure B_beendenClick(Sender: TObject);
    procedure B_naechsteClick(Sender: TObject);
    procedure B_zurueckClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB_blauChange(Sender: TObject);
    procedure SB_gruenChange(Sender: TObject);
    procedure SB_rotChange(Sender: TObject);
  private

  public

  end;

var
  themengebiete: Tthemengebiete;

implementation
uses u_startseite_und_navstruktur;  //bezugsunit einbinden

{$R *.lfm}

{ Tthemengebiete }

procedure Tthemengebiete.B_beendenClick(Sender: TObject);
begin
 themengebiete.close;
 startseiteundnavstruktur.show;
end;

procedure Tthemengebiete.B_naechsteClick(Sender: TObject);
begin
 themengebietanzeigen(startseiteundnavstruktur.themennummer+1); //einbindung der prozedur aus anderer unit
 startseiteundnavstruktur.themennummer:=startseiteundnavstruktur.themennummer+1;
end;

procedure Tthemengebiete.B_zurueckClick(Sender: TObject);
begin
 themengebietanzeigen(startseiteundnavstruktur.themennummer-1); //einbindung der prozedur aus anderer unit
 startseiteundnavstruktur.themennummer:=startseiteundnavstruktur.themennummer-1;
end;

procedure Tthemengebiete.FormCreate(Sender: TObject);
var r,g,b,rk,gk,bk:integer;
begin
 B_mario.picture.loadfromfile('images/mario_pixel.png');    //bilder fuer tabs der pagecontrol
 B_rgb.picture.loadfromfile('images/rgb.png');
 B_cmyk.picture.loadfromfile('images/cmyk.png');
 B_farbraum.picture.loadfromfile('images/farbraum.png');
 B_gimp.picture.loadfromfile('images/gimp.png');
 B_irfranview.picture.loadfromfile('images/irfranview.png');
 B_paintnet.picture.loadfromfile('images/paintnet.png');
 B_photoscape.picture.loadfromfile('images/photoscape.png');
 B_dateiformate.picture.loadfromfile('images/dateiformate.png');
 B_vektorpixel.picture.loadfromfile('images/vektorpixel.gif');
 //nachfolgend der quelltext für den farbmischer des rgb modells
 r:=SB_rot.Position; //farbwerte aus scrollbar
 g:=SB_gruen.Position;
 b:=SB_blau.Position;
 E_ausgaberot.text:=inttostr(r); //ausgabe zahlen aus scrollbar
 E_ausgabegruen.text:=inttostr(g);
 E_ausgabeblau.text:=inttostr(b);
 rk:=256-r; //berechnung komplementaerfarbe
 gk:=256-g;
 bk:=256-b;
 P_rgbfarbe.color:=RGB(SB_rot.Position,SB_gruen.Position,SB_blau.Position); //darstellung (komplementaer-)farbe
 P_komplementaer.color:=RGB(rk,gk,bk);
end;

procedure Tthemengebiete.SB_blauChange(Sender: TObject);
begin
  repaint; //aendern der farben bei bewegen des scrollbalkens
end;

procedure Tthemengebiete.SB_gruenChange(Sender: TObject);
begin
  repaint; //aendern der farben bei bewegen des scrollbalkens
end;

procedure Tthemengebiete.SB_rotChange(Sender: TObject);
begin
  repaint; //aendern der farben bei bewegen des scrollbalkens
end;




end.

