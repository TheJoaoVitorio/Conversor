unit uMySQLController.Teste;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Datasnap.DBClient,
  Vcl.StdCtrls,

  uConexaoMySQL.Teste;

type
  TMySQLController = class    {TESTE}
    private
      MySQLConexao : TObject;

      MConexao     : TConexaoMySql;


      constructor Create;
      destructor Destroy; override;
    public

      class function GetControllerMY : TMySQLController;
      property AcessarConexaoMy : TObject read MySQLConexao write MySQLConexao; {Externa - Acesso do controller OrigemDatabase}

      property AcessoConexaoMySQL : TConexaoMySql read MConexao write MConexao;{Acesso a conexao do controller para o model}

      procedure ConfiguracaoConexao;
  end;

implementation

var
  iControllerMySQL : TMySQLController;

{ TMySQLController }

constructor TMySQLController.Create;
  begin
    inherited;
    MySQLConexao := TConexaoMySql.Create;
    MConexao     := TConexaoMySql.Create;

    ConfiguracaoConexao;
  end;

destructor TMySQLController.Destroy;
  begin
    FreeAndNil(MySQLConexao);
    FreeAndNil(MConexao);
  end;


class function TMySQLController.GetControllerMY: TMySQLController;
  begin
    if iControllerMySQL = nil then
      iControllerMySQL := iControllerMySQL.Create;

    Result := iControllerMySQL;
  end;

procedure TMySQLController.ConfiguracaoConexao;
  begin
    MConexao.MySqlUserName := 'root';
    MConexao.MySqlPassword := '';
    MConexao.MySqlServer   := 'localhost';
    MConexao.MySqlPort     := '3306';
    MConexao.MySqlDatabase := 'loja';

  end;



initialization
  iControllerMySQL := TMySQLController.Create;

finalization
  if iControllerMySQL <> nil then
    iControllerMySQL.Free;


end.
