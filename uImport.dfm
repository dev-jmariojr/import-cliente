object fDesafio: TfDesafio
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Teste Importa'#231#227'o de Arquivo - Suportware'
  ClientHeight = 503
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object pgControl: TPageControl
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 873
    Height = 465
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    ActivePage = tabConsulta
    TabOrder = 0
    object tabImportacao: TTabSheet
      Caption = 'Importa'#231#227'o'
      object edArquivo: TLabeledEdit
        Left = 126
        Top = 25
        Width = 594
        Height = 23
        EditLabel.Width = 42
        EditLabel.Height = 23
        EditLabel.Caption = 'Arquivo'
        LabelPosition = lpLeft
        TabOrder = 0
        Text = ''
      end
      object btnImport: TButton
        Left = 737
        Top = 24
        Width = 125
        Height = 25
        Caption = 'Importar arquivo'
        TabOrder = 1
        OnClick = btnImportClick
      end
      object dbGridImport: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 54
        Width = 859
        Height = 378
        Align = alBottom
        BorderStyle = bsNone
        DataSource = dmDatabase.dsImport
        ParentColor = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
    object tabCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Bevel5: TBevel
        Left = 170
        Top = 180
        Width = 508
        Height = 9
        Shape = bsTopLine
      end
      object edNome: TLabeledEdit
        Left = 261
        Top = 67
        Width = 417
        Height = 23
        EditLabel.Width = 33
        EditLabel.Height = 23
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 0
        Text = ''
      end
      object edCPF: TLabeledEdit
        Left = 261
        Top = 92
        Width = 153
        Height = 23
        EditLabel.Width = 21
        EditLabel.Height = 23
        EditLabel.Caption = 'CPF'
        LabelPosition = lpLeft
        TabOrder = 1
        Text = ''
      end
      object edRG: TLabeledEdit
        Left = 261
        Top = 117
        Width = 153
        Height = 23
        EditLabel.Width = 15
        EditLabel.Height = 23
        EditLabel.Caption = 'RG'
        LabelPosition = lpLeft
        TabOrder = 2
        Text = ''
      end
      object edNascimento: TLabeledEdit
        Left = 261
        Top = 142
        Width = 153
        Height = 23
        Alignment = taCenter
        EditLabel.Width = 64
        EditLabel.Height = 23
        EditLabel.Caption = 'Nascimento'
        EditMask = '!99/99/0000;1;_'
        LabelPosition = lpLeft
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
      end
      object edEndereco: TLabeledEdit
        Left = 261
        Top = 196
        Width = 417
        Height = 23
        EditLabel.Width = 49
        EditLabel.Height = 23
        EditLabel.Caption = 'Endere'#231'o'
        LabelPosition = lpLeft
        TabOrder = 4
        Text = ''
      end
      object edCidade: TLabeledEdit
        Left = 261
        Top = 221
        Width = 306
        Height = 23
        EditLabel.Width = 37
        EditLabel.Height = 23
        EditLabel.Caption = 'Cidade'
        LabelPosition = lpLeft
        TabOrder = 5
        Text = ''
      end
      object edUF: TLabeledEdit
        Left = 637
        Top = 221
        Width = 41
        Height = 23
        Alignment = taCenter
        CharCase = ecUpperCase
        EditLabel.Width = 14
        EditLabel.Height = 23
        EditLabel.Caption = 'UF'
        LabelPosition = lpLeft
        MaxLength = 2
        TabOrder = 6
        Text = ''
      end
      object edTelefone: TLabeledEdit
        Left = 261
        Top = 246
        Width = 149
        Height = 23
        Alignment = taCenter
        EditLabel.Width = 45
        EditLabel.Height = 23
        EditLabel.Caption = 'Telefone'
        LabelPosition = lpLeft
        TabOrder = 7
        Text = ''
      end
      object edID: TLabeledEdit
        Left = 528
        Top = 117
        Width = 39
        Height = 23
        Alignment = taCenter
        CharCase = ecUpperCase
        EditLabel.Width = 11
        EditLabel.Height = 23
        EditLabel.Caption = 'ID'
        LabelPosition = lpLeft
        MaxLength = 2
        TabOrder = 8
        Text = ''
        Visible = False
      end
      object btnExcluir: TButton
        Left = 351
        Top = 360
        Width = 105
        Height = 25
        Caption = 'Excluir'
        TabOrder = 9
        OnClick = btnExcluirClick
      end
      object btnCancel: TButton
        Left = 462
        Top = 360
        Width = 105
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 10
        OnClick = btnCancelClick
      end
      object btnSave: TButton
        Left = 573
        Top = 360
        Width = 105
        Height = 25
        Caption = 'Salvar'
        TabOrder = 11
        OnClick = btnSaveClick
      end
    end
    object tabConsulta: TTabSheet
      Caption = 'Consulta'
      ImageIndex = 2
      OnShow = tabConsultaShow
      object btnSearch: TButton
        Left = 734
        Top = 24
        Width = 125
        Height = 25
        Caption = 'Pesquisar'
        TabOrder = 0
        OnClick = btnSearchClick
      end
      object edSearch: TLabeledEdit
        Left = 131
        Top = 25
        Width = 594
        Height = 23
        EditLabel.Width = 101
        EditLabel.Height = 23
        EditLabel.Caption = 'Pesquisa por nome'
        LabelPosition = lpLeft
        TabOrder = 1
        Text = ''
      end
      object dbGridSearch: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 54
        Width = 859
        Height = 378
        Align = alBottom
        BorderStyle = bsNone
        DataSource = dmDatabase.dsSearch
        ParentColor = True
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = dbGridSearchDblClick
      end
    end
  end
  object btnFechar: TButton
    Left = 741
    Top = 471
    Width = 125
    Height = 25
    Caption = 'Fechar'
    TabOrder = 1
    OnClick = btnFecharClick
  end
end
