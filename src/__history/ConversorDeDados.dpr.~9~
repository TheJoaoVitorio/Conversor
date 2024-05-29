program ConversorDeDados;

uses
  Vcl.Forms,
  uSelecionarDatabasesView in 'view\uSelecionarDatabasesView.pas' {frmSelecionarDatabases},
  uStylesView in 'view\uStylesView.pas',
  uDatabasesController in 'controller\uDatabasesController.pas',
  uConDatabasesModel in 'model\uConDatabasesModel.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown   := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSelecionarDatabases, frmSelecionarDatabases);
  Application.Run;
end.
