unit uImport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TCliente = record
    nome: String;
    cpf: String;
    rg: String;
    nascimento: string;
    endereco: String;
    cidade: String;
    uf: String;
    telefone:String;
  end;

type
  TfDesafio = class(TForm)
    pgControl: TPageControl;
    tabImportacao: TTabSheet;
    tabCadastro: TTabSheet;
    tabConsulta: TTabSheet;
    edArquivo: TLabeledEdit;
    btnImport: TButton;
    dbGridImport: TDBGrid;
    edNome: TLabeledEdit;
    edCPF: TLabeledEdit;
    edRG: TLabeledEdit;
    edNascimento: TLabeledEdit;
    edEndereco: TLabeledEdit;
    edCidade: TLabeledEdit;
    edUF: TLabeledEdit;
    edTelefone: TLabeledEdit;
    edID: TLabeledEdit;
    Bevel5: TBevel;
    btnExcluir: TButton;
    btnCancel: TButton;
    btnSave: TButton;
    btnFechar: TButton;
    btnSearch: TButton;
    edSearch: TLabeledEdit;
    dbGridSearch: TDBGrid;
    procedure btnImportClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure dbGridSearchDblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure tabConsultaShow(Sender: TObject);
  private
    { Private declarations }
    procedure doImport;
    procedure doSearch;
    procedure doRemover;
    procedure doLoad;
    procedure doClear;
    procedure doSave;
    procedure doEdit;
    function doInsert(ID: Integer; item: TCliente):Boolean;
    function validarCampos: Boolean;
    var path: String;
  public
    { Public declarations }
  end;

var fDesafio: TfDesafio;

implementation
  uses uDatabase;

{$R *.dfm}

procedure TfDesafio.btnCancelClick(Sender: TObject);
var
  ID: String;
begin
  ID := edID.Text;
  doClear;
  if(ID.IsEmpty = False) then
    ShowMessage('Edição cancelada.');
end;

procedure TfDesafio.btnExcluirClick(Sender: TObject);
begin
  doRemover();
end;

procedure TfDesafio.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfDesafio.btnImportClick(Sender: TObject);
begin
  doImport();
end;

procedure TfDesafio.btnSaveClick(Sender: TObject);
begin
  doSave;
end;

procedure TfDesafio.btnSearchClick(Sender: TObject);
begin
  doSearch;
end;

procedure TfDesafio.dbGridSearchDblClick(Sender: TObject);
begin
  doEdit;
end;

procedure TfDesafio.doClear();
begin
  edID.Clear;
  edNome.Clear;
  edCPF.Clear;
  edRG.Clear;
  edNascimento.Clear;
  edEndereco.Clear;
  edCidade.Clear;
  edUF.Clear;
  edTelefone.Clear;
  btnExcluir.Enabled := false;
end;

procedure TfDesafio.doEdit;
var
  sfone: String;
begin
  if not dmDatabase.qSearch.IsEmpty then
  begin
    with dbGridSearch.DataSource.DataSet do
    begin
      edID.Text         := FieldByName('ID').AsString;
      edNome.Text       := FieldByName('nome').AsString;
      edCPF.Text        := FieldByName('cpf').AsString;
      edRG.Text         := FieldByName('rg').AsString;
      edNascimento.Text := FieldByName('nascimento').AsString;
      edEndereco.Text   := FieldByName('endereco').AsString;
      edCidade.Text     := FieldByName('cidade').AsString;
      edUF.Text         := FieldByName('uf').AsString;


      edTelefone.clear;
      sfone := FieldByName('telefone').AsString;
      edTelefone.Text   := sfone;

      btnExcluir.Enabled := true;
      pgControl.ActivePageIndex := 1;
    end;
  end;

end;

procedure TfDesafio.doImport;
var
  arquivoPath: String;
  Lista : TStringList;
  I: integer;
  item: TArray<string>;

  cliente: TCliente;

  function convertFormatDate(sdata: String): String;
  var
    Ano, Mes, Dia: Word;
    Resultado: string;
  begin
    Ano := StrToInt(Copy(sdata, 1, 4));
    Mes := StrToInt(Copy(sdata, 6, 2));
    Dia := StrToInt(Copy(sdata, 9, 2));


    Result := FormatDateTime('dd/mm/yyyy', EncodeDate(Ano, Mes, Dia));
  end;

begin
  if (dmDatabase.connection.Connected = False) then
    dmDatabase.connection.Connected := True;

  dmDatabase.qImport.Close;

  arquivoPath := edArquivo.Text;

  if (arquivoPath.IsEmpty or not FileExists(arquivoPath)) then
  begin
    ShowMessage('Informe um arquivo válido.');
    exit;
  end;

  Lista := TStringList.Create;
  try
    Lista.LoadFromFile(arquivoPath, TEncoding.UTF8);
    for I := 0 to Lista.Count - 1 do
    begin
      item := Lista[I].Split([';']);

      cliente.nome      := item[0];
      cliente.cpf       := item[1];
      cliente.rg        := item[2];

      cliente.nascimento:= convertFormatDate(item[3]);

      cliente.endereco  := item[4];
      cliente.cidade    := item[5];
      cliente.uf        := item[6];
      cliente.telefone  := item[7];

      doInsert(0, cliente);
    end;
    doShow;
    ShowMessage('Importação finalizada.' + #13#10 + IntToStr(Lista.Count)+ ' registro(s) importado(s).');
    btnImport.Enabled := false;
    doLoad;
  except
    ShowMessage('Erro durante importação.');
  end;
  Lista.Free;
end;

function TfDesafio.doInsert(ID: Integer; item: TCliente): Boolean;

  function onlyNumber(value: String): String;
  begin
    Result := '';
    for var C in value do
    begin
      if CharInSet(C, ['0'..'9']) then
        Result := Result + C;
    end;
  end;

begin
  with dmDatabase.query do
  begin
    Close;
    SQL.Clear;

    if(ID = 0) then
    begin
      SQL.Add('INSERT INTO cliente ');
      SQL.Add('(nome, cpf, rg, nascimento, endereco, cidade, uf, telefone)');
      SQL.Add('VALUES (:nome, :cpf, :rg, :nascimento, :endereco, :cidade, :uf, :telefone)');
    end
    else
    begin
      SQL.Add('UPDATE cliente SET ');
      SQL.Add(' nome = :nome, cpf= :cpf, rg= :rg, nascimento= :nascimento, endereco= :endereco, cidade =:cidade, uf= :uf, telefone= :telefone');
      SQL.Add('where ID= :id ');
      ParamByName('id').AsInteger := ID;
    end;

    ParamByName('nome').AsString       := item.nome;
    ParamByName('cpf').AsString        := onlyNumber(item.cpf);
    ParamByName('rg').AsString         := onlyNumber(item.rg);
    ParamByName('nascimento').AsString := item.nascimento;
    ParamByName('endereco').AsString   := item.endereco;
    ParamByName('cidade').AsString     := item.cidade;
    ParamByName('uf').AsString         := item.uf;
    ParamByName('telefone').AsString   := onlyNumber(item.telefone);

    ExecSQL;
  end;

  Result := True;
end;

procedure TfDesafio.doSave();
var
  ID: Integer;
  item: TCliente;
begin
  if(validarCampos = False) then
    exit;

  ID := 0;
  item.nome       := edNome.Text;
  item.cpf        := edCPF.Text;
  item.rg         := edRG.Text;
  item.nascimento := edNascimento.Text;
  item.endereco   := edEndereco.Text;
  item.cidade     := edCidade.Text;
  item.uf         := edUF.Text;
  item.telefone   := edTelefone.Text;

  if(edID.Text <> '') then
    ID := StrToInt(edID.Text);

  if(doInsert(ID, item)) then
  begin

    if(ID > 0) then
      ShowMessage('Cliente atualizado')
    else
      ShowMessage('Cliente adicionado');

    doClear;
    doLoad;
    pgControl.TabIndex := 0;

  end;
end;

procedure TfDesafio.doSearch;
var
  snome: String;
begin
  snome := edSearch.Text;
  with dmDatabase.qSearch do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select*from cliente ');

    if (not snome.IsEmpty) then
    begin
      SQL.Add('where nome like :nome');
      ParamByName('nome').AsString := '%'+snome+'%';
    end;

    Open;
    if(RecordCount = 0) then
      ShowMessage('Nenhum cliente encontrado.')
  end;
end;

procedure TfDesafio.doLoad;
begin
  dmDatabase.qImport.Close;
  dmDatabase.qImport.Open('select*from cliente');
end;

procedure TfDesafio.doRemover;
var
  id: Integer;
begin
  if not dmDatabase.qSearch.IsEmpty then
  begin
    with dbGridSearch.DataSource.DataSet do
    begin
      id := FieldByName('ID').AsInteger;
    end;

    if(id>0) then
    begin
      with dmDatabase.query do
      begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM cliente ');
        SQL.Add('where ID= :id ');
        ParamByName('id').AsInteger := id;
        ExecSQL;
      end;
      doClear;
      ShowMessage('Cliente removido!');
    end;
  end;
end;

procedure TfDesafio.FormActivate(Sender: TObject);
begin
  pgControl.ActivePageIndex := 0;
  path := ExtractFilePath(ParamStr(0));
  edArquivo.Text := path;

  doClear;

  edArquivo.Text := 'C:\projetos\delphi\importacao\cliente.txt';

  dmDatabase.connection.Connected := True;
  dmDatabase.query.ExecSQL('delete from cliente where 1>0;');
end;

procedure TfDesafio.tabConsultaShow(Sender: TObject);
begin
  edSearch.Clear;
  dmDatabase.qSearch.Close;
  edSearch.SetFocus;
end;

function TfDesafio.validarCampos: Boolean;

  function montarResposta(nomeCampo: String): Boolean;
  begin
     ShowMessage('Infome um valor para ' + nomeCampo);
     Result := False;
  end;

begin
  if(edNome.Text = '') then
    Result := montarResposta('Nome')
  else if(edCPF.Text = '') then
    Result := montarResposta('CPF')
  else if(edRG.Text = '') then
    Result := montarResposta('RG')
  else
    Result := True;
end;

end.
