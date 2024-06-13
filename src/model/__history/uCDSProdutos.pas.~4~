unit uCDSProdutos;

interface

uses
  Datasnap.DBClient, Data.DB, System.SysUtils;

type
  TCDSProdutos = class
    private
      cdsProd : TClientDataSet;

    public
      constructor Create;
      destructor Destroy; override;

      procedure CriarCDS;


      property iCDSProd : TClientDataSet read cdsProd write cdsProd;
  end;

implementation

{ TCDSProdutos }

constructor TCDSProdutos.Create;
  begin
    inherited Create;
    CriarCDS;
  end;

destructor TCDSProdutos.Destroy;
  begin
    FreeAndNil(iCDSProd);
    inherited;
  end;


procedure TCDSProdutos.CriarCDS;
  begin
    cdsProd := TCLientDataSet.Create(nil);

      with cdsProd do
      begin
        FieldDefs.Add('ID_PRODUTO', ftInteger);
        FieldDefs.Add('GTIN', ftString , 14);
        FieldDefs.Add('BARRAS', ftString , 30);
        FieldDefs.Add('BARRAS_CX', ftString , 30);
        FieldDefs.Add('PRODUTO', ftString, 120);
        FieldDefs.Add('DESCRICAO_COMPRA', ftString , 120);
        FieldDefs.Add('DESCRICAO_COMPLEMENTAR', ftString ,500);
        FieldDefs.Add('CODIGO_BALANCA', ftInteger);
        FieldDefs.Add('REFERENCIA', ftString , 100);
        FieldDefs.Add('ESTOQUE', ftString , 18);

      end;

      cdsProd.CreateDataSet;
      cdsProd.Open;
  end;


end.
