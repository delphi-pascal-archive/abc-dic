unit Utls;

interface

uses
 Windows, Classes, SysUtils, clipbrd;

procedure SaveClipboard(S: TStream);
procedure LoadClipboard(S: TStream);
procedure CtrlC;
function GetStringFromClipboard: WideString;
function DownCase(ds: char): char;
function cltxt(ds:string): string;
function clr(ds: string; fs: boolean): string;
function SmallFonts : boolean;
function IsCapsLockOn : boolean;
function IsCBText:boolean;
 implementation

function clr(ds: string; fs: boolean): string;
var
i : integer;
begin
Result := '';
for i := 1 to length(ds) do
if fs then
begin
 case ds[i] of
'a'..'z', 'A'..'Z',
'à'..'ÿ', 'À'..'ß', '¸', '¨':
Result := Result + DownCase(ds[i]);
 end;
end
else
Result := Result + DownCase(ds[i]);
end;

function cltxt(ds:string):string;
var
i : integer;
begin
Result := '';
for i := 1 to length(ds) do
 case ds[1] of
'a'..'z', 'A'..'Z',
'à'..'ÿ', 'À'..'ß', '¸', '¨': Result := Result + ds[i];
 end;
end;

function DownCase(ds: char): char;
begin
 case ds of
'A' : ds := 'a'; 'B' : ds := 'b'; 'C' : ds := 'c'; 'D' : ds := 'd';
'E' : ds := 'e'; 'F' : ds := 'f'; 'G' : ds := 'g'; 'H' : ds := 'h';
'I' : ds := 'i'; 'J' : ds := 'j'; 'K' : ds := 'k'; 'L' : ds := 'l';
'M' : ds := 'm'; 'N' : ds := 'n'; 'O' : ds := 'o'; 'P' : ds := 'p';
'Q' : ds := 'q'; 'R' : ds := 'r'; 'S' : ds := 's'; 'T' : ds := 't';
'U' : ds := 'u'; 'V' : ds := 'v'; 'W' : ds := 'w'; 'X' : ds := 'x';
'Y' : ds := 'y'; 'Z' : ds := 'z';

'À' : ds := 'à'; 'Á' : ds := 'á'; 'Â' : ds := 'â'; 'Ã' : ds := 'ã';
'Ä' : ds := 'ä'; 'Å' : ds := 'å'; '¨' : ds := '¸'; 'Æ' : ds := 'æ';
'Ç' : ds := 'ç'; 'È' : ds := 'è'; 'É' : ds := 'é'; 'Ê' : ds := 'ê';
'Ë' : ds := 'ë'; 'Ì' : ds := 'ì'; 'Í' : ds := 'í'; 'Î' : ds := 'î';
'Ï' : ds := 'ï'; 'Ð' : ds := 'ð'; 'Ñ' : ds := 'ñ'; 'Ò' : ds := 'ò';
'Ó' : ds := 'ó'; 'Ô' : ds := 'ô'; 'Õ' : ds := 'õ'; 'Ö' : ds := 'ö';
'×' : ds := '÷'; 'Ø' : ds := 'ø'; 'Ù' : ds := 'ù'; 'Ú' : ds := 'ú';
'Û' : ds := 'û'; 'Ü' : ds := 'ü'; 'Ý' : ds := 'ý'; 'Þ' : ds := 'þ';
'ß' : ds := 'ÿ';
 end;
   Result := ds;
  end;

 function GetStringFromClipboard: WideString;
var
Data: THandle;
begin
if IsClipboardFormatAvailable(CF_UNICODETEXT) then
begin
   Clipboard.Open;
   Data:= GetClipboardData(CF_UNICODETEXT);
   try
   if Data <> 0 then
   Result:= PWideChar(GlobalLock(Data))
   else
   Result:= '';
   finally
   if Data <> 0 then GlobalUnlock(Data);
   Clipboard.Close;
   end;
   end {begin} else
   Result:= Clipboard.AsText;
end;

procedure CopyStreamToClipboard(fmt: Cardinal; S: TStream);
 var
 hMem: THandle;
 pMem: Pointer;
 begin
   Assert(Assigned(S));
   S.Position := 0;
   hMem := GlobalAlloc(GHND or GMEM_DDESHARE, S.Size);
   if hMem <> 0 then
   begin
   pMem := GlobalLock(hMem);
     if pMem <> nil then
     begin
   try
   S.Read(pMem^, S.Size);
   S.Position := 0;
   finally
   GlobalUnlock(hMem);
   end;
    Clipboard.Open;
       try
       Clipboard.SetAsHandle(fmt, hMem);
       finally
        Clipboard.Close;
        end;
     end { If }
     else
     begin
     GlobalFree(hMem);
     OutOfMemoryError;
     end;
   end { If }
   else
   OutOfMemoryError;
   end; { CopyStreamToClipboard }

procedure CopyStreamFromClipboard(fmt: Cardinal; S: TStream);
 var
   hMem: THandle;
   pMem: Pointer;
 begin
   Assert(Assigned(S));
   hMem := Clipboard.GetAsHandle(fmt);
   if hMem <> 0 then
   begin
     pMem := GlobalLock(hMem);
     if pMem <> nil then
    begin
      try
        S.Write(pMem^, GlobalSize(hMem));
        S.Position := 0;
      finally
        GlobalUnlock(hMem);
      end;
    end { If }
    else
    exit;
    //      raise Exception.Create('CopyStreamFromClipboard: could not lock global handle ' +
      //  'obtained from clipboard!');
  end; { If }
end; { CopyStreamFromClipboard }

procedure SaveClipboardFormat(fmt: Word; writer: TWriter);
var
  fmtname: array[0..128] of Char;
  ms: TMemoryStream;
begin
  Assert(Assigned(writer));
  if 0 = GetClipboardFormatName(fmt, fmtname, SizeOf(fmtname)) then
    fmtname[0] := #0;
  ms := TMemoryStream.Create;
  try
    CopyStreamFromClipboard(fmt, ms);
    if ms.Size > 0 then
    begin
      writer.WriteInteger(fmt);
      writer.WriteString(fmtname);
      writer.WriteInteger(ms.Size);
      writer.Write(ms.Memory^, ms.Size);
    end; { If }
  finally
    ms.Free
  end; { Finally }
end; { SaveClipboardFormat }

procedure LoadClipboardFormat(reader: TReader);
var
  fmt: Integer;
  fmtname: string;
  Size: Integer;
  ms: TMemoryStream;
begin
  Assert(Assigned(reader));
  fmt     := reader.ReadInteger;
  fmtname := reader.ReadString;
  Size    := reader.ReadInteger;
  ms      := TMemoryStream.Create;
  try
    ms.Size := Size;
    reader.Read(ms.memory^, Size);
    if Length(fmtname) > 0 then
      fmt := RegisterCLipboardFormat(PChar(fmtname));
    if fmt <> 0 then
      CopyStreamToClipboard(fmt, ms);
  finally
    ms.Free;
  end; { Finally }
end; { LoadClipboardFormat }

procedure SaveClipboard(S: TStream);
var
  writer: TWriter;
  i:      Integer;
begin
  Assert(Assigned(S));
  writer := TWriter.Create(S, 4096);
  try
    Clipboard.Open;
    try
      writer.WriteListBegin;
      for i := 0 to Clipboard.formatcount - 1 do
        SaveClipboardFormat(Clipboard.Formats[i], writer);
      writer.WriteListEnd;
    finally
      Clipboard.Close;
    end; { Finally }
  finally
    writer.Free
  end; { Finally }
end; { SaveClipboard }

procedure LoadClipboard(S: TStream);
var
  reader: TReader;
begin
  Assert(Assigned(S));
  reader := TReader.Create(S, 4096);
  try
    Clipboard.Open;
    try
      clipboard.Clear;
      reader.ReadListBegin;
      while not reader.EndOfList do
        LoadClipboardFormat(reader);
      reader.ReadListEnd;
    finally
      Clipboard.Close;
    end; { Finally }
  finally
    reader.Free
  end; { Finally }
end; { LoadClipboard }

 function SmallFonts : BOOLEAN;
var
DC : HDC;
begin
DC := GetDC(0);
Result := (GetDeviceCaps(DC, LOGPIXELSX) = 96);
ReleaseDC(0, DC);
END;

function IsCapsLockOn : Boolean;
begin
Result := 0 <> (GetKeyState(VK_CAPITAL) and $01);
end;

procedure CtrlC;
 begin
keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), 0, 0);
keybd_event(67, MapVirtualKey(67, 0), 0, 0);
keybd_event(67, MapVirtualKey(67, 0), KEYEVENTF_KEYUP, 0);
keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), KEYEVENTF_KEYUP, 0)
 end;

function IsCBText:boolean;
begin
Result:=false;
 if (Clipboard.HasFormat(CF_UNICODETEXT))
 or (Clipboard.HasFormat(CF_OEMTEXT))
 or (Clipboard.HasFormat(CF_DSPTEXT))
 or (Clipboard.HasFormat(CF_TEXT)) then
 Result:= true;
end;

end.
