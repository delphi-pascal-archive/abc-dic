program ABCdic;

uses
  Forms,
  Windows,
  SysUtils,
  s_frmABC in 's_frmABC.pas' {frmMain},
  s_frmChange in 's_frmChange.pas' {frmms};

var
hwndPrev:HWND;
  {$R *.res}

begin

  Application.Initialize;
  hwndPrev := FindWindow('TfrmMain','Англо-русский словарь ABCdic');

  if hwndPrev >= 0  then //  При последней сборке поменять на <=

  begin
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tfrmms, frmms);
  frmMain.LoadConf;

   if frmms.cbRun.Checked then
   begin
  Application.ShowMainForm:=false;
  frmMain.SetHk;
    end;
  Application.Title := 'ABCdic';
  Application.Run;
  end else
  begin
  SetForegroundWindow(hwndPrev);
  Application.Terminate;
  end;
   end.

