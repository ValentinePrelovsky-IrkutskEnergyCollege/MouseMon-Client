unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, ExtCtrls,DateUtils ,ComponentUSB;

type
  TForm1 = class(TForm)
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
    Edit1: TEdit;
    Button3: TButton;
    Edit2: TEdit;
    Label4: TLabel;
    Button1: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Timer3: TTimer;
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  usb:   TComponentUSB;
  lu:integer;
  logFile:TextFile;
  cnfFile:TextFile;
  srvHost:string;
  cnfStr:string;
  var lc:integer;


implementation

{$R *.dfm}

procedure switchControls(state:boolean);
begin
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
procedure log(strin:string);
begin
  WriteLn(logFile,strin);
  WriteLn(logFile);
  Flush(logFile);
  Form1.Memo1.Lines.Add(strin);
end;

procedure TForm1.IdTCPClient1Connected(Sender: TObject);
begin
  Form1.Caption := 'Подключено';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.Memo1.Lines.Clear;
end;
procedure up();
begin
  if (Form1.Timer1.Enabled = true) then Form1.Label5.Caption:= 'Timer1 enabled'
  else
  Form1.Label5.Caption:= 'Timer1 disabled'
  
end;
procedure TForm1.Timer1Timer(Sender: TObject);
var b:boolean;
begin
    //up();
    // Label3.Caption:=IntToStr(usb_counter);
    Label2.Caption:=(IdTCPClient1.LocalName);
    Label1.Caption :=  'client local name: ' + IdTCPClient1.LocalName;
    b := idTCPClient1.Connected;

    try
      IdTCPClient1.CheckForDisconnect(false);
      IdTCPClient1.Socket.Binding.UpdateBindingPeer;
      IdTCPClient1.SendCmd('alive');
      b := idTCPClient1.Connected;

      Form1.Caption:=BoolToStr(b);
    except
      Label2.Caption:='ex 2';
    end;

    if (b = false) then
    begin
      try
        Form1.Label6.Caption:='Не подлючен';

        IdTCPClient1.Connect();

        IdTCPClient1.SendCmd('test');
        enableControls();
       except
        //Form1.Caption := 'cannot connect';
        Form1.Label6.Caption:= 'cannot connect';
        disableControls();
        IdTCPClient1.Disconnect();
      end;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var e:string;
begin
  e:= Edit1.Text;
  if (e <> '') then
  begin
    // you cannot eject or inject your mouse
    if (e = 'read_pc_name')then
    begin
      IdTCPClient1.WriteLn('read_pc_name');
      log('read pc = client:' + IdTCPClient1.ReadLn);
    end; // read pc name

    if (e = 'get_ip') then
    begin
      IdTCPClient1.WriteLn('get_ip');
      log(IdTCPClient1.ReadLn);
    end; // get_ip

  end;// if (e <> '') then
end; // procedure

procedure TForm1.Button5Click(Sender: TObject);
var s:string;
begin
  IdTCPClient1.WriteLn('read_pc_name');
  s:= IdTCPClient1.ReadLn; // try to read
  log('read pc = client:' + s);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  IdTCPClient1.WriteLn('get_ip');
  Memo1.Lines.Add(IdTCPClient1.ReadLn);
end;

procedure TForm1.IdTCPClient1Disconnected(Sender: TObject);
begin
  Timer1.Enabled:=false;
  // ShowMessage('disconnected event');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  IdTCPClient1.SendCmd('mouse_inject');
  log('mouse_inject');
end;
function getFileName():string;begin
Result:=('log ' + DateToStr(Now())+'-'+IntToStr(HourOf(Now))+'_'+IntToStr(MinuteOf(Now)) +'.txt');
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  usb:=TComponentUsb.Create(Form1);
  usb_removed_msg := false;
  usb_arrived_msg := false;
  lc := 0;
  usb_counter := 0;

  AssignFile(logFile, getFileName());
  Rewrite(logFile);
  try
    AssignFile(cnfFile,'config.txt');
    Reset(cnfFile);
    ReadLn(cnfFile,cnfStr);
    cnfStr := Trim(cnfStr);
    srvHost:=cnfStr;
    IdTCPCLient1.Host:=cnfStr;
    Form1.Caption:=('configured as: ' + cnfStr);
  except
    srvHost := '127.0.0.1';
    IdTCPClient1.Host:=srvHost;
  end;
  Form1.Label7.caption:='tr';
  Form1.Timer1.Enabled:=true;
  Form1.Timer2.Enabled:=true;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  //Form1.Visible:=false;
  //up();
  Label3.Caption:=IntToStr(usb_counter);
  IdTCPClient1.CheckForDisconnect(false);
  if (IdTCPClient1.Connected = true) then IdTCPClient1.SendCmd('alive');
  
  if (lc <> usb_counter) then
  begin
    if (usb_counter > lc) then
      begin
        if (IdTCPClient1.Connected = true) then IdTCPClient1.SendCmd('mouse_inject');
        log('inject');
      end;
    if (usb_counter < lc) then
      begin
        if (IdTCPClient1.Connected = true) then IdTCPClient1.SendCmd('mouse_eject');
        log('ejct');
      end;
    lc := usb_counter; // equallly
  end;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Form1.Visible:=true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  IdTCPCLient1.Host:=Edit2.Text;
  timer1.Enabled:=true;
  timer2.Enabled:=true;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CloseFile(logFile);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
try
    IdTCPClient1.Host:=srvHost;
    IdTCPClient1.SendCmd('alive');
    Form1.Label6.Caption:='alive';
  except
    Form1.Label6.Caption:='alive NOT';
    try
     if (IdTCPClient1.Connected = false)then IdTCPClient1.Connect();
    except
    end;
  end;
end;

end.
