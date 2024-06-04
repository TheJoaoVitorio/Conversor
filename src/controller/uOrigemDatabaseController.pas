unit uOrigemDatabaseController;

interface

uses
  Vcl.Dialogs ,
  uMySQLController.Teste, uFirebirdController.Teste;

type
  TOrigemDatabaseController = class  {Controller da unit SELECIONAR ORIGEM}
    private
      fSelecionarOrigem : String;
    public
      class function GetController : TOrigemDatabaseController;

      function TesteConexao         : Boolean;
      function TesteConexaoMySQL    : Boolean;
      function TesteConexaoFirebird : Boolean;

      property AcessarOrigem : String read fSelecionarOrigem write fSelecionarOrigem;
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


function TOrigemDatabaseController.TesteConexao: Boolean;
  begin

    if AcessarOrigem = 'MySQL 10.4.32' then
      begin
        if TesteConexaoMySQL = True then
          Result := True;
      end;

    if AcessarOrigem = 'Firebird 2.5.9' then
      begin
        if TesteConexaoFirebird = True then
          Result := True;
      end;


  end;


function TOrigemDatabaseController.TesteConexaoMySQL: Boolean; {Teste - MySQL}
  begin
    try
      if TMySQLController.GetControllerMY.AcessarConexaoMy.GetConexaoMySQL.Connected then
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
      ShowMessage('Algo de errado acontenceu! ');
      Result := False;
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
      ShowMessage('Algo de errado acontenceu! ');
      Result := False;
    end;
  end;


initialization
  iControllerOrigemData := TOrigemDatabaseController.create

finalization
  if iControllerOrigemData <> nil then
    iControllerOrigemData.Free;


end.
