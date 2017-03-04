object Form1: TForm1
  Left = 370
  Top = 217
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 400
    Top = 88
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 400
    Top = 40
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 40
    Top = 288
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Memo1: TMemo
    Left = 216
    Top = 40
    Width = 145
    Height = 161
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button2: TButton
    Left = 224
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Clear lines'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 616
    Top = 96
    Width = 169
    Height = 193
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      #1044#1086#1089#1090#1091#1087#1085#1099' '
      #1089#1083#1077#1076#1091#1102#1097#1080#1077' '
      #1082#1086#1084#1072#1085#1076#1099':'
      ''
      'test'
      'get_ip'
      'read_pc_name')
    ParentFont = False
    TabOrder = 2
  end
  object Button5: TButton
    Left = 80
    Top = 200
    Width = 97
    Height = 41
    Caption = 'readPcName'
    TabOrder = 3
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 80
    Top = 160
    Width = 97
    Height = 33
    Caption = 'get ip'
    TabOrder = 4
    OnClick = Button6Click
  end
  object Edit1: TEdit
    Left = 584
    Top = 16
    Width = 177
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object Button3: TButton
    Left = 776
    Top = 16
    Width = 121
    Height = 57
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1082#1086#1084#1072#1085#1076#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = Button3Click
  end
  object IdTCPClient1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 100
    OnDisconnected = IdTCPClient1Disconnected
    Host = '127.0.0.1'
    OnConnected = IdTCPClient1Connected
    Port = 6000
    Left = 16
    Top = 24
  end
  object Timer1: TTimer
    Interval = 300
    OnTimer = Timer1Timer
    Left = 40
    Top = 128
  end
  object Timer2: TTimer
    Interval = 500
    OnTimer = Timer2Timer
    Left = 200
    Top = 312
  end
end
