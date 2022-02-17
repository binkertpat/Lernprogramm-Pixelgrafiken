program p_belegarbeit_patrick.binkert;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, u_startseite_und_navstruktur, u_fragenkatalog, u_wissenstest, u_uebungen
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tstartseiteundnavstruktur, startseiteundnavstruktur);
  Application.CreateForm(Tfragenkat, fragenkat);
  Application.CreateForm(Twissenstest, wissenstest);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

