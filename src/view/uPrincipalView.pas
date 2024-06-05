unit uPrincipalView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Imaging.pngimage,Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids ,

  uOrigemDatabaseController, uMySQLController.Teste , uFirebirdController.Teste;

type
  TfrmPrincipal = class(TForm)
    pnlMain: TPanel;
    pnlNavLateral: TPanel;
    pnlNavHeader: TPanel;
    Image1: TImage;
    pnlNavSair: TPanel;
    imgSair: TImage;
    lblNavSair: TLabel;
    pnlContainerMain: TPanel;
    pnlHeader: TPanel;
    lblTextHeader: TLabel;
    pnlContent: TPanel;
    cbxDestino: TComboBox;
    cbxOrigem: TComboBox;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Image2: TImage;
    dsOrigem: TDataSource;
    dsDestino: TDataSource;
    procedure imgSairClick(Sender: TObject);
    procedure lblNavSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure cbxOrigemChangeMySqlTeste(Sender: TObject);

  private
    TabelaOrigem  : String;
    TabelaDestino : String;

    procedure GetTabelasMySqlTesteParaCBX;
    procedure SetDataSourceGrid;
    procedure SetDsOrigemMySQL;

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormShow(Sender: TObject);
  var
    EscolhidoPor : String;
    OpcaoOrigem  : String;
  begin
    EscolhidoPor := TOrigemDatabaseController.GetController.GetEscolhidoPor; { G10 , GDOOR , TESTE}
    OpcaoOrigem  := TOrigemDatabaseController.GetController.AcessarOrigem;   {Firebird , MySQL ,PostgreeSQL}

    if EscolhidoPor = 'TESTE' then
      begin
        if OpcaoOrigem = 'MySQL 10.4.32' then
          begin
            ShowMessage('MySQL');
            GetTabelasMySqlTesteParaCBX;
            SetDataSourceGrid;

            cbxOrigem.OnChange := cbxOrigemChangeMySqlTeste;
          end
        else if OpcaoOrigem = 'Firebird 2.5.9' then
          begin
            ShowMessage('Firebird 2')
          end;


      end;
  end;

{ MYSQL - TESTE }

procedure TfrmPrincipal.GetTabelasMySqlTesteParaCBX;
  var
    NomeDatabase : String;
  begin
    NomeDatabase := TMySQLController.GetControllerMY.AcessoConexaoMySQL.GetConexaoMySQL.Params.Database;
    ShowMessage(NomeDatabase);

    TMySQLController.GetControllerMY.AcessoConexaoMySQL.GetConexaoMySQL.GetTableNames(NomeDatabase, '', '',cbxOrigem.Items);
  end;

procedure TfrmPrincipal.SetDataSourceGrid;
  begin
    DBGrid1.DataSource := dsOrigem;
  end;

procedure TfrmPrincipal.SetDsOrigemMySQL;
  begin
    dsOrigem.DataSet := TMySQLController.GetControllerMY.AcessoConexaoMySQL.Select(TabelaOrigem);
  end;

procedure TfrmPrincipal.cbxOrigemChangeMySqlTeste(Sender: TObject);
  begin
    TabelaOrigem := cbxOrigem.Text;
    SetDsOrigemMySQL
  end;

{ FIM MYSQL - TESTE }


{ FIREBIRD - DESTINO (teste) }



procedure TfrmPrincipal.imgSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;

procedure TfrmPrincipal.lblNavSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;


end.
