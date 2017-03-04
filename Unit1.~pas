unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IdTCPClient1: TIdTCPClient;
    Memo1: TMemo;
    Button2: TButton;
    Timer1: TTimer;
    Button3: TButton;
    Memo2: TMemo;
    Button4: TButton;
    Label1: TLabel;
    Button5: TButton;
    Button6: TButton;
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.IdTCPClient1Connected(Sender: TObject);
begin
  Form1.Caption := 'has coonected';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  IdTCPClient1.Connect();

  IdTCPClient1.SendCmd('test');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.Memo1.Lines.Clear;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    Label1.Caption :=  'srv name: ' + IdTCPClient1.LocalName;
    if (idTCPClient1.Connected = false) then
    begin
      try
        IdTCPClient1.Connect();
        IdTCPClient1.SendCmd('test');
       except
        Form1.Caption := 'cannot connect';
      end;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  IdTCPClient1.SendCmd('mouse_eject');
end;

procedure TForm1.Button5Click(Sender: TObject);
var s:string;
begin
  IdTCPClient1.WriteLn('read_pc_name');
  s:= IdTCPClient1.ReadLn; // try to read
  Memo1.Lines.Add('read pc = client:' + s);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  IdTCPClient1.WriteLn('get_ip');
  Memo1.Lines.Add(IdTCPClient1.ReadLn);
end;

end.
