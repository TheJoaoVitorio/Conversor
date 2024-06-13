unit uCDSProdutos;

interface

uses
  Datasnap.DBClient, Data.DB, System.SysUtils, FireDAC.Comp.Client,Vcl.Dialogs,
  uConexaoFirebird.Teste , uFirebirdController.Teste
  ;

type
  TCDSProdutos = class
    private
      TFirebirdC : TConexaoFirebird;
      TFController : TFirebirdTesteController;
      cdsProd : TClientDataSet;

    public
      constructor Create;
      destructor Destroy; override;

      procedure CriarCDS;

      function PovoaCds(Tabela : String) : TFDQuery;
      property iCDSProd : TClientDataSet read cdsProd write cdsProd;
  end;

implementation

{ TCDSProdutos }

constructor TCDSProdutos.Create;
  begin
    inherited Create;
    TFirebirdC := TConexaoFirebird.Create;
    CriarCDS;
  end;

destructor TCDSProdutos.Destroy;
  begin
    FreeAndNil(iCDSProd);
    FreeAndNil(TFirebirdC);
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

function TCDSProdutos.PovoaCDS(Tabela : String) : TFDQuery;
  begin
    try
      try
        if Tabela = 'PRODUTOS' then
          begin
            with TFirebirdC.FQuery do
              begin
                Close;
                Connection := TFirebirdTesteController.GetController.AcessarConexaoFB.GetConexaoFirebird;
                SQL.Text   := 'SELECT * FROM ' + Tabela;
                Open;

                while not TFirebirdC.FQuery.Eof do
                  begin
                    cdsProd.Append;
                    cdsProd.FieldByName('ID_PRODUTO').AsInteger              := TFirebirdC.FQuery.FieldByName('ID_PRODUTO').AsInteger;
                    cdsProd.FieldByName('GTIN').AsString                     := TFirebirdC.FQuery.FieldByName('GTIN').AsString;
                    cdsProd.FieldByName('BARRAS').AsString                   := TFirebirdC.FQuery.FieldByName('BARRAS').AsString;
                    cdsProd.FieldByName('BARRAS_CX').AsString                := TFirebirdC.FQuery.FieldByName('BARRAS_CX').AsString;
                    cdsProd.FieldByName('PRODUTO').AsString                  := TFirebirdC.FQuery.FieldByName('PRODUTO').AsString;
                    cdsProd.FieldByName('DESCRICAO_COMPRA').AsString         := TFirebirdC.FQuery.FieldByName('DESCRICAO_COMPRA').AsString;
                    cdsProd.FieldByName('DESCRICAO_COMPLEMENTAR').AsString   := TFirebirdC.FQuery.FieldByName('DESCRICAO_COMPLEMENTAR').AsString;
                    cdsProd.FieldByName('CODIGO_BALANCA').AsInteger          := TFirebirdC.FQuery.FieldByName('CODIGO_BALANCA').AsInteger;
                    cdsProd.FieldByName('REFERENCIA').AsString               := TFirebirdC.FQuery.FieldByName('REFERENCIA').AsString;
                    cdsProd.FieldByName('ESTOQUE').AsString                  := TFirebirdC.FQuery.FieldByName('ESTOQUE').AsString;

                    TFirebirdC.FQuery.Next;
                  end;

                  Result := TFirebirdC.FQuery;
              end;
          end
        else
          begin
            ShowMessage('Falha na transferencia.');
            Exit;
          end;
      except
        on Error: Exception do
          begin
            ShowMessage('ERROR: '+Error.Message);
            Result.Free;
            raise;
          end;

      end;

    finally
      //FBConexaoDestino.InsereProdutos(Tabela);
      ShowMessage('Aqui Insere Produtos');
    end;
  end;

end.
