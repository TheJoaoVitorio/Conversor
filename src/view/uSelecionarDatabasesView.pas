unit uSelecionarDatabasesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.CheckLst, Vcl.DBCtrls, Data.DB ,
  FireDAC.Comp.Client , uDatabasesController, Vcl.Grids, Vcl.DBGrids;

type
  TfrmSelecionarDatabases = class(TForm)
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
    pnlContentLeft: TPanel;
    Panel1: TPanel;
    pnlBuscarDatabase: TPanel;
    pnlBuscarImg: TPanel;
    Image2: TImage;
    pnlContentRight: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    dsConexoesDisponiveis: TDataSource;
    cbxTiposDeDatabases: TComboBox;
    ListBox1: TListBox;
    procedure lblNavSairClick(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxTiposDeDatabasesChange(Sender: TObject);

  private

  public

  end;

var
  frmSelecionarDatabases: TfrmSelecionarDatabases;

implementation

{$R *.dfm}



procedure TfrmSelecionarDatabases.cbxTiposDeDatabasesChange(Sender: TObject);
var
    dbEscolhido : String;
    i: Integer;
    Query : TFDQuery;
  begin
    dbEscolhido := cbxTiposDeDatabases.Text;

    Query := TDatabasesController.getInstance.acessarConexao.selectDatabasesDisponiveis(dbEscolhido);
    dsConexoesDisponiveis.DataSet :=  Query;

    Query.Open;

      ListBox1.Items.BeginUpdate;
      try
        ListBox1.Clear;
        Query.First;
        while not Query.Eof do
          begin
            if not Query.FieldByName('NOME').IsNull then
              ListBox1.Items.Add(Query.FieldByName('NOME').AsString);

            Query.Next;
          end;
      finally
        ListBox1.Items.EndUpdate;
      end;

  end;

procedure TfrmSelecionarDatabases.FormCreate(Sender: TObject);
  begin
    if TDatabasesController.getInstance.acessarConexao.getConexao.Connected then
      ShowMessage('Conectado');

  end;



procedure TfrmSelecionarDatabases.imgSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;

procedure TfrmSelecionarDatabases.lblNavSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;


end.
