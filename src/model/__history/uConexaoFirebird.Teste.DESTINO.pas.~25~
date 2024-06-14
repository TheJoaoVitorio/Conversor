unit uConexaoFirebird.Teste.DESTINO;

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
  Datasnap.DBClient, Vcl.Dialogs ;

type
  TConexaoFirebirdDes = class { Conexao Destino - Banco Vazio }
    private
      FBConexaoDestino : TFDConnection;
      FBQuery          : TFDQuery;

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
    FBConexaoDestino := TFDConnection.Create(nil);
    FBQuery          := TFDQuery.Create(nil);
  end;

destructor TConexaoFirebirdDes.Destroy;
  begin
    FreeAndNil(FBConexaoDestino);
    FreeAndNil(FBQuery);
    inherited;
  end;

function TConexaoFirebirdDes.GetConexaoFBDestino : TFDConnection;
  begin
    try
      with FBConexaoDestino do
        begin
          Params.Add('DriverID=FB');
          Params.Database     := fbDesDatabase;
          Params.UserName     := fbDesUsername;
          Params.Password     := fbDesPassword;
          Params.Add('Server='+  fbDesServer);
          Params.Add('Port='  +  fbDesPort);
          LoginPrompt         := False;
          Connected           := True;

          Result              := FBConexaoDestino;
        end;
    except
      on E: Exception do
        begin
          ShowMessage('Erro de conexão: ' + E.Message);
          Result := nil; // ou outra ação apropriada, dependendo da lógica do seu aplicativo
        end;
     end;
  end;

function TConexaoFirebirdDes.Select(Tabela : String): TFDQuery;
  begin
    with FBQuery do
      begin
        Close;
        Connection := FBConexaoDestino;
        SQL.Text   := 'SELECT * FROM ' + Tabela;
        Open;

        Result     := FBQuery;
      end;
  end;

end.
