unit uFirebirdController.Teste;

interface

uses
  System.SysUtils, uConexaoFirebird.Teste;

type
  TFirebirdTesteController = class
    private
      FBConexao : TConexaoFirebird;

      constructor Create;
      destructor Destroy; override;
    public
      class function GetController : TFirebirdTesteController;

      property AcessarConexaoFB : TConexaoFirebird read FBConexao write FBConexao;

      procedure ConfiguracaoConexaoFB;
  end;

implementation

{ TFirebirdTesteController }

var
   iControllerFBTeste : TFirebirdTesteController;

constructor TFirebirdTesteController.Create;
  begin
    FBConexao := TConexaoFirebird.Create;

    ConfiguracaoConexaoFB;
  end;

destructor TFirebirdTesteController.Destroy;
  begin
    FreeAndNil(FBConexao);
    inherited;
  end;

procedure TFirebirdTesteController.ConfiguracaoConexaoFB;
  begin
    FBConexao.FtestUsername := 'SYSDBA';
    FBConexao.FtestPassword := 'masterkey';
    FBConexao.FtestPort     := '3050';
    FBConexao.FtestServer   := 'localhost';
    //FBConexao.FtestDatabase := 'C:\Firebird_Database\HOST.FDB'; { BANCO COM DADOS }
    FBConexao.FtestDatabase := 'C:\Database\DATA.FDB';
  end;



class function TFirebirdTesteController.GetController: TFirebirdTesteController;
  begin
    if iControllerFBTeste = nil then
      iControllerFBTeste := iControllerFBTeste.Create;

    Result := iControllerFBTeste;
  end;

initialization
  iControllerFBTeste := TFirebirdTesteController.create;

finalization
  if iControllerFBTeste <> nil then
    iControllerFBTeste.Free;

end.
