unit uDatabasesController;

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

  uConDatabasesModel;

type
  TDatabasesController = class
    private
      FConexaoDBs: TDatabasesModel;

      constructor Create;
      destructor Destroy; override;
    public
      class function getInstance : TDatabasesController;

      property acessarConexao : TDatabasesModel read FConexaoDBs write FConexaoDBs;
  end;

implementation

var
  iController : TDatabasesController;

{ TDatabasesController }

constructor TDatabasesController.Create;
  begin
    inherited Create;

    FConexaoDBs := TDatabasesModel.Create;
  end;

destructor TDatabasesController.Destroy;
  begin
    FreeAndNil(FConexaoDBs);
    inherited;
  end;

class function TDatabasesController.getInstance: TDatabasesController;
  begin
    if iController = nil then
      iController := TDatabasesController.Create;

      Result := iController;
  end;

initialization
  iController := TDatabasesController.Create;

finalization
  if iController <> nil then
    iController.Free;

end.
