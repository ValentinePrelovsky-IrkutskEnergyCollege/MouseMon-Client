unit ComponentUSB;

interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
type

  PDevBroadcastHdr  = ^DEV_BROADCAST_HDR;
  DEV_BROADCAST_HDR = packed record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
  end;

  PDevBroadcastDeviceInterface  = ^DEV_BROADCAST_DEVICEINTERFACE;
  DEV_BROADCAST_DEVICEINTERFACE = record
    dbcc_size: DWORD;
    dbcc_devicetype: DWORD;
    dbcc_reserved: DWORD;
    dbcc_classguid: TGUID;
    dbcc_name: short;
  end;

  type

  TComponentUSB = class(TComponent)
  private
    FWindowHandle: HWND;

    FOnUSBArrival: TNotifyEvent;
    FOnUSBRemove: TNotifyEvent;
    procedure WndProc(var Msg: TMessage);
    function USBRegister: Boolean;
  protected
    procedure WMDeviceChange(var Msg: TMessage); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    //mouse_present:boolean;
    property OnUSBArrival: TNotifyEvent read FOnUSBArrival write FOnUSBArrival;
    property OnUSBRemove: TNotifyEvent read FOnUSBRemove write FOnUSBRemove;
  end;

  const
  GUID_DEVINTERFACE_USB_DEVICE: TGUID = '{A5DCBF10-6530-11D2-901F-00C04FB951ED}';
  DBT_DEVICEARRIVAL          = $8000;          // system detected a new device
  DBT_DEVICEREMOVECOMPLETE   = $8004;          // device is gone
  DBT_DEVTYP_DEVICEINTERFACE = $00000005;      // device interface class

  GUID_DEVINTERFACE_MOUSE: TGUID = '{378DE44C-56EF-11D1-BC8C-00A0C91405DD}';

var
  usb_removed_msg:boolean;
  usb_arrived_msg:boolean;
  usb_counter:integer;

implementation

constructor TComponentUSB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWindowHandle := AllocateHWnd(WndProc);
  USBRegister;
end;

destructor TComponentUSB.Destroy;
begin
  DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TComponentUSB.WndProc(var Msg: TMessage);
begin
  if (Msg.Msg = WM_DEVICECHANGE) then
  begin
    try
      WMDeviceChange(Msg);
    except
      Application.HandleException(Self);
    end;
  end
  else
    Msg.Result := DefWindowProc(FWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

procedure TComponentUSB.WMDeviceChange(var Msg: TMessage);
var
  devType: Integer;
  Datos: PDevBroadcastHdr;
begin
  if (Msg.wParam = DBT_DEVICEARRIVAL) or (Msg.wParam = DBT_DEVICEREMOVECOMPLETE) then
  begin
    Datos := PDevBroadcastHdr(Msg.lParam);
    devType := Datos^.dbch_devicetype;
    if devType = DBT_DEVTYP_DEVICEINTERFACE then
    begin // USB Device
      if Msg.wParam = DBT_DEVICEARRIVAL then
      begin
        if Assigned(FOnUSBArrival) then
          FOnUSBArrival(Self);
          usb_counter:=usb_counter+1;
          // ShowMessage('attached'); // dbg
          usb_removed_msg:=false;
          usb_arrived_msg:=true;
      end
      else
      begin
        if Assigned(FOnUSBRemove) then
          FOnUSBRemove(Self);
          usb_counter:=usb_counter-1;
          // ShowMessage('removed'); // dbg
          usb_arrived_msg:=false;
          usb_removed_msg:=true;
      end;
    end;
  end;
end;

function TComponentUSB.USBRegister: Boolean;
var
  dbi: DEV_BROADCAST_DEVICEINTERFACE;
  Size: Integer;
  r: Pointer;

  mi:  DEV_BROADCAST_DEVICEINTERFACE;//GUID_DEVINTERFACE_MOUSE
  sizeMi:Integer;
  rMi:Pointer;

begin
  Result := False;
  Size := SizeOf(DEV_BROADCAST_DEVICEINTERFACE);
  ZeroMemory(@dbi, Size);
  dbi.dbcc_size := Size;
  dbi.dbcc_devicetype := DBT_DEVTYP_DEVICEINTERFACE;
  dbi.dbcc_reserved := 0;
  dbi.dbcc_classguid  := GUID_DEVINTERFACE_MOUSE;//GUID_DEVINTERFACE_USB_DEVICE;
  dbi.dbcc_name := 0;

  r := RegisterDeviceNotification(FWindowHandle, @dbi,
    DEVICE_NOTIFY_WINDOW_HANDLE
    );
  if Assigned(r) then Result := True;
end;
end.
