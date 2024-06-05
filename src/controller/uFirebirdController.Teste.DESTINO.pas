unit uFirebirdController.Teste.DESTINO;

interface

uses
    System.SysUtils,
    uConexaoFirebird.Teste.DESTINO;

type
  TFirebirdTesteDestinoController = class
    private
      FBDESConexao: TConexaoFirebirdDes;

      constructor Create;
      destructor Destroy; override;
    public
      class function GetController : TFirebirdTesteDestinoController;

      property AcessarConexao : TConexaoFirebirdDes read FBDESConexao write FBDESConexao;
  end;

implementation

var
  iFBDestinoController : TFirebirdTesteDestinoController;

{ TFirebirdTesteDestinoController }

constructor TFirebirdTesteDestinoController.Create;
  begin
    FBDESConexao := TConexaoFirebirdDes.Create;
  end;

destructor TFirebirdTesteDestinoController.Destroy;
  begin
    FreeAndNil(FBDESConexao);
    inherited;
  end;

class function TFirebirdTesteDestinoController.GetController: TFirebirdTesteDestinoController;
  begin
    if iFBDestinoController =  nil then
      iFBDestinoController := iFBDestinoController.Create;
  end;


initialization
  iFBDestinoController := TFirebirdTesteDestinoController.Create;

finalization
  if iFBDestinoController <> nil then
    iFBDestinoController.Free;
end.
