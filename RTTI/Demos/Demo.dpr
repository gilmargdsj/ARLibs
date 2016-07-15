program Demo;

uses
  Vcl.Forms,
  RTTIDemo in 'RTTIDemo.pas' {Form1},
  ARLibs.RTTI.Core in '..\Core\ARLibs.RTTI.Core.pas',
  ARLibs.RTTI.Interfaces in '..\Core\ARLibs.RTTI.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
