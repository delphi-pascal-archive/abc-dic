unit s_frmABC;

// При последней сборке в файле ABCdic.dpr
// сравнение if hwndPrev >= 0  нужно поменять на <= 0
  {Контроль над запуском второй копии программы}

interface

(*****************************************************************************

  Небольшое пояснение

  Как работает всплывающий перевод: при двойном клике левой кнопкой мышки
 системой выделяется нужное слово, затем оно копируется в буфер обмена, в
 БД словаря находится перевод и выводится на экран всплывающей подсказкой.
  Перед копированием содержимое буфера сохраняется в отдельный  мем-поток,
 а после получения нужного слова буфер вновь восстанавливается.

  Версия первая... Приношу свои извинения за возможные ошибки.

 *****************************************************************************

  Словарная база нарыта в Сети ( не знаю точно, как там насчет авторских
 прав, но на то она и Сеть :), вот список:

 http://radugaslov.ru
  translate.txt
  EnRusDic.txt
  enru.doc
  english-russian.txt
  Dictionary.txt

 http://www.avtlab.ru
  IT - незаметный преподаватель. Словари

 Англо-Русский Словарь под ред. Мюллера 66.000 слов
  Издание 24, исправленное
  Москва, "Русский язык", 1995 г.
  OCR Палек, 1998 г.

 *****************************************************************************

  Материалы для сборки взяты из :

 http://www.delphimaster.ru/

 Culiba1000/2000 Валентина Озерова
  http://www.webinspector.com/delphi

 DRKB v3.1
  http://www.drkb.ru
  http://www.delphist.com
  http://forum.vingrad.ru
  http://forum.sources.ru

 http://www.borland.com.ru/delphi/index.htm
  Стив Тейксейра и Ксавье Пачеко,
  Delphi5. Руководство разработчика. Том 1.
  Основные методы и технологии.

 Kyle Marsh,
  "Hooks in Win32".

 Dr. Joseph M. Newcomer,
  "Hooks and DLLs".
        ***

  Alegun ( alegun72@mail.ru )

 *****************************************************************************)

uses
  Windows, Messages, Forms, SysUtils, Classes, Controls, ADODB,
  DBGrids, StdCtrls, DB, DBCtrls, ExtCtrls, Buttons, IniFiles,
  Graphics, Menus, Trayicon, Registry, Dialogs, Clipbrd, Grids;

 type

  TfrmMain = class(TForm)

  tbl: TADOTable;
  DataSource1: TDataSource;
  Panel2: TPanel;
  pnlKlv: TPanel;
  DBGrid1: TDBGrid;
  Panel1: TPanel;
  Label3: TLabel;
  edFind: TEdit;
  sbNew: TSpeedButton;
  sbEdit: TSpeedButton;
  sbDel: TSpeedButton;
  sbHelp: TSpeedButton;
  sbExit: TSpeedButton;
  sbConf: TSpeedButton;
  sbsml: TSpeedButton;
  sb1:  TSpeedButton;
  sb2:  TSpeedButton;
  sb3:  TSpeedButton;
  sb4:  TSpeedButton;
  sb5:  TSpeedButton;
  sb6:  TSpeedButton;
  sb7:  TSpeedButton;
  sb8:  TSpeedButton;
  sb9:  TSpeedButton;
  sb10: TSpeedButton;
  sb11: TSpeedButton;
  sb12: TSpeedButton;
  sb13: TSpeedButton;
  sb14: TSpeedButton;
  sb15: TSpeedButton;
  sb16: TSpeedButton;
  sb17: TSpeedButton;
  sb18: TSpeedButton;
  sb19: TSpeedButton;
  sb20: TSpeedButton;
  sb21: TSpeedButton;
  sb22: TSpeedButton;
  sb23: TSpeedButton;
  sb24: TSpeedButton;
  sb25: TSpeedButton;
  sb26: TSpeedButton;
  sbEngRus: TSpeedButton;
  sbRusEng: TSpeedButton;
  TrayIcon1: TTrayIcon;
  TrPop: TPopupMenu;
  N1: TMenuItem;
  N2: TMenuItem;
  N3: TMenuItem;
  N6: TMenuItem;
  N10: TMenuItem;
  Timer1: TTimer;
  TmrShwHint: TTimer;
  TmrDelayLoadToCB: TTimer;
  TmrDelayCopyToCB: TTimer;

    function  tbn(ds: char): boolean;
    function  numsb(ds: char): string;
    procedure WMGetMinMaxInfo(
          var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure rs;
    procedure RegInit(ds: boolean);
    procedure RusOrEng(ds: boolean);
    procedure SetHk;
    procedure LoadConf;
    procedure UnSetHk;
    procedure ShwHint(ds: string);
    procedure TabName(ds: string);
    procedure edFindKeyUp(Sender: TObject;
          var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbEngRusClick(Sender: TObject);
    procedure sbRusEngClick(Sender: TObject);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
                              Shift: TShiftState; X, Y: Integer);
    procedure sbHelpClick(Sender: TObject);
    procedure sb1Click(Sender: TObject);
    procedure edFindKeyDown(Sender: TObject;
          var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure sbEditClick(Sender: TObject);
    procedure sbDelClick(Sender: TObject);
    procedure sbExitClick(Sender: TObject);
    procedure sbConfClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TrPopChange(Sender: TObject;
                          Source: TMenuItem; Rebuild: Boolean);
    procedure N1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject;
          var CanClose: Boolean);
    procedure N3Click(Sender: TObject);
    procedure TmrShwHintTimer(Sender: TObject);
    procedure TmrDelayLoadToCBTimer(Sender: TObject);
    procedure TmrDelayCopyToCBTimer(Sender: TObject);

  private
    { Private declarations }
  hwndNextViewer: THandle;
  procedure WMChangeCbChain(
        var Message: TWMChangeCBChain); message WM_CHANGECBCHAIN;
  procedure WMDrawClipboard(
        var Message: TMessage); message WM_DRAWCLIPBOARD;
  procedure DllMessage(
        var Msg: TMessage); message WM_USER+1328;
  procedure WMQueryEndSession(
        var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;

  public
    { Public declarations }
  end;

 type

   TStartHook = procedure(AppHandle: HWND);
   TStopHook =  procedure;

  var
  frmMain: TfrmMain;

  CnClose, hif, CBflg: boolean;
  bv: THandle;
  CBToMs: TMemoryStream;
  wh: THintWindow;

 implementation

 {$R *.dfm}

 uses
     ShellApi, s_frmChange, Utls;

 const eng: array[1..26] of char =
('A','B','C','D','E','F','G','H','I','J','K','L','M',
 'N','O','P','Q','R','S','T','U','V','W','X','Y','Z');

 const rus: array[1..26] of char =
('А','Б','В','Г','Д','Е','Ж','З','И','К','Л','М','О',
 'П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Э','Ю','Я');


procedure TfrmMain.WMChangeCbChain(
      var Message: TWMChangeCBChain);
begin
with Message do
begin
   // If the next window is closing, repair the chain.
  if Remove = hwndNextViewer then
  hwndNextViewer := Next
   // Otherwise, pass the message to the next link.
   else
     if hwndNextViewer <> 0 then
       SendMessage(hwndNextViewer, Msg, Remove, Next);
end;
end;

// clipboard contents changed.
//Происходит каждый раз при изменении содержания CB
procedure TfrmMain.WMDrawClipboard(
      var Message : TMessage);
var
s : string;
begin
// Pass the message to the next window in clipboard viewer chain.

if CBflg then
  if IsCBText then
 begin
 s:= cltxt(clr(GetStringFromClipboard, true));
 if s = '' then exit;
 tbl.Active:= false;
 TabName(s[1]);
 tbl.Active:= true;
 tbl.Locate('word', s, [loPartialKey]);
 if s = clr(tbl.FieldValues['word'], false) then
 shwHint(s + ' -' + #13 + tbl.FieldValues['trans'])
 else
 if frmms.cbMs.Checked then
 shwHint(s + ' - ' + 'перевод не найден');
 TmrDelayLoadToCB.Enabled:= true;
   end;

 with Message do
 SendMessage(hwndNextViewer, Msg, WParam, LParam);
end;

procedure TfrmMain.DllMessage(
      var Msg: TMessage);
begin
if not visible then
TmrDelayCopyToCB.Enabled:= true;
end;

// Показываем всплывающее окно (HintWindow) там, где находится курсор
procedure TfrmMain.ShwHint(ds : string);
var
w: HWND;
a, m: DWORD;
r: TRect;
p: TPoint;
begin
if hif then exit;
w:= GetForegroundWindow;
if w <> 0 then
 begin
a:= GetWindowThreadProcessId(w, nil);
m:= GetCurrentThreadid;
if a <> m then
begin
if AttachThreadInput(m, a, True) then
begin
w:= GetFocus;
if w <> 0 then
begin
GetCaretPos(p);
Windows.ClientToScreen(w, p);
if ds <> '' then
begin
wh:= THintWindow.create(self);
r:= wh.CalcHintRect(Screen.Width, ds, nil);
r.Left:= r.Left + p.X;
r.Right:= r.Right + p.X;
r.Top:= r.Top + p.Y;
r.Bottom:= r.Bottom + p.Y;
r.TopLeft.X:= r.TopLeft.X - 10;
r.TopLeft.y:= r.TopLeft.y + 20;
r.BottomRight.X:= r.BottomRight.X - 10;
r.BottomRight.y:= r.BottomRight.y + 20;
wh.Color:= clInfoBk;
wh.ActivateHint(r, ds);
tmrShwHint.Enabled:= true;
 hif:= true;
end;
  end;
AttachThreadInput(m, a, False);
 end;
  end;
   end;
 end;

  {Automatically loading our programm with starting Windows}
 procedure TfrmMain.RegInit( ds : boolean);
var
h: TRegistry;
 begin
    h:= TRegistry.Create;
     with h do
     begin
     RootKey:= HKEY_LOCAL_MACHINE;
    OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
    if ds then
    WriteString('ABCdic', Application.ExeName)
    else
    if ValueExists('ABCdic') then
    DeleteValue('ABCdic');
    CloseKey;
    Free;
     end;
 end;

procedure TfrmMain.LoadConf;
var
Text: TIniFile;
begin
Text:= TIniFile.Create(extractFileDir(ParamSTR(0)) + '\ABCdic.ini');
 try
frmms.cbRun.Checked:= Text.ReadBool('frmMain', 'cbRun', false);
if frmms.cbRun.Checked then
begin
frmms.rb1.Enabled:= true;
frmms.rb2.Enabled:= true;
frmms.cbMs.Enabled:=true;
end else
begin
frmms.rb1.Enabled:= false;
frmms.rb2.Enabled:= false;
frmms.cbMs.Enabled:=false;
end;
frmms.cbAuto.Checked:= Text.ReadBool('frmMain', 'cbAuto', false);
frmms.cbMs.Checked := Text.ReadBool('frmMain', 'cbMess', true);
if Text.ReadBool('frmMain', 'rbc', true) then
frmms.rb1.Checked:= true
else
frmms.rb2.Checked:= true;
 finally
 Text.Free;
 end;
end;

procedure TfrmMain.WMGetMinMaxInfo(
      var Msg: TWMGetMinMaxInfo);
begin
if SmallFonts then
begin
Msg.MinMaxInfo^.ptMinTrackSize:= Point(402, 175);
Msg.MinMaxInfo^.ptMaxTrackSize:= Point(402, 800);
end else
begin
Msg.MinMaxInfo^.ptMinTrackSize:= Point(492, 238);
Msg.MinMaxInfo^.ptMaxTrackSize:= Point(492, 800);
end;
inherited
end;

procedure TfrmMain.edFindKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
begin
case Key of
40, 37, 39, 38 : timer1.Enabled:= false;
else timer1.Enabled:= true;
end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
Text: TIniFile;
WS: string;
begin
 Text:= TIniFile.Create(extractFileDir(ParamSTR(0)) + '\ABCdic.ini');
try
Top :=    Text.ReadInteger('frmMain', 'Top', 471);
Left :=   Text.ReadInteger('frmMain', 'Left', 306);
Height := Text.ReadInteger('frmMain', 'Height', 256);
dbgrid1.Columns[0].Width := Text.ReadInteger('frmMain', 'Col', 89);
WS := Text.ReadString('frmMain', 'WindowState', 'wsNormal');
if WS = 'wsMaximized' then
WindowState :=wsMaximized
else
WindowState := wsNormal;
tbl.ConnectionString :=
 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
 extractFileDir(ParamSTR(0)) +
 '\dic.mdb;Mode=ReadWrite;Persist Security Info=False';
tbl.Active := true;
CnClose:=false;
rs;
sbHelp.Visible := FileExists('ABCdicHelp.chm');
n6.Enabled := sbHelp.Visible;
finally
 Text.Free;
 end;

 end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
LoadConf;
sb1.Down := true;
RusOrEng(true);
TabName('A');
if not FileExists('ABCdic.ini') then
 ShowMessage(
 'По умолчанию, режим всплывающего перевода отключен.'+#13+
 'Для его активации следует изменить настройки программы.');
end;

// Грузим надписи на баттоны ( true - Eng, false - Rus )
procedure TfrmMain.RusOrEng(ds: boolean);
var
i : integer;
begin
if ds then
begin
sbsml.ShowHint:= true;
sbEngRus.Down := true;
 for i := 1 to 26 do
with FindComponent('sb' + inttostr(i))
  as TSpeedButton do Caption:= Eng[i];
sbsml.Caption:= ':)';
 end
 else
begin
sbsml.ShowHint:= false;
sbRusEng.Down := true;
 for i := 1 to 26 do
 with FindComponent('sb' + inttostr(i))
   as TSpeedButton do
 begin
 Caption:= Rus[i];
 if i = 6 then  Caption:= 'ЕЁ';
 if i = 9 then Caption:= 'ИЙ';
 if i = 23 then Caption:= 'ШЩ';
  end;
  sbsml.Caption:= 'Н';
  end;
end;

procedure TfrmMain.TabName(ds: string);
begin
dbgrid1.Columns[0].title.caption:= 'Слово:';
dbgrid1.Columns[1].title.Caption:= 'Перевод:';
tbl.Active:= false;
case ds[1] of
'a'..'z', 'A'..'Z': tbl.TableName:= 'Eng_' + ds;
'а'..'я', 'А'..'Я', 'ё', 'Ё': tbl.TableName:='Rus_'+ds
 else
begin
tbl.TableName:= 'Smile';
dbgrid1.Columns[0].title.caption:= 'Смайлик:';
dbgrid1.Columns[1].title.caption:= 'Значение:';
end;
end;

if (ds = 'н') or
   (ds = 'Н') then tbl.TableName:= 'Rus_Н';

if (ds = 'е') or
   (ds = 'ё') or
   (ds = 'Е') or
   (ds = 'Ё') then tbl.TableName:= 'Rus_ЕЁ';

if (ds = 'и') or
   (ds = 'й') or
   (ds = 'И') or
   (ds = 'Й') then tbl.TableName:= 'Rus_ИЙ';

if (ds = 'ш') or
   (ds = 'щ') or
   (ds = 'Ш') or
   (ds = 'Щ') then tbl.TableName:= 'Rus_ШЩ';

tbl.Active:= true;
end;

// Проверка на "запретные" русские буквы
function TfrmMain.tbn(ds: char): boolean;
begin
case ds of
'ь', 'ы', 'ъ', 'Ь', 'Ы', 'Ъ': Result:= false;
else
Result:= true;
end;
end;

// Какую кнопку утопить?
function TfrmMain.numsb(ds: char): string;
var
i: integer;
begin
for i := 1 to 26 do
begin
if sbEngRus.Down then
  if (ds = eng[i])
  or (ds = DownCase(eng[i])) then
begin
Result:= 'sb' + inttostr(i);
exit;
end
else
Result:= 'sbsml';

if sbRusEng.Down then
begin
if (ds = rus[i])
or (ds = DownCase(rus[i])) then
Result:= 'sb' + inttostr(i);
if (ds = 'н')
or (ds = 'Н') then Result:= 'sbsml';

if (ds = 'е')
or (ds = 'ё')
or (ds = 'Е')
or (ds = 'Ё') then Result:= 'sb' + inttostr(6);

if (ds = 'и')
or (ds = 'й')
or (ds = 'И')
or (ds = 'Й') then Result:= 'sb' + inttostr(9);

if (ds = 'ш')
or (ds = 'щ')
or (ds = 'Ш')
or (ds = 'Щ') then Result:= 'sb' + inttostr(23);
 end;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
Text : TIniFile;
WS : string;
begin
Text:= TIniFile.Create(extractFileDir(ParamSTR(0)) + '\ABCdic.ini');
 try
if WindowState=wsNormal then
begin
Text.WriteInteger('frmMain', 'Top', Top);
Text.WriteInteger('frmMain', 'Left', Left);
Text.WriteInteger('frmMain', 'Height', Height);
Text.WriteInteger('frmMain', 'Col', dbgrid1.Columns[0].Width);
 WS:= 'wsNormal';
 end
 else
 WS:= 'wsMaximized';
Text.WriteString('frmMain', 'WindowState', WS);
tbl.UpdateBatch;
finally
Text.Free;
end;
 if trayicon1.Active then UnSetHk;
end;


procedure TfrmMain.sbEngRusClick(Sender: TObject);
begin
sb1.Down:= true;
RusOrEng(true);
TabName('A');
end;

procedure TfrmMain.sbRusEngClick(Sender: TObject);
begin
sb1.Down:= true;
RusOrEng(false);
TabName('А');
end;

procedure TfrmMain.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
rs;
end;

procedure TfrmMain.rs;
begin
 dbgrid1.Columns[1].Width :=
(dbgrid1.ClientWidth - 2) - dbgrid1.Columns[0].Width;
end;

procedure TfrmMain.sbHelpClick(Sender: TObject);
begin
ShellExecute(0, nil, PChar('ABCdicHelp.chm'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.sb1Click(Sender: TObject);
begin
with
sender
as
TSpeedButton
do
TabName(caption);
end;

procedure TfrmMain.edFindKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
begin
timer1.Enabled:= false;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
s : string;
begin
s:= edFind.Text;
timer1.Enabled:= false;
if length(s) = 0 then
exit;
if tbn(s[1]) then
begin
 case s[1] of
'a'..'z', 'A'..'Z' :
begin
RusOrEng(true);
sbEngRus.Down:= true;
end;
'а'..'я', 'А'..'Я', 'ё', 'Ё' :
begin
RusOrEng(false);
sbRusEng.Down:= true;
end;
 else
RusOrEng(true);
 end;

 with
 FindComponent(numsb(s[1]))
 as
 TSpeedButton
 do
 Down := true;

 tbl.Active:= false;
 TabName(s[1]);
 tbl.Active:= true;
 tbl.Locate('word', s, [loPartialKey]);
 end
 else exit;
end;

procedure TfrmMain.sbNewClick(Sender: TObject);
begin
frmms.PnlEdit.Visible:= true;
frmms.PnlConf.Visible:= false;
frmms.ShowHint:= true;
frmms.PnlEdit.Enabled:= true;
frmms.memo1.Font.Color:= clWindowText;
frmms.Edit1.Enabled:= true;
frmms.Edit1.Text:= '';
frmms.Memo1.Lines.Text:= '';
frmms.Caption:= 'Новая запись';
frmms.sbAdd.Hint:= 'Добавить';
frmms.ShowModal;
end;

procedure TfrmMain.sbEditClick(Sender: TObject);
begin
frmms.PnlEdit.Visible:= true;
frmms.PnlConf.Visible:= false;
frmms.ShowHint:= true;
frmms.PnlEdit.Enabled:= true;
frmms.Edit1.Text:= dbgrid1.Fields[0].Text;
frmms.Edit1.Enabled:= false;
frmms.memo1.Font.Color:= clWindowText;
frmms.Memo1.Text:= dbgrid1.Fields[1].Text;
frmms.Caption:= 'Редактирование записи';
frmms.sbAdd.Hint:= 'Применить';
frmms.Memo1.SelectAll;
frmms.ShowModal;
end;

procedure TfrmMain.sbDelClick(Sender: TObject);
begin
frmms.PnlEdit.Visible:= true;
frmms.PnlConf.Visible:= false;
frmms.ShowHint:= false;
frmms.caption := 'Внимание';
frmms.label1.Visible:= false;
frmms.label5.Visible:= false;
frmms.edit1.Visible := false;
frmms.memo1.Visible := false;
frmms.lbmes.Caption :=
'Удалить запись ' +
#13 +
'" '+ dbgrid1.Fields[0].Text + ' " -' +
#13 +
'" '+ frmms.obrez(dbgrid1.Fields[1].Text) + ' ... "'+
#13 +
'из базы данных словаря?';
frmms.lbmes.Visible:= true;
frmms.sbAdd.Hint:= 'Удалить';
frmms.ShowModal;
end;

procedure TfrmMain.sbExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmMain.sbConfClick(Sender: TObject);
begin
frmms.PnlEdit.Visible:= false;
frmms.PnlConf.Visible:= true;
frmms.ShowHint:= false;
frmms.caption:= ' ABCdic - Настройки';
LoadConf;
frmms.sbAdd.Hint:= 'Применить';
frmms.ShowModal;
end;

procedure TfrmMain.TrPopChange(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
begin
if visible then
n1.Caption:= 'Закрыть словарь'
else
n1.Caption:= 'Словарь...';
end;

procedure TfrmMain.N1Click(Sender: TObject);
begin
if n1.Caption = 'Словарь...' then
visible:= true
else
visible:= false;
end;

// Происходит при завершении работы Windows
 procedure TfrmMain.WMQueryEndSession(
       var Msg:TWMQueryEndSession);
 begin
 CnClose:= true;// Можно закрывать
 msg.Result:= 1;
 end;

procedure TfrmMain.FormCloseQuery(Sender: TObject;
      var CanClose: Boolean);
begin
if TrayIcon1.Active then
CanClose:= CnClose
else
CanClose:= true;
visible := false;
end;

procedure TfrmMain.N3Click(Sender: TObject);
begin
 CnClose:= true;
 close;
end;

// Ставим ловушку на двойной левый клик мышки
procedure TfrmMain.SetHk;
var
StartHook: TStartHook;
begin
 if bv > 0 then exit;
 bv:= LoadLibrary('HookMouse.dll');
 @StartHook:= GetProcAddress(bv, 'SetMyHook');
 if @StartHook = nil then Exit;
 StartHook(Handle);
  CBflg:= false;
  hwndNextViewer:= SetClipboardViewer(Handle);
  cbtoms:= TMemoryStream.Create;
 TrayIcon1.Active:= true;
  end;

// Снимаем ловушку
 procedure TfrmMain.UnSetHk;
var
StopHook: TStopHook;
 begin
 if bv <= 0 then exit;
  @StopHook:= GetProcAddress(bv, 'UnMyHook');
  FreeLibrary(bv);
 // for some reason in Win XP you need to call FreeLibrary twice
 // maybe because you get two functions from the DLL
 FreeLibrary(bv);
 ChangeClipboardChain(Handle, hwndNextViewer);
  cbtoms.Free;
 TrayIcon1.Active:= False;
 end;

//  Сейчас всё это работает на таймерах,
//  но в перспективе будет что-то другое
procedure TfrmMain.TmrShwHintTimer(Sender: TObject);
begin
wh.Destroy;
tmrShwHint.Enabled:= false;
hif:= false;
end;

procedure TfrmMain.TmrDelayLoadToCBTimer(Sender: TObject);
begin
TmrDelayLoadToCB.Enabled:= false;
cbtoms.Position:= 0;
LoadClipboard(cbtoms);
CBflg:= false;
end;

procedure TfrmMain.TmrDelayCopyToCBTimer(Sender: TObject);
begin
TmrDelayCopyToCB.Enabled:= false;
if not CBflg then
 begin
cbtoms.Clear;
SaveClipboard(cbtoms);
CBflg:= true;
 end;
if   frmms.rb1.Checked then CtrlC;
if  (frmms.rb2.Checked)
and (IsCapsLockOn) then CtrlC;

 if not IsCBText then
TmrDelayLoadToCB.Enabled:= true;

end;

end.
