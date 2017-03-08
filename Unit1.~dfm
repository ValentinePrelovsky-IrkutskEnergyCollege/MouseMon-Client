object Form1: TForm1
  Left = 273
  Top = 174
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnPaint = FormPaint
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
    Left = 400
    Top = 120
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 232
    Top = 256
    Width = 20
    Height = 13
    Caption = 'host'
  end
  object Label5: TLabel
    Left = 64
    Top = 40
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 64
    Top = 80
    Width = 32
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 64
    Top = 128
    Width = 32
    Height = 13
    Caption = 'Label7'
  end
  object Memo1: TMemo
    Left = 216
    Top = 40
    Width = 145
    Height = 161
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
    TabOrder = 3
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
    TabOrder = 4
    WordWrap = True
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 256
    Top = 256
    Width = 169
    Height = 21
    TabOrder = 5
    Text = '192.168.0.1'
  end
  object Button1: TButton
    Left = 448
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 6
    OnClick = Button1Click
  end
  object IdTCPClient1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 100
    OnDisconnected = IdTCPClient1Disconnected
    Host = '192.168.0.1'
    OnConnected = IdTCPClient1Connected
    Port = 6000
    Left = 8
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 56
    Top = 8
  end
  object Timer2: TTimer
    Interval = 500
    OnTimer = Timer2Timer
    Left = 640
    Top = 56
  end
  object Timer3: TTimer
    OnTimer = Timer3Timer
    Left = 40
    Top = 200
  end
end
