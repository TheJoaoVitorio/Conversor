unit uCDSProdutosController;

interface

uses
  uCDSProdutos, System.SysUtils;

type
  TCDSProdutosController = class
    private
      CDSP : TCDSProdutos;

      constructor Create;
      destructor Destroy; override;
    public
      class function GetInstance : TCDSProdutosController; {not use}
      class function GetCDS : TCDSProdutos;

      property AcessaCDS : TCDSProdutos read CDSP write CDSP;
  end;


implementation

var
  iCDSPController : TCDSProdutosController;
  iTCDSProdutos   : TCDSProdutos;

{ TCDSProdutosController }

constructor TCDSProdutosController.Create;
  begin
    CDSP := TCDSProdutos.Create;
  end;

destructor TCDSProdutosController.Destroy;
  begin
    FreeAndNil(CDSP);
    inherited;
  end;

class function TCDSProdutosController.GetCDS: TCDSProdutos;
  begin
    if iTCDSProdutos = nil then
      iTCDSProdutos := TCDSProdutos.Create;
    Result := iTCDSProdutos;
  end;

class function TCDSProdutosController.GetInstance: TCDSProdutosController;
  begin
    if iCDSPController = nil then
      iCDSPController := iCDSPController.Create;

    Result := iCDSPController;
  end;

initialization
  iCDSPController := TCDSProdutosController.Create;

finalization
  if iCDSPController <> nil then
    iCDSPController.Free;
end.
