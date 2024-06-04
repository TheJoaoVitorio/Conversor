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
      MySQLConexao : TConexaoMySql;
      constructor Create;
      destructor Destroy; override;
    public

      class function GetControllerMY : TMySQLController;
      property AcessarConexaoMy : TConexaoMySql read MySQLConexao write MySQLConexao;

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

    ConfiguracaoConexao;
  end;

destructor TMySQLController.Destroy;
  begin
    FreeAndNil(MySQLConexao);
  end;


class function TMySQLController.GetControllerMY: TMySQLController;
  begin
    if iControllerMySQL = nil then
      iControllerMySQL := iControllerMySQL.Create;

    Result := iControllerMySQL;
  end;

procedure TMySQLController.ConfiguracaoConexao;
  begin
    MySQLConexao.MySqlUserName := 'root';
    MySQLConexao.MySqlPassword := '';
    //MySQLConexao.MySqlServer   := '<LOCAL>';
    MySQLConexao.MySqlPort     := '3306';
    MySQLConexao.MySqlDatabase := 'loja';

  end;



initialization
  iControllerMySQL := TMySQLController.Create;

finalization
  if iControllerMySQL <> nil then
    iControllerMySQL.Free;


end.
