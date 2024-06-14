unit uFirebirdController.Teste.DESTINO;

interface

uses
    System.SysUtils,
    uConexaoFirebird.Teste.DESTINO, FireDAC.Comp.Client;

type
  TFirebirdTesteDestinoController = class
    private
      FBDESConexao: TConexaoFirebirdDes;

      constructor Create;
      destructor Destroy; override;
    public
      class function GetController : TFirebirdTesteDestinoController;

      procedure ConfigurarConexao;

      function TransfereProdutos(TabelaDestino : String) : TFDQuery;

      property AcessarConexao : TConexaoFirebirdDes read FBDESConexao write FBDESConexao;
  end;

implementation

var
  iFBDestinoController : TFirebirdTesteDestinoController;

{ TFirebirdTesteDestinoController }

constructor TFirebirdTesteDestinoController.Create;
  begin
    FBDESConexao := TConexaoFirebirdDes.Create;

    ConfigurarConexao;
  end;

destructor TFirebirdTesteDestinoController.Destroy;
  begin
    FreeAndNil(FBDESConexao);
    inherited;
  end;


class function TFirebirdTesteDestinoController.GetController: TFirebirdTesteDestinoController;
  begin
    if iFBDestinoController = nil then
      iFBDestinoController := iFBDestinoController.Create;

    Result := iFBDestinoController;
  end;


function TFirebirdTesteDestinoController.TransfereProdutos(
  TabelaDestino: String): TFDQuery;
  begin

  end;

procedure TFirebirdTesteDestinoController.ConfigurarConexao;
  begin
    FBDESConexao.FBUsername := 'SYSDBA';
    FBDESConexao.FBPassword := 'masterkey';
    FBDESConexao.FBPort     := '3050';
    FBDESConexao.FBServer   := 'localhost';
    //FBDESConexao.FBDatabase := 'C:\Firebird_Database\BancosVazio\HOST.FDB';
    //FBDESConexao.FBDatabase := 'C:\Firebird_Database\BancosVazio - Copia\HOST.FDB';  PRODUTOS J� FOI INJETADO NESSE BANCO.
    FBDESConexao.FBDatabase := 'C:\Database\DATATEST.FDB';
  end;



initialization
  iFBDestinoController := TFirebirdTesteDestinoController.Create;

finalization
  if iFBDestinoController <> nil then
    iFBDestinoController.Free;
end.
