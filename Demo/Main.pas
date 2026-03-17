unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, HotKeyEdit;

type
  TFormDemo = class(TForm)
    btnShowValues: TButton;
    lblInstructions: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnShowValuesClick(Sender: TObject);
  private
    { Private declarations }
    FMyHotKeyEdit: THotKeyEdit;
  public
    { Public declarations }
  end;

var
  FormDemo: TFormDemo;

implementation

{$R *.dfm}

procedure TFormDemo.FormCreate(Sender: TObject);
begin
  // Dynamically create the custom component
  FMyHotKeyEdit := THotKeyEdit.Create(Self);
  FMyHotKeyEdit.Parent := Self;

  // Position it nicely
  FMyHotKeyEdit.Left := 24;
  FMyHotKeyEdit.Top := 40;
  FMyHotKeyEdit.Width := 250;
  FMyHotKeyEdit.Font.Size := 10;

  // Standard TEdit properties
  FMyHotKeyEdit.TabOrder := 0;
end;

procedure TFormDemo.btnShowValuesClick(Sender: TObject);
var
  Mods: UInt;
  VK: Word;
begin
  // Access the private data via the GetKeys method we created
  FMyHotKeyEdit.GetKeys(Mods, VK);

  ShowMessage(Format('Internal Data Stored:'#13#10 +
                     'Modifier Flags: %d'#13#10 +
                     'Virtual Key Code: %d', [Mods, VK]));
end;

end.
