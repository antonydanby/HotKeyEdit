object FormDemo: TFormDemo
  Left = 0
  Top = 0
  Caption = 'Custom HotKey Component Demo'
  ClientHeight = 150
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lblInstructions: TLabel
    Left = 24
    Top = 16
    Width = 185
    Height = 15
    Caption = 'Focus the box and press a shortcut:'
  end
  object btnShowValues: TButton
    Left = 24
    Top = 80
    Width = 250
    Height = 35
    Caption = 'Show Stored Key Values'
    TabOrder = 0
    OnClick = btnShowValuesClick
  end
end
