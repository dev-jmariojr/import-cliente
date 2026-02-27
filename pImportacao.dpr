program pImportacao;

uses
  Vcl.Forms,
  uImport in 'uImport.pas' {fDesafio},
  uDatabase in 'uDatabase.pas' {dmDatabase: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfDesafio, fDesafio);
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.Run;
end.
