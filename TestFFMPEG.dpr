program TestFFMPEG;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  vorbis_parser in 'libavcodec\vorbis_parser.pas',
  libavcodec.avcodec in 'libavcodec\libavcodec.avcodec.pas',
  libavutil.samplefmt in 'libavutil\libavutil.samplefmt.pas',
  libavutil.avutil in 'libavutil\libavutil.avutil.pas',
  libavutil.frame in 'libavutil\libavutil.frame.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
