unit uSelecionarDatabasesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.CheckLst, Vcl.DBCtrls, Data.DB ,
  FireDAC.Comp.Client , uDatabasesController, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

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
    ListBoxOpDatabases: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;

    PopupMenuOpcoesDatabases: TPopupMenu;
    AdicionarOrigem1: TMenuItem;
    AdicionarDestino1: TMenuItem;

    procedure lblNavSairClick(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxTiposDeDatabasesChange(Sender: TObject);
    procedure ListBoxOpDatabasesClick(Sender: TObject);


  private
    DatabaseOrigem  : String;
    DatabaseDestino : String;

    function CaptarPrimeiraLetraNaBusca(const Palavra : String) : String; {transforma a primeira letra da busca de databases em maiuscula}
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

  end;


function TfrmSelecionarDatabases.CaptarPrimeiraLetraNaBusca(
  const Palavra: String): String;
  begin
    if Length(Palavra) > 0 then
      begin
        Result := UpperCase(Palavra[1]) + LowerCase(Copy(Palavra,2, Length(Palavra) - 1));
      end
    else
      Result := Palavra;
  end;


procedure TfrmSelecionarDatabases.cbxTiposDeDatabasesChange(Sender: TObject);
var
    dbEscolhido : String;
    i: Integer;
    Query : TFDQuery;
  begin
    //dbEscolhido := cbxTiposDeDatabases.Text;
    dbEscolhido :=  CaptarPrimeiraLetraNaBusca(cbxTiposDeDatabases.Text);

    Query := TDatabasesController.getInstance.acessarConexao.selectDatabasesDisponiveis(dbEscolhido);
    dsConexoesDisponiveis.DataSet :=  Query;

    Query.Open;

      ListBoxOpDatabases.Items.BeginUpdate;
      try
        ListBoxOpDatabases.Clear;
        Query.First;
        while not Query.Eof do
          begin
            if not Query.FieldByName('NOME').IsNull then
              ListBoxOpDatabases.Items.Add(Query.FieldByName('NOME').AsString);

            Query.Next;
          end;
      finally
        ListBoxOpDatabases.Items.EndUpdate;
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


procedure TfrmSelecionarDatabases.ListBoxOpDatabasesClick(Sender: TObject);
  var
    databaseOrigem : String;
  begin
    if ListBoxOpDatabases.ItemIndex >= 0 then
      begin
        databaseOrigem := ListBoxOpDatabases.Items[ListBoxOpDatabases.ItemIndex];
      end;
    ShowMessage('Database Origem: ' + databaseOrigem);
  end;



end.
