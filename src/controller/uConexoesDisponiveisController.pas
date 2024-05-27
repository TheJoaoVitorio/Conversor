unit uConexoesDisponiveisController;

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

  uConexoesDisponiveisModel;

type
  TConexoesDisponiveisController = class

  private
    FConexoesDisponiveis : TConexoesDisponiveisModel;

    constructor Create;
    destructor Destroy; override;

  public

    class function getControllerConexoesDisponiveis : TConexoesDisponiveisController;

    property Conexoes : TConexoesDisponiveisModel  read FConexoesDisponiveis write FConexoesDisponiveis;

  end;

implementation

var
  iControllerConexoesDisponiveis : TConexoesDisponiveisController;

{ TConexoesDisponiveisController }

constructor TConexoesDisponiveisController.Create;
  begin
    inherited Create;

    Conexoes := TConexoesDisponiveisModel.Create;
  end;

destructor TConexoesDisponiveisController.Destroy;
  begin
    FreeAndNil(Conexoes);
    inherited;
  end;



class function TConexoesDisponiveisController.getControllerConexoesDisponiveis: TConexoesDisponiveisController;
  begin
    if iControllerConexoesDisponiveis = nil then
      iControllerConexoesDisponiveis := TConexoesDisponiveisController.Create;
  end;


initialization
  iControllerConexoesDisponiveis := TConexoesDisponiveisController.Create;

finalization
  if iControllerConexoesDisponiveis <> nil then
    iControllerConexoesDisponiveis.Free;

end.
