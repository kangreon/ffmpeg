unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$I 'libavutil/version.inc'}
{$I 'libavcodec/version.inc'}

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := LIBAVCODEC_VERSION;
  Caption := Caption + ' ' + LIBAVUTIL_VERSION;
//
end;

end.
