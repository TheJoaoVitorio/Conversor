unit uConexaoFirebird.Teste;

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
  FireDAC.Phys.FB ,
  Datasnap.DBClient;

type
  TConexaoFirebird = class
    private
      FBConexao  : TFDConnection;
      FBQuery    : TFDQuery;
      FQ         : TFDQuery;

      fbUsername: String;
      fbPassword: String;
      fbServer  : String;
      fbPort    : String;
      fbDatabase: String;
      fbDriver  : String;

    public
      constructor Create;
      destructor Destroy; override;

      function GetConexaoFirebird      : TFDConnection;
      function Select(Tabela : String) : TFDQuery;

      property FtestUsername : String read fbUsername write fbUsername;
      property FtestPassword : String read fbPassword write fbPassword;
      property FtestServer   : String read fbServer   write fbServer;
      property FtestPort     : String read fbPort     write fbPort;
      property FtestDatabase : String read fbDatabase write fbDatabase;
      property FtestDriver : String read fbDriver   write fbDriver;

      property FQuery : TFDQuery read FQ write FQ;
      property FConexao : TFDConnection read FBConexao write FBConexao;

  end;

implementation

{ TConexaoFirebird }

constructor TConexaoFirebird.Create;
  begin
    FBConexao := TFDConnection.Create(nil);
    FBQuery   := TFDQuery.Create(nil);
    FQ    := TFDQuery.Create(nil);
  end;

destructor TConexaoFirebird.Destroy;
  begin
    FreeAndNil(FBConexao);
    FreeAndNil(FBQuery);
    FreeAndNil(FQ);
    inherited;
  end;

function TConexaoFirebird.GetConexaoFirebird : TFDConnection;
  begin
    with FBConexao do
      begin
        Params.Add('DriverID=FB');
        Params.DriverID := fbDriver;
        Params.UserName := fbUsername;
        Params.Password := fbPassword;
        Params.Database := fbDatabase;
        Params.Add('Server='+ fbServer);
        Params.Add('Port='+ fbPort);
        Connected       := True;

        Result   := FBConexao;
      end;
  end;

function TConexaoFirebird.Select(Tabela: String): TFDQuery;
  begin
    with FBQuery do
      begin
        Close;
        Connection := FBConexao;
        SQL.Text   := 'SELECT * FROM ' + Tabela;
        Open;

        Result := FBQuery;
      end;
  end;

end.
