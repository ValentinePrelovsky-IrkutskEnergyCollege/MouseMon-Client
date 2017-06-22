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
    procedure IdTCPClient1Disconnected(Sender: TObject);
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
  var locName:string;
  var lc:integer;


implementation

{$R *.dfm}

function getConnectionInfo():string;
begin
  Result := ' '+Form1.IdTCPClient1.LocalName;
end;
procedure log(strin:string);
begin
try
  WriteLn(logFile,strin);
  Flush(logFile);
  Form1.Memo1.Lines.Add(strin);
finally end;
end;

procedure TForm1.IdTCPClient1Connected(Sender: TObject);
begin
  Form1.Caption := 'Подключено';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.Memo1.Lines.Clear;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var b:boolean;
begin
    Label3.Caption:=IntToStr(usb_counter);
    locName:=IdTCPClient1.LocalName;
    Label2.Caption:=locName;
    Label1.Caption :=  'client local name: ' + locName;
    b := idTCPClient1.Connected;

    try      IdTCPClient1.SendCmd('alive'); except end;
    b := idTCPClient1.Connected;
    Form1.Caption:=BoolToStr(b);

    if (b = false) then
    begin
      try
        Form1.Label6.Caption:='Не подключен';
        try
          IdTCPClient1.Connect();
        except end;
         begin
          IdTCPClient1.WriteLn('unused');
          IdTCPClient1.SendCmd('get_name');
          IdTCPClient1.WriteLn(locName);
          IdTCPClient1.SendCmd('test');
        end;
        //IdTCPClient1.SendCmd('test');
       except
        Form1.Label6.Caption:= 'не могу соединиться';
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
      log('Чтение имени клиента: ' + IdTCPClient1.ReadLn());
    end; // read pc name

    if (e = 'get_ip') then
    begin
      IdTCPClient1.WriteLn('get_ip');
      log('Адрес = ' + IdTCPClient1.ReadLn());
    end; // get_ip

  end;// if (e <> '') then
end; // procedure

procedure TForm1.IdTCPClient1Disconnected(Sender: TObject);
begin
  Timer1.Enabled:=false;
end;

function getFileName():string;begin
//Result:=('log ' + DateToStr(Now())+'-'+IntToStr(HourOf(Now))+'_'+IntToStr(MinuteOf(Now)) +'.txt');
Result:='log.txt';
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  usb:=TComponentUsb.Create(Form1);
  usb_removed_msg := false;
  usb_arrived_msg := false;
  lc := 0;
  usb_counter := 0;

  try
    AssignFile(logFile, getFileName());
    Rewrite(logFile);
  except end;
  try
    AssignFile(cnfFile,'config.txt');
    log('config file is exist');
    Reset(cnfFile);
    ReadLn(cnfFile,cnfStr);
    cnfStr := Trim(cnfStr);
    srvHost:=cnfStr;
    IdTCPCLient1.Host:=srvHost;
    Form1.Caption:=('configured as: ' + srvHost);
  except
    log('config file is NOT exist');
    srvHost := '127.0.0.1';
    IdTCPClient1.Host:=srvHost;
  end;
  Form1.Label7.caption:='tr';
  log('srvHost = ' + srvHost);
  Form1.Timer1.Enabled:=true;
  Form1.Timer2.Enabled:=true;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var answer,a2:string;
begin
  Label3.Caption:=IntToStr(usb_counter);

  if (lc <> usb_counter) then
  begin
  // log('c = ' + IntToStr(usb_counter) + 'lc = ' + IntToStr(lc));
    if (usb_counter > lc) then
      begin
        if (IdTCPClient1.Connected = true) then
         begin
          IdTCPClient1.WriteLn('unused');
          IdTCPClient1.SendCmd('get_name');
          IdTCPClient1.WriteLn(locName);
          IdTCPClient1.SendCmd('mouse_inject');
          log('Мышь +единена');

        end; // if (IdTCPClient1.Connected = true) then
      end; // if (usb_counter > lc) then

    if (usb_counter < lc) then
      begin
        if (IdTCPClient1.Connected = true) then
        begin
          IdTCPClient1.WriteLn('unused');
          IdTCPClient1.SendCmd('get_name');
          IdTCPClient1.WriteLn(locName);
          IdTCPClient1.SendCmd('mouse_eject');
          log('Мышь отсоединена');

        end; // if (IdTCPClient1.Connected = true) then
      end;
    lc := usb_counter; // equallly
  end; // lc <> usb_counter
end;  // end of timer

procedure TForm1.FormPaint(Sender: TObject);
begin
  Form1.Visible:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  IdTCPCLient1.Host:=Edit2.Text;
  timer1.Enabled:=true;
  timer2.Enabled:=true;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try CloseFile(logFile); except end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  //Form1.Visible:=false;
try
    IdTCPClient1.SendCmd('alive');
    Form1.Label6.Caption:='Подключен';
  except
    Form1.Label6.Caption:='Отключен';
    Form1.Timer1.Enabled:=false;
    try
     if (IdTCPClient1.Connected = false)then
     begin
      log('srvHost = ' + srvHost);
      IdTCPClient1.Host:=srvHost;

      IdTCPClient1.Connect();
      begin
          IdTCPClient1.WriteLn('unused');
          IdTCPClient1.SendCmd('get_name');
          IdTCPClient1.WriteLn(locName);
          IdTCPClient1.SendCmd('test');
        end;
      Form1.Timer1.Enabled:=true;
      Form1.Timer2.Enabled:=true;
     end;
    except   end;
  end; // try
  //Form1.Timer1.Enabled:=true;
  Form1.Timer2.Enabled:=true;
end; // timer 3

end.
