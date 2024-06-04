unit uConDatabasesModel;

interface

uses
  Vcl.StdCtrls,
  Vcl.Forms,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Error,
  FireDAC.Phys.MySQL,
  FireDAC.DApt,
  FireDAC.UI.Intf,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB;

type
  TDatabasesModel = class
    private
      FConexaoDBs     : TFDConnection;
      QueryConexaoDBs : TFDQuery;

    public
      constructor Create;
      destructor Destroy; override;

      function getConexao : TFDConnection;
      function selectDatabasesDisponiveis(dbEscolhido : String) : TFDQuery;
      function select : TFDQuery;
  end;

implementation

uses
  Vcl.Dialogs;

{ TDatabasesModel }

constructor TDatabasesModel.Create;
  begin
    inherited Create;

    FConexaoDBs     := TFDConnection.Create(nil);
    QueryConexaoDBs := TFDQuery.Create(nil);
  end;

destructor TDatabasesModel.Destroy;
  begin
    FreeAndNil(FConexaoDBs);
    FreeAndNil(QueryConexaoDBs);
    inherited;
  end;

function TDatabasesModel.getConexao: TFDConnection;
  begin
    FConexaoDBs.Params.UserName := 'SYSDBA';
    FConexaoDBs.Params.Password := 'masterkey';
    FConexaoDBs.Params.Add('DriverId=FB');
    FConexaoDBs.Params.Database := 'C:\Users\joaov\OneDrive\Desktop\DATABASES\DATABASESCONVERSOR.FDB';
    FConexaoDBs.LoginPrompt     := False;
    FConexaoDBs.Connected       := True;

    Result := FConexaoDBs;
  end;

function TDatabasesModel.select: TFDQuery;
  begin
    QueryConexaoDBs.Close;
    QueryConexaoDBs.Connection := FConexaoDBs;
    QueryConexaoDBs.SQL.Text   := 'SELECT * FROM DATABASES';
    QueryConexaoDBs.Open;

    Result := QueryConexaoDBs;
  end;

function TDatabasesModel.selectDatabasesDisponiveis(dbEscolhido : String): TFDQuery;
  begin
    try
      with QueryConexaoDBs do
        begin
          Close;
          Connection := FConexaoDBs;
          SQL.Text   := 'SELECT * FROM DATABASES WHERE NOME LIKE :dbEscolhido';
          Params.ParamByName('dbEscolhido').AsString :=  '%' + dbEscolhido + '%';
          Open;

          Result := QueryConexaoDBs;
        end;
    except
      on E : Exception do
      begin
        ShowMessage('Erro ao executar consulta: ' + E.Message);
        Result := nil;
      end;

    end;
  end;

end.
