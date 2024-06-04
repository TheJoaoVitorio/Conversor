unit uPrincipalView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Imaging.pngimage,Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids ,

  uOrigemDatabaseController, uMySQLController.Teste , uFirebirdController.Teste;

type
  TfrmPrincipal = class(TForm)
    pnlMain: TPanel;
    pnlNavLateral: TPanel;
    pnlNavHeader: TPanel;
    Image1: TImage;
    pnlNavSair: TPanel;
    imgSair: TImage;
    lblNavSair: TLabel;
    pnlContainerMain: TPanel;
    pnlHeader: TPanel;
    lblTextHeader: TLabel;
    pnlContent: TPanel;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Image2: TImage;
    procedure imgSairClick(Sender: TObject);
    procedure lblNavSairClick(Sender: TObject);
  private

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.imgSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;

procedure TfrmPrincipal.lblNavSairClick(Sender: TObject);
  begin
    Application.Terminate;
  end;

end.
