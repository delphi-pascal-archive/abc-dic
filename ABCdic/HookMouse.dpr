library HookMouse;

uses
 Windows, Messages, SysUtils;
type
 PHookRec = ^THookRec;
 THookRec = record
 AppHnd   : integer;
  end;

var
Hooked: Boolean;
hK, hM, hA: HWND;
Hr: PHookRec;

function KeyHookFunc(Code, VirtualKey, KeyStroke: integer): LRESULT; stdcall;
begin
Result:= 0;
if Code = HC_NOREMOVE then Exit;
Result:= CallNextHookEx(hK, Code, VirtualKey, KeyStroke);
if Code < 0 then Exit;
if  (Code = HC_ACTION)
and (VirtualKey = WM_LBUTTONDBLCLK) then
 begin
hM:= OpenFileMapping(FILE_MAP_WRITE, False, 'MyHookMap');
Hr:= MapViewOfFile(hM, FILE_MAP_WRITE, 0, 0, 0);
if Hr <> nil then hA:= Hr.AppHnd;
SendMessage(hA, WM_USER+1328, VirtualKey, GetFocus);
 end;
end;

procedure SetMyHook(AppHandle: HWND); export;
begin
if Hooked then Exit;
hK:= SetWindowsHookEx(wh_mouse, KeyHookFunc, hInstance, 0);
if hK > 0 then
 begin
hM:= CreateFileMapping($FFFFFFFF,nil, PAGE_READWRITE,
     0, SizeOf(THookRec), 'MyHookMap');
Hooked:= true;
Hr:= MapViewOfFile(hM, FILE_MAP_WRITE, 0, 0, 0);
hA:= AppHandle;
Hr.AppHnd:= AppHandle;
 end;
end;

procedure UnMyHook; export;
begin
if Hr<>nil then
 begin
UnmapViewOfFile(Hr);
CloseHandle(hM);
Hr:= nil;
 end;
 if Hooked then UnhookWindowsHookEx(hK);
 Hooked:=false;
end;

procedure EntryProc(dwReason: DWORD);
begin
if dwReason = Dll_Process_Detach then
 begin
if Hr <> nil then
 begin
UnmapViewOfFile(Hr);
CloseHandle(hM);
 end;
UnhookWindowsHookEx(hK);
 end;
end;

exports
SetMyHook, UnMyHook;
begin
Hr:= nil;
Hooked:= False;
hK:= 0;
DLLProc:= @EntryProc;
EntryProc(Dll_Process_Attach);
end.
