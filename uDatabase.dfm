object dmDatabase: TdmDatabase
  Height = 327
  Width = 423
  object connection: TFDConnection
    Params.Strings = (
      'Database=C:\projetos\delphi\importacao\db\cliente.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 272
    Top = 56
  end
  object dsImport: TDataSource
    DataSet = qImport
    Left = 344
    Top = 144
  end
  object qImport: TFDQuery
    DetailFields = 'cidade;cpf;endereco;id;nascimento;nome;rg;telefone;uf'
    Connection = connection
    SQL.Strings = (
      'select*from cliente;')
    Left = 272
    Top = 144
  end
  object query: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select*from cliente;')
    Left = 352
    Top = 56
  end
  object qSearch: TFDQuery
    DetailFields = 'cidade;cpf;endereco;id;nascimento;nome;rg;telefone;uf'
    Connection = connection
    SQL.Strings = (
      'select*from cliente;')
    Left = 272
    Top = 224
  end
  object dsSearch: TDataSource
    DataSet = qSearch
    Left = 344
    Top = 224
  end
end
