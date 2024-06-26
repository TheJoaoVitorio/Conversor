unit uCDSProdutos;

interface

uses
  Datasnap.DBClient, Data.DB, System.SysUtils, FireDAC.Comp.Client,Vcl.Dialogs,

  uConexaoFirebird.Teste , uFirebirdController.Teste,

  uConexaoFirebird.Teste.DESTINO, uFirebirdController.Teste.DESTINO,
  Vcl.ComCtrls

  ;

type
  TCDSProdutos = class { FIREBIRD }
    private
      TFirebirdC   : TConexaoFirebird;{Con - Origem}
      TFController : TFirebirdTesteController;{Controller - Origem}

      TFBConDestino       : TConexaoFirebirdDes;
      TFControllerDestino : TFirebirdTesteDestinoController;

      cdsProd    : TClientDataSet;
      cdsDestino : TClientDataSet;

      FBQuery    : TFDQuery;


    public
      constructor Create;
      destructor Destroy; override;

      function CreateCDS(CDS : TClientDataSet) : TClientDataSet;

      function PovoaCds(TabelaOrigem, TabelaDestino: String; ProgressBar: TProgressBar) : TFDQuery;
      function InsereProdutos(TabelaDestino: String; ProgressBar: TProgressBar) : TFDQuery;

      //property iCDSProd : TClientDataSet read cdsProd write cdsProd;
  end;

implementation

{ TCDSProdutos }

constructor TCDSProdutos.Create;
  begin
    inherited Create;
    TFirebirdC    := TConexaoFirebird.Create; {Conexao Origem - FB}
    TFController  := TFirebirdTesteController.Create; {Controller - FB}

    TFBConDestino       := TConexaoFirebirdDes.Create;
    TFControllerDestino := TFirebirdTesteDestinoController.Create;

    FBQuery := TFDQuery.Create(nil);

    //CriarCDS();
  end;

destructor TCDSProdutos.Destroy;
  begin
    //FreeAndNil(iCDSProd);

    FreeAndNil(TFirebirdC);
    FreeAndNil(TFController);

    FreeAndNil(TFBConDestino);
    FreeAndNil(TFControllerDestino);

    FreeAndNil(FBQuery);

    FreeAndNil(cdsProd);
    inherited;
  end;

function TCDSProdutos.CreateCDS(CDS: TClientDataSet): TClientDataSet;
  begin
    CDS := TCLientDataSet.Create(nil);

      with CDS do
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
          FieldDefs.Add('ESTOQUE', ftFloat);

        end;

      CDS.CreateDataSet;
      CDS.Open;

      Result := CDS;
  end;

function TCDSProdutos.PovoaCDS(TabelaOrigem, TabelaDestino: String; ProgressBar: TProgressBar): TFDQuery;
begin
  try
    try
      if TabelaOrigem = 'PRODUTOS' then
        begin
          cdsProd := CreateCDS(cdsProd); // Aqui eu alimento o cds
          if cdsProd.IsEmpty then
            cdsProd.EmptyDataSet;

          with TFirebirdC.FQuery do
            begin
              Close;
              Connection := TFController.GetController.AcessarConexaoFB.GetConexaoFirebird; // Conexao origem
              SQL.Text := 'SELECT * FROM ' + TabelaOrigem;
              Open;

              while not TFirebirdC.FQuery.Eof do
                begin
                  cdsProd.Append;
                  cdsProd.FieldByName('ID_PRODUTO').AsInteger            := TFirebirdC.FQuery.FieldByName('ID_PRODUTO').AsInteger;
                  cdsProd.FieldByName('GTIN').AsString                   := TFirebirdC.FQuery.FieldByName('GTIN').AsString;
                  cdsProd.FieldByName('BARRAS').AsString                 := TFirebirdC.FQuery.FieldByName('BARRAS').AsString;
                  cdsProd.FieldByName('BARRAS_CX').AsString              := TFirebirdC.FQuery.FieldByName('BARRAS_CX').AsString;
                  cdsProd.FieldByName('PRODUTO').AsString                := TFirebirdC.FQuery.FieldByName('PRODUTO').AsString;
                  cdsProd.FieldByName('DESCRICAO_COMPRA').AsString       := TFirebirdC.FQuery.FieldByName('DESCRICAO_COMPRA').AsString;
                  cdsProd.FieldByName('DESCRICAO_COMPLEMENTAR').AsString := TFirebirdC.FQuery.FieldByName('DESCRICAO_COMPLEMENTAR').AsString;
                  cdsProd.FieldByName('CODIGO_BALANCA').AsInteger        := TFirebirdC.FQuery.FieldByName('CODIGO_BALANCA').AsInteger;
                  cdsProd.FieldByName('REFERENCIA').AsString             := TFirebirdC.FQuery.FieldByName('REFERENCIA').AsString;
                  cdsProd.FieldByName('ESTOQUE').AsFloat                 := TFirebirdC.FQuery.FieldByName('ESTOQUE').AsFloat;

                  TFirebirdC.FQuery.Next;
                end;

              Result := TFirebirdC.FQuery;
            end;
        end
      else
      begin
        ShowMessage('Falha na transfer�ncia.');
        Exit;
      end;
    except
      on Error: Exception do
      begin
        ShowMessage('ERROR: ' + Error.Message);
        Result.Free;
        raise;
      end;
    end;
  finally
    // Aqui eu chamo a fun��o para inserir os produtos
    InsereProdutos(TabelaDestino, ProgressBar);
    ProgressBar.Visible := False;
    ShowMessage('Migra��o feita com sucesso! ');
  end;
end;

{
function TCDSProdutos.PovoaCDS(TabelaOrigem , TabelaDestino : String) : TFDQuery;
  begin
    try
      try
        if TabelaOrigem = 'PRODUTOS' then
          begin
            cdsProd := CreateCDS(cdsProd);
            if cdsProd.IsEmpty then
              cdsProd.EmptyDataSet;

            with TFirebirdC.FQuery do
              begin
                Close;
                Connection := TFController.GetController.AcessarConexaoFB.GetConexaoFirebird;
                SQL.Text   := 'SELECT * FROM ' + TabelaOrigem;
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
                    cdsProd.FieldByName('ESTOQUE').AsFloat                   := TFirebirdC.FQuery.FieldByName('ESTOQUE').AsFloat;

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
      //aqui eu chamo a funcao para Inserir os produtos
      InsereProdutos(TabelaDestino, ProgressBar);
      ShowMessage('Aqui Insere Produtos');
    end;
  end;
}

{
function TCDSProdutos.InsereProdutos(TabelaDestino: String): TFDQuery;
  var
    RegistroAtual : Integer;
  begin
    RegistroAtual := 1;

    cdsProd.First;
    FBQuery.Close;
    FBQuery.Connection := TFControllerDestino.GetController.AcessarConexao.GetConexaoFBDestino;

    if cdsProd.RecordCount >= RegistroAtual then
      while not cdsProd.Eof do
        begin
          with FBQuery do
            begin
              SQL.Text := 'INSERT INTO ' + TabelaDestino + '(ID_PRODUTO, GTIN, BARRAS, BARRAS_CX, PRODUTO, DESCRICAO_COMPRA,DESCRICAO_COMPLEMENTAR, CODIGO_BALANCA, REFERENCIA, ESTOQUE) '+
                          'VALUES (:ID_PRODUTO, :GTIN, :BARRAS, :BARRAS_CX, :PRODUTO, :DESCRICAO_COMPRA,:DESCRICAO_COMPLEMENTAR, :CODIGO_BALANCA, :REFERENCIA, :ESTOQUE)';

              ParamByName('ID_PRODUTO').AsInteger            := cdsProd.FieldByName('ID_PRODUTO').AsInteger;
              ParamByName('GTIN').AsString                   := cdsProd.FieldByName('GTIN').AsString;
              ParamByName('BARRAS').AsString                 := cdsProd.FieldByName('BARRAS').AsString;
              ParamByName('BARRAS_CX').AsString              := cdsProd.FieldByName('BARRAS_CX').AsString;
              ParamByName('PRODUTO').AsString                := cdsProd.FieldByName('PRODUTO').AsString;
              ParamByName('DESCRICAO_COMPRA').AsString       := cdsProd.FieldByName('DESCRICAO_COMPRA').AsString;
              ParamByName('DESCRICAO_COMPLEMENTAR').AsString := cdsProd.FieldByName('DESCRICAO_COMPLEMENTAR').AsString;
              ParamByName('CODIGO_BALANCA').AsInteger        := cdsProd.FieldByName('CODIGO_BALANCA').AsInteger;
              ParamByName('REFERENCIA').AsString             := cdsProd.FieldByName('REFERENCIA').AsString;
              ParamByName('ESTOQUE').AsFloat                := cdsProd.FieldByName('ESTOQUE').AsFloat;
              ExecSQL;

              registroAtual := registroAtual + 1;
              cdsProd.Next;
            end;
        end;
  end;
}

function TCDSProdutos.InsereProdutos(TabelaDestino: String; ProgressBar: TProgressBar): TFDQuery;
var
  RegistroAtual: Integer;
  TotalRegistros: Integer;
begin
  RegistroAtual := 1;

  cdsProd.First;
  TotalRegistros := cdsProd.RecordCount; // Obter o total de registros
  FBQuery.Close;
  FBQuery.Connection := TFControllerDestino.GetController.AcessarConexao.GetConexaoFBDestino;

  ProgressBar.Min := 0;
  ProgressBar.Max := TotalRegistros;
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;

  if TotalRegistros >= RegistroAtual then
    begin
      while not cdsProd.Eof do
        begin
          with FBQuery do
            begin
              SQL.Text := 'INSERT INTO ' + TabelaDestino + ' (ID_PRODUTO, GTIN, BARRAS, BARRAS_CX, PRODUTO, DESCRICAO_COMPRA, DESCRICAO_COMPLEMENTAR, CODIGO_BALANCA, REFERENCIA, ESTOQUE) ' +
                          'VALUES (:ID_PRODUTO, :GTIN, :BARRAS, :BARRAS_CX, :PRODUTO, :DESCRICAO_COMPRA, :DESCRICAO_COMPLEMENTAR, :CODIGO_BALANCA, :REFERENCIA, :ESTOQUE)';

              ParamByName('ID_PRODUTO').AsInteger            := cdsProd.FieldByName('ID_PRODUTO').AsInteger;
              ParamByName('GTIN').AsString                   := cdsProd.FieldByName('GTIN').AsString;
              ParamByName('BARRAS').AsString                 := cdsProd.FieldByName('BARRAS').AsString;
              ParamByName('BARRAS_CX').AsString              := cdsProd.FieldByName('BARRAS_CX').AsString;
              ParamByName('PRODUTO').AsString                := cdsProd.FieldByName('PRODUTO').AsString;
              ParamByName('DESCRICAO_COMPRA').AsString       := cdsProd.FieldByName('DESCRICAO_COMPRA').AsString;
              ParamByName('DESCRICAO_COMPLEMENTAR').AsString := cdsProd.FieldByName('DESCRICAO_COMPLEMENTAR').AsString;
              ParamByName('CODIGO_BALANCA').AsInteger        := cdsProd.FieldByName('CODIGO_BALANCA').AsInteger;
              ParamByName('REFERENCIA').AsString             := cdsProd.FieldByName('REFERENCIA').AsString;
              ParamByName('ESTOQUE').AsFloat                 := cdsProd.FieldByName('ESTOQUE').AsFloat;
              ExecSQL;

              RegistroAtual := RegistroAtual + 1;
              Sleep(2000)                 ;
              ProgressBar.Position := RegistroAtual; // Atualizar a barra de progresso
              cdsProd.Next;
            end;
        end;
    end;
end;

end.
