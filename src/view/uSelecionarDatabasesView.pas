unit uSelecionarDatabasesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.CheckLst, Vcl.DBCtrls, Data.DB ,
  FireDAC.Comp.Client , uDatabasesController;

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
    Panel2: TPanel;
    pnlBuscarImg: TPanel;
    Image2: TImage;
    edtBuscarDatabase: TEdit;
    pnlContentRight: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    DBListConexoesDisponiveis: TDBListBox;
    dsConexoesDisponiveis: TDataSource;
    Button1: TButton;
    procedure lblNavSairClick(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    procedure ConfigurarList;
  public

  end;

var
  frmSelecionarDatabases: TfrmSelecionarDatabases;

implementation

{$R *.dfm}

procedure TfrmSelecionarDatabases.FormCreate(Sender: TObject);
  begin
    if TDatabasesController.getInstance.acessarConexao.getConexao.Connected then
      ShowMessage('Conectado');

    ConfigurarList;
  end;


procedure TfrmSelecionarDatabases.ConfigurarList;
  var
    Query : TFDQuery;
  begin
     DBListConexoesDisponiveis.DataSource := dsConexoesDisponiveis;
    try
      Query                         := TDatabasesController.getInstance.acessarConexao.selectDatabasesDisponiveis;
      dsConexoesDisponiveis.DataSet := Query;

      Query.First;
      while not Query.Eof do
        begin
          DBListConexoesDisponiveis.Items.Add(Query.FieldByName('nome').AsString);
          Query.Next;
        end;
    except
      Query.Free;
    end;

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
