unit s_frmChange;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Buttons,
  ExtCtrls, DB, Graphics, StdCtrls,IniFiles, DBCtrls;
type
  Tfrmms = class(TForm)
    PnlEdit: TPanel;
    Label5: TLabel;
    Label1: TLabel;
    Lbmes: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    PnlConf: TPanel;
    cbRun: TCheckBox;
    cbAuto: TCheckBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    cbMs: TCheckBox;
    Panel1: TPanel;
    sbAdd: TSpeedButton;
    sbCans: TSpeedButton;

    function  UpCs(ds: string): string;
    function  obrez(ds: string): string;
    procedure sbCansClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
    procedure cbRunClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var frmms: Tfrmms;
    implementation

{$R *.dfm}

uses s_frmABC;

procedure Tfrmms.sbCansClick(Sender: TObject);
begin
 close;
 end;

 function clr(ds:string):string;
var
i : integer;
begin

for i := 1 to length(ds) do

if (ds[i] = #10)
or (ds[i] = #13) then ds[i] := ' ';

if ds[length(ds)] = ' ' then
 delete(ds, length(ds), length(ds));

 if ds[length(ds)] = ' ' then
 delete(ds, length(ds), length(ds));
 Result := ds;

 end;

procedure Tfrmms.FormShow(Sender: TObject);
begin
Top := frmMain.Top + (frmMain.Height - Height) div 2;
Left := frmMain.Left + (frmMain.Width - Width) div 2;

if ShowHint then
begin
label5.Caption := frmMain.dbgrid1.Columns[0].title.caption;
label1.Caption := frmMain.dbgrid1.Columns[1].title.caption;
label1.Visible := true;
label5.Visible := true;
edit1.Visible := true;
memo1.Visible := true;
lbmes.Visible := false;

if edit1.Enabled then
edit1.SetFocus
else
begin
memo1.SetFocus;
end;
 end;
end;

procedure Tfrmms.sbAddClick(Sender: TObject);
var
s, k : string;
Text : TIniFile;
begin
if caption = ' ABCdic - Настройки' then
begin
Text := TIniFile.Create(extractFileDir(ParamSTR(0)) + '\ABCdic.ini');
try
Text.WriteBool('frmMain', 'cbRun', cbRun.Checked);
Text.WriteBool('frmMain', 'cbAuto', cbAuto.Checked);
Text.WriteBool('frmMain', 'cbMess', cbMs.Checked);
Text.WriteBool('frmMain', 'rbc',rb1.Checked);
finally
 Text.Free;
 end;

 if cbAuto.Checked then
 frmMain.RegInit(true)
 else
 frmMain.RegInit(false);

 if cbRun.Checked then
begin
frmMain.SetHk;
 end
 else
 begin
frmMain.TrayIcon1.Active := false;
frmMain.UnSetHk;
frmMain.Visible := true;
end;
close;
end;

if caption = 'Внимание' then
begin
frmMain.tbl.Delete;
frmMain.tbl.UpdateBatch;
close;
end;

if sbAdd.Hint = 'Удалить' then
begin
caption := 'Новая запись';
label1.Visible := true;
label5.Visible := true;
edit1.Visible := true;
memo1.Visible := true;
lbmes.Visible := false;
sbAdd.Hint := 'Добавить';
edit1.SetFocus;
exit;
 end;

 if sbAdd.Hint = 'Заменить' then
begin
label1.Visible := true;
label5.Visible := true;
edit1.Visible := true;
memo1.Visible := true;
lbmes.Visible := false;
sbAdd.Hint := 'Добавить';
frmMain.dbgrid1.DataSource.DataSet.Edit;
frmMain.dbgrid1.Fields[1].Text := clr(memo1.Text);
frmMain.tbl.UpdateBatch;
close;
end;
s := edit1.Text;
k := memo1.Lines.Text;

if (length(s) = 0)
or (length(k) = 0) then
 exit;

case s[1] of
'a'..'z', 'A'..'Z' : frmmain.RusOrEng(true);
'а'..'я', 'А'..'Я', 'ё', 'Ё' : frmmain.RusOrEng(false);
else
frmmain.RusOrEng(true);
end;

if frmmain.tbn(s[1]) then
begin
if frmmain.sbEngRus.Down then
begin
 with frmmain.FindComponent(frmmain.numsb(s[1]))
 as TSpeedButton do Down := true;
 frmmain.tbl.Active := false;
 frmmain.TabName(s[1]);
 frmmain.tbl.Active := true;
 frmmain.tbl.Locate('word', s, [loPartialKey]);
 end;

 if frmmain.sbRusEng.Down then
 begin
 with frmmain.FindComponent(frmmain.numsb(s[1]))
 as TSpeedButton do Down := true;
 frmmain.tbl.Active := false;
 frmmain.TabName(s[1]);
 frmmain.tbl.Active := true;
frmmain.tbl.Locate('word',s, [loPartialKey]);
end;
end else
begin
caption:='Предупреждение';
label1.Visible := false;
label5.Visible := false;
edit1.Visible := false;
memo1.Visible := false;
lbmes.Caption :=
'В русском языке слов начинающихся' +
#13 +
'на "Ь", "Ы" или "Ъ" не существует.';

lbmes.Visible := true;
sbAdd.Hint := 'OK';
exit;
end;

k := UpCs(s);

if k = UpCs(frmMain.dbgrid1.Fields[0].Text) then
if Caption = 'Новая запись' then
begin
caption := 'Замена перевода';
label1.Visible := false;
label5.Visible := false;
edit1.Visible := false;
memo1.Visible := false;

if frmmain.tbl.TableName = 'Smile'then
lbmes.Caption := 'В базе данных словаря найден смайлик' +
#13+
s  +
#13 +
#13 +
'Заменить его значение новым?'
 else
lbmes.Caption := 'В базе данных словаря найдено слово'+
#13  +
'"' + s + '" - "' +
obrez(frmMain.dbgrid1.Fields[1].Text) + ' ..."' +
#13 +
#13 +
'Заменить его перевод на' +
#13 +
'"' + obrez(memo1.Lines.Text) + ' ..."?';
lbmes.Visible := true;
 sbAdd.Hint := 'Заменить';
 exit;
  end;

if caption = 'Новая запись'then
frmmain.dbgrid1.DataSource.DataSet.Insert
else
frmmain.dbgrid1.DataSource.Edit;
frmMain.dbgrid1.Fields[0].Text := s;
frmMain.dbgrid1.Fields[1].Text := clr(memo1.Text);
frmMain.tbl.UpdateBatch;
close;
end;

function Tfrmms.UpCs(ds: string): string;
var
i : integer;
begin
result := ds;
 for i := 1 to length(ds) do
 Result[i] := UpCase(ds[i]);
end;

procedure Tfrmms.FormKeyDown(Sender:TObject;var Key:Word;Shift:TShiftState);
begin
if key = 27 then{esc} close;
end;

function Tfrmms.obrez(ds: string): string;
var
 i : integer;
 d : string;
begin
ds := ds + ' ';
d := '';
i := 1;

 while i < length(ds) do
 begin
 d := d + ds[i];

if ds[i] = ' ' then
 begin
result := d;
exit;
 end;
inc(i);
end;
result := d;
end;

procedure Tfrmms.cbRunClick(Sender: TObject);
begin
if cbRun.Checked then
begin
rb1.Enabled := true;
rb2.Enabled := true;
cbMs.Enabled:= true;
end
else
begin
rb1.Enabled := false;
rb2.Enabled := false;
cbMs.Enabled:= false;
end;
end;

procedure Tfrmms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
frmMain.LoadConf;
end;

end.
