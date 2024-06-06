unit uOrigemDatabaseController;

interface

uses
  Vcl.Dialogs ,
  uMySQLController.Teste, uFirebirdController.Teste,

  uConexaoFirebird.Teste, uConexaoMySQL.Teste,

  System.SysUtils,
  FireDAC.Comp.Client;

type
  TOrigemDatabaseController = class  {Controller da unit SELECIONAR ORIGEM}
    private
      fSelecionarOrigem : String;
      fEscolhidoPor     : String;

      iClassMySQL : TConexaoMySql;
      iClassFB    : TFirebirdTesteController;

    public
      constructor Create;
      destructor Destroy; override;

      class function GetController : TOrigemDatabaseController;

      function TesteConexao(EscolhidoPor : String) : Boolean;   { global - essa fun��o deve testar todas conex�es }
      function TesteConexaoMySQL    : Boolean;
      function TesteConexaoFirebird : Boolean;
      function GetEscolhidoPor      : String;

      property AcessarOrigem       : String read fSelecionarOrigem write fSelecionarOrigem;
      property AcessarEscolhidoPor : String read fEscolhidoPor     write fEscolhidoPor;
  end;

implementation

{ TOrigemDatabaseController }
var
  iControllerOrigemData : TOrigemDatabaseController;

class function TOrigemDatabaseController.GetController: TOrigemDatabaseController;
  begin
    if iControllerOrigemData = nil then
      iControllerOrigemData := iControllerOrigemData.Create;

    Result := iControllerOrigemData;
  end;

constructor TOrigemDatabaseController.Create;
  begin
    iClassMySQL := TConexaoMySql.Create;
    iClassFB    := TFirebirdTesteController.Create;
  end;

destructor TOrigemDatabaseController.Destroy;
  begin
    FreeAndNil(iClassMySQL);
    FreeAndNil(iClassFB);
    inherited;
  end;

function TOrigemDatabaseController.GetEscolhidoPor: String;{ Pegar a escolha do cbx }
  var
    oEscolha : String;
  begin
    oEscolha := TOrigemDatabaseController.GetController.AcessarEscolhidoPor;
    Result   := oEscolha;
  end;

function TOrigemDatabaseController.TesteConexao(EscolhidoPor : String): Boolean;
  begin
    if EscolhidoPor = 'TESTE' then
      begin

        if AcessarOrigem = 'MySQL 10.4.32' then
          begin
            if TesteConexaoMySQL = True then
              Result := True;
          end

        else if AcessarOrigem = 'Firebird 2.5.9' then
          begin
            if TesteConexaoFirebird = True then
              Result := True;
          end;

      end

    else if EscolhidoPor = 'G10' then
      ShowMessage('G10');

  end;

function TOrigemDatabaseController.TesteConexaoMySQL: Boolean; {Teste - MySQL}
  begin
    try
      if TMySQLController.GetControllerMY.AcessoConexaoMySQL.GetConexaoMySQL.Connected then
        begin
          ShowMessage('Conectado!');
          Result := True;
        end
      else
        begin
          ShowMessage('N�o Conectado!');
          Result := False;
        end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro: '+ E.Message);
        Result := False;
      end;

    end;
  end;

function TOrigemDatabaseController.TesteConexaoFirebird: Boolean; {Teste - Firebird}
  begin
    try
      if TFirebirdTesteController.GetController.AcessarConexaoFB.GetConexaoFirebird.Connected then
        begin
          ShowMessage('Conectado!');
          Result := True;
        end
      else
        begin
          ShowMessage('N�o Conectado!');
          Result := False;
        end;
    except
      on E: Exception do
        begin
          ShowMessage('Erro: '+ E.Message);
          Result := False;
        end;
    end;
  end;


initialization
  iControllerOrigemData := TOrigemDatabaseController.create

finalization
  if iControllerOrigemData <> nil then
    iControllerOrigemData.Free;


end.
