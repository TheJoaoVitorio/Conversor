unit uConexaoFirebird.Teste.DESTINO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils;

type
  TConexaoFirebirdDes = class { Conexao Destino - Banco Vazio }
    private
      FBConexao : TFDConnection;
      FBQuery   : TFDQuery;

      fbDesPort     : String;
      fbDesDatabase : String;
      fbDesPassword : String;
      fbDesUsername : String;
      fbDesServer   : String;

    public
      constructor Create;
      destructor Destroy; override;

      function GetConexaoFBDestino    : TFDConnection;
      function Select(Tabela : String): TFDQuery;

      property FBUsername : String read fbDesUsername write fbDesUsername;
      property FBPassword : String read fbDesPassword write fbDesPassword;
      property FBPort     : String read fbDesPort     write fbDesPort;
      property FBServer   : String read fbDesServer   write fbDesServer;
      property FBDatabase : String read fbDesDatabase write fbDesDatabase;


  end;

implementation

{ TConexaoFirebirdDes }

constructor TConexaoFirebirdDes.Create;
  begin
    FBConexao := TFDConnection.Create(nil);
    FBQuery   := TFDQuery.Create(nil);
  end;

destructor TConexaoFirebirdDes.Destroy;
  begin
    FreeAndNil(FBConexao);
    FreeAndNil(FBQuery);
    inherited;
  end;

function TConexaoFirebirdDes.GetConexaoFBDestino : TFDConnection;
  begin
    with FBConexao do
      begin
        Params.Add('DriverID=FB');
        Params.Database     := fbDesDatabase;
        Params.UserName     := fbDesUsername;
        Params.Password     := fbDesPassword;
        Params.Add('Server='+  fbDesServer);
        Params.Add('Port='  +  fbDesPort);
        LoginPrompt         := False;

        Connected           := True;

        Result := FBConexao;
      end;
  end;


function TConexaoFirebirdDes.Select(Tabela : String): TFDQuery;
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
