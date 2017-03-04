unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, ExtCtrls,ComponentUSB;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IdTCPClient1: TIdTCPClient;
    Memo1: TMemo;
    Button2: TButton;
    Timer1: TTimer;
    Memo2: TMemo;
    Label1: TLabel;
    Button5: TButton;
    Button6: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Timer2: TTimer;
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  usb:   TComponentUSB;
  lu:integer;
  var lc:integer;

implementation

{$R *.dfm}

procedure switchControls(state:boolean);
begin
  Form1.Button1.Enabled:=state;
  Form1.Button5.Enabled:=state;
  Form1.Button6.Enabled:=state;
end;
procedure disableControls();begin switchControls(false);end;
procedure enableControls();begin switchControls(true);end;
function getConnectionInfo():string;
begin
  Result := ' ' + Form1.IdTCPClient1.Socket.Binding.IP
  + ' - ' + IntToStr(Form1.IdTCPCLient1.Port);
end;
procedure log(strin:string);begin
  Form1.Memo1.Lines.Add(strin);
end;
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
var b:boolean;
begin
    // Label3.Caption:=IntToStr(usb_counter);
    
    Label2.Caption:=(IdTCPClient1.LocalName);
    Label1.Caption :=  'client local name: ' + IdTCPClient1.LocalName;
    b := idTCPClient1.Connected;
    //Form1.Caption:='conn';

    try
      IdTCPClient1.CheckForDisconnect(false);
      IdTCPClient1.Socket.Binding.UpdateBindingPeer;

      b := idTCPClient1.Connected;

      Form1.Caption:=BoolToStr(b);
    except
      Label2.Caption:='ex 2';
    end;

    if (b = false) then
    begin


      try
        IdTCPClient1.Connect();

        IdTCPClient1.SendCmd('test');
        enableControls();
       except
        Form1.Caption := 'cannot connect';
        disableControls();
      end;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  IdTCPClient1.SendCmd('mouse_eject');
   Memo1.Lines.Add('mouse_eject' + getConnectionInfo());
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

procedure TForm1.IdTCPClient1Disconnected(Sender: TObject);
begin
  ShowMessage('disconnected event');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  IdTCPClient1.SendCmd('mouse_inject');
  log('mouse_inject');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  usb:=TComponentUsb.Create(Form1);
  usb_removed_msg := false;
  usb_arrived_msg := false;
  lc := 0;
  usb_counter := 0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Label3.Caption:=IntToStr(usb_counter);
  if (lc <> usb_counter) then
  begin
    if (usb_counter > lc) then
      begin
        IdTCPClient1.SendCmd('mouse_inject');
        log('inject');
      end;
    if (usb_counter < lc) then
      begin
        IdTCPClient1.SendCmd('mouse_eject');
        log('ejct');
      end;
    lc := usb_counter; // equallly
  end;
end;

end.
