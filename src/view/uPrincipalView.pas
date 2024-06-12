unit uPrincipalView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Imaging.pngimage,Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids ,

  uOrigemDatabaseController,

  uMySQLController.Teste , uFirebirdController.Teste ,
  uCDSProdutosController,
  uFirebirdController.Teste.DESTINO, Datasnap.DBClient;

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
    imgTransferir: TImage;
    dsOrigem: TDataSource;
    dsDestino: TDataSource;
    DataSource1: TDataSource;
    DBGrid3: TDBGrid;
    procedure imgSairClick(Sender: TObject);
    procedure lblNavSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    //procedure cbxOrigemChangeMySqlTeste(Sender: TObject);
    //procedure cbxOrigemChangeFBTeste(Sender: TObject);

    procedure cbxOrigemSelectMySqlTeste(Sender: TObject);
    procedure cbxOrigemSelectFBTeste(Sender: TObject);

    procedure cbxDestinoSelectFBDestino(Sender: TObject);
    procedure imgTransferirClick(Sender: TObject);

  private
    TabelaOrigem  : String;
    TabelaDestino : String;

    procedure GetTabelasMySqlTesteParaCBX;
    procedure SetDataSourceMySqlGrid;
    procedure SetDsOrigemMySQL;

    procedure GetTabelasFBtesteParaCBX;
    procedure SetDataSourceFBGrid;
    procedure SetDsOrigemFBteste;

    procedure GetTabelasFirebirdDesParaCBX;
    procedure SetDataSourceGridDestino;
    procedure SetDsDestinoFirebird;

    procedure ConfiguracoesDestinoFB;

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
            GetTabelasMySqlTesteParaCBX;
            SetDataSourceMySqlGrid;

            cbxOrigem.OnSelect := cbxOrigemSelectMySqlTeste;

            ConfiguracoesDestinoFB;

          end
        else if OpcaoOrigem = 'Firebird 2.5.9' then
          begin
            GetTabelasFbTesteParaCBX;
            SetDataSourceFBGrid;

            cbxOrigem.OnSelect := cbxOrigemSelectFBTeste;

            ConfiguracoesDestinoFB;
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

procedure TfrmPrincipal.SetDataSourceMySqlGrid; { Grid Origem }
  begin
    DBGrid1.DataSource := dsOrigem;
  end;

procedure TfrmPrincipal.SetDsOrigemMySQL;
  begin
    dsOrigem.DataSet := TMySQLController.GetControllerMY.AcessoConexaoMySQL.Select(TabelaOrigem);
  end;

procedure TfrmPrincipal.cbxOrigemSelectMySqlTeste(Sender: TObject);
  begin
    TabelaOrigem := cbxOrigem.Text;
    SetDsOrigemMySQL
  end;

{ FIREBIRD - TESTE }

procedure TfrmPrincipal.GetTabelasFbTesteParaCBX;
  var
    NomeDatabaseDestino : String;
  begin
    NomeDatabaseDestino := 'host';

    TFirebirdTesteController.GetController.AcessarConexaoFB.GetConexaoFirebird.GetTableNames(NomeDatabaseDestino, '','', cbxOrigem.Items);
  end;

procedure TfrmPrincipal.cbxOrigemSelectFBTeste(Sender: TObject);
  begin
    TabelaOrigem := cbxOrigem.Text;
    SetDsOrigemFBteste;
  end;

procedure TfrmPrincipal.SetDsOrigemFBteste;
  begin
    dsOrigem.DataSet := TFirebirdTesteController.GetController.AcessarConexaoFB.Select(TabelaOrigem);
  end;

procedure TfrmPrincipal.SetDataSourceFBGrid;
  begin
    DBGrid1.DataSource := dsOrigem;
  end;

{ FIREBIRD - DESTINO (teste) }
procedure TfrmPrincipal.ConfiguracoesDestinoFB;
  begin
    GetTabelasFirebirdDesParaCBX;
    SetDataSourceGridDestino;
    cbxDestino.OnSelect := cbxDestinoSelectFBDestino;
  end;

procedure TfrmPrincipal.GetTabelasFirebirdDesParaCBX;
  var
    NomeDatabaseDestino : String;
  begin
    NomeDatabaseDestino := 'host';

    TFirebirdTesteDestinoController.GetController.AcessarConexao.GetConexaoFBDestino.GetTableNames(NomeDatabaseDestino, '','',cbxDestino.Items);
  end;

procedure TfrmPrincipal.SetDataSourceGridDestino;
  begin
    DBGrid2.DataSource := dsDestino;
  end;

procedure TfrmPrincipal.SetDsDestinoFirebird;
  begin
    dsDestino.DataSet := TFirebirdTesteDestinoController.GetController.AcessarConexao.Select(TabelaDestino);
  end;

procedure TfrmPrincipal.cbxDestinoSelectFBDestino(Sender: TObject);
  begin
    TabelaDestino := cbxDestino.Text;
    SetDsDestinoFirebird;
  end;

{ FIM FIREBIRD - DESTINO (teste) }


procedure TfrmPrincipal.imgSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;

procedure TfrmPrincipal.imgTransferirClick(Sender: TObject);
  var
    cds : TClientDataSet;
  begin
    try
      cds := TCDSProdutosController.GetInstance.AcessaCDS.iCDSProd;

      DBGrid3.DataSource := DataSource1;
      DataSource1.DataSet := cds;
    finally

    end;

  end;

procedure TfrmPrincipal.lblNavSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;


end.
