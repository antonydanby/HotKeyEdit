unit HotKeyEdit;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Windows, Winapi.Messages;

type
  THotKeyEdit = class(TEdit)
  private
    FModifiers: UInt;
    FVirtualKey: Word;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function GetKeyName(VK: Word): string;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetKeys(out Modifiers: UInt; out VK: Word);
  published
    property ReadOnly default True;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('l53n', [THotKeyEdit]);
end;

constructor THotKeyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ReadOnly := True;
  Text := 'None';
end;

function THotKeyEdit.GetKeyName(VK: Word): string;
var
  ScanCode: LongInt;
  KeyName: array[0..255] of Char;
begin
  // MapVirtualKey converts the VK code to a scan code
  ScanCode := MapVirtualKey(VK, 0) shl 16;
  
  // Check if it's an "extended" key (Arrows, Ins, Del, Home, End, etc.)
  if VK in [VK_INSERT, VK_DELETE, VK_HOME, VK_END, VK_NEXT, VK_PRIOR, 
            VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_DIVIDE] then
    ScanCode := ScanCode or $1000000;

  if GetKeyNameText(ScanCode, KeyName, Length(KeyName)) > 0 then
    Result := KeyName
  else
    Result := 'Unknown';
end;

procedure THotKeyEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  S: string;
  LMods: UInt;
begin
  // Ignore standalone modifier presses
  if Key in [VK_SHIFT, VK_CONTROL, VK_MENU, VK_LWIN, VK_RWIN] then
    Exit;

  LMods := 0;
  S := '';

  // Handle Modifiers
  if ssCtrl in Shift then
  begin
    LMods := LMods or MOD_CONTROL;
    S := S + 'Ctrl + ';
  end;
  if ssShift in Shift then
  begin
    LMods := LMods or MOD_SHIFT;
    S := S + 'Shift + ';
  end;
  if ssAlt in Shift then
  begin
    LMods := LMods or MOD_ALT;
    S := S + 'Alt + ';
  end;

  // Store internal values
  FModifiers := LMods;
  FVirtualKey := Key;

  // Use the WinAPI to get the friendly name (e.g., "Page Up", "Num 5")
  // See: https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getkeynametextw
  // See also Winapi.Windows Delphi system code
  Text := S + GetKeyName(Key);

  Key := 0;
  inherited;
end;

procedure THotKeyEdit.KeyPress(var Key: Char);
begin
  Key := #0;
  inherited;
end;

procedure THotKeyEdit.GetKeys(out Modifiers: UInt; out VK: Word);
begin
  Modifiers := FModifiers;
  VK := FVirtualKey;
end;

end.