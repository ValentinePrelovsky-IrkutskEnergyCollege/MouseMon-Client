object Form1: TForm1
  Left = 192
  Top = 124
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 400
    Top = 88
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 80
    Top = 32
    Width = 81
    Height = 25
    Caption = 'connect & test'
    Enabled = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 216
    Top = 40
    Width = 145
    Height = 161
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 224
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Clear lines'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 80
    Top = 72
    Width = 89
    Height = 41
    Caption = 'eject'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Memo2: TMemo
    Left = 544
    Top = 56
    Width = 169
    Height = 193
    Lines.Strings = (
      'Avail:'
      ''
      'test'
      'mouse_eject'
      'mouse_inject')
    TabOrder = 4
  end
  object Button4: TButton
    Left = 80
    Top = 136
    Width = 89
    Height = 41
    Caption = '!inject'
    TabOrder = 5
  end
  object Button5: TButton
    Left = 80
    Top = 200
    Width = 97
    Height = 41
    Caption = 'readPcName'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 232
    Top = 232
    Width = 145
    Height = 33
    Caption = 'get ip'
    TabOrder = 7
    OnClick = Button6Click
  end
  object IdTCPClient1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 100
    Host = '127.0.0.1'
    OnConnected = IdTCPClient1Connected
    Port = 6000
    Left = 16
    Top = 24
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 40
    Top = 128
  end
end