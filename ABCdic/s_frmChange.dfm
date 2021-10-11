object frmms: Tfrmms
  Left = 393
  Top = 471
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
  ClientHeight = 127
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlConf: TPanel
    Left = 0
    Top = 0
    Width = 256
    Height = 97
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    Visible = False
    object cbRun: TCheckBox
      Left = 6
      Top = 5
      Width = 200
      Height = 17
      Caption = #1042#1089#1087#1083#1099#1074#1072#1102#1097#1080#1081' '#1087#1077#1088#1077#1074#1086#1076' '#1074' Windows:'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      OnClick = cbRunClick
    end
    object cbAuto: TCheckBox
      Left = 6
      Top = 77
      Width = 200
      Height = 17
      Caption = #1040#1074#1090#1086#1079#1072#1075#1088#1091#1079#1082#1072' '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' Windows'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
    end
    object rb1: TRadioButton
      Left = 18
      Top = 23
      Width = 230
      Height = 17
      Caption = #1044#1074#1086#1081#1085#1099#1084' '#1097#1077#1083#1095#1082#1086#1084' '#1083#1077#1074#1086#1081' '#1082#1085#1086#1087#1082#1080' '#1084#1099#1096#1082#1080
      Checked = True
      Color = clBtnFace
      Enabled = False
      ParentColor = False
      TabOrder = 2
      TabStop = True
    end
    object rb2: TRadioButton
      Left = 18
      Top = 41
      Width = 175
      Height = 17
      Caption = 'Caps Lock + '#1076#1074#1086#1081#1085#1086#1081' '#1097#1077#1083#1095#1086#1082
      Color = clBtnFace
      Enabled = False
      ParentColor = False
      TabOrder = 3
    end
    object cbMs: TCheckBox
      Left = 6
      Top = 59
      Width = 227
      Height = 17
      Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076#1072#1090#1100', '#1077#1089#1083#1080' '#1089#1083#1086#1074#1086' '#1085#1077' '#1085#1072#1081#1076#1077#1085#1086
      Checked = True
      Color = clBtnFace
      ParentColor = False
      State = cbChecked
      TabOrder = 4
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 97
    Width = 256
    Height = 30
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    object sbAdd: TSpeedButton
      Left = 186
      Top = 5
      Width = 23
      Height = 22
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555205555555555555222055555555555522205555
        5555555222220555555555222222055555555722052220555555720555522055
        5555555555522205555555555555220555555555555552205555555555555572
        0555555555555557205555555555555552205555555555555555}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAddClick
    end
    object sbCans: TSpeedButton
      Left = 228
      Top = 5
      Width = 23
      Height = 22
      Hint = #1054#1090#1084#1077#1085#1072
      BiDiMode = bdRightToLeftReadingOnly
      Flat = True
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF2E57EA264CD32E57
        EA2E57EA2E57EA264CD31845F3264CD31845F3264CD3264CD3264CD30833CC18
        45F3FFFFFFFFFFFF0000FFFFFF3E62E53E62E53E62E53E62E55673E78BAFF7CF
        D7F7F0FBFFF8F8F8CFD7F78BAFF73E62E51845F31845F31845F30833CCFFFFFF
        0000FFFFFF3E62E53E62E55673E79999FFF0FBFFFFFBF7F1F1F1E2F2EEF1F1F1
        E4FEFEFAFBFAF1F1F16C88EF1845F31845F31845F3FFFFFF0000FFFFFF3E62E5
        3E62E59999FFF8F8F8FFFBF798CDF56C88EF3E62E53E62E55673E798CDF5F8F8
        F8F8F8F86C88EF1845F30833CCFFFFFF0000FFFFFF3E62E56C88EFF8F8F8F3F4
        F46C88EF3E62E53E62E55673E73E62E52E57EA2E57EA6699FFF3F4F4F3F4F42E
        57EA1845F3FFFFFF0000FFFFFF5673E78BAFF7FCFDFD98CDF55673E73E62E556
        73E7F0FBFFF0FBFF2E57EA2E57EA2E57EA8BAFF7FFFBF78BAFF71845F3FFFFFF
        0000FFFFFF5673E7D4EAF3F0FBFF6666FF5673E75673E73E62E5F8F8F8FFFBF7
        2E57EA2E57EA2E57EA5673E7E4FEFECCCCFF264CD3FFFFFF0000FFFFFF5673E7
        FAFBFAEAEAEA5673E73E62E53E62E53E62E5FCFEFCF0FBFF3366CC2E57EA2E57
        EA264CD3D4EAF3E4FEFE1845F3FFFFFF0000FFFFFF5673E7FCFDFDEAEAEA3E62
        E55673E75673E73E62E5FCFEFCFAFBFA2E57EA2E57EA1845F31845F3EAEAEAF0
        FBFF264CD3FFFFFF0000FFFFFF6C88EFE2F2EEF8F8F86C88EF3E62E56666CC3E
        62E5FFFBF7FFFBF72E57EA3E62E5264CD35673E7F3F4F4CFD7F7264CD3FFFFFF
        0000FFFFFF6C88EF98CDF5FFFBF79999FF5673E73E62E53E62E5FFFBF7F8F8F8
        3E62E51845F32E57EA8BAFF7F8F8F88BAFF7264CD3FFFFFF0000FFFFFF6C88EF
        9999FFFFFBF7F3F4F46C88EF5673E73E62E53E62E53E62E52E57EA264CD36C88
        EFF0FBFFF0FBFF3E62E52E57EAFFFFFF0000FFFFFF6C88EF6C88EF9999FFFFFB
        F7F1F1F18BAFF76666FF3E62E53E62E55673E78BAFF7F3F4F4FFFFFF9999CC2E
        57EA264CD3FFFFFF0000FFFFFF9999CC6C88EF6C88EF98CDF5F0FBFFF0FBFFD4
        EAF3CFD7F7CFD7F7E2F2EEFFFBF7F3F4F46C88EF2E57EA264CD3264CD3FFFFFF
        0000FFFFFF8BAFF76C88EF6C88EF5673E79999CCCCCCFFD4EAF3FEFFFEFFFFFF
        E4FEFE8BAFF76C88EF3E62E52E57EA3E62E5264CD3FFFFFF0000FFFFFFFFFFFF
        8BAFF76C88EF6C88EF6C88EF6C88EF6C88EF5673E75673E75673E75673E75673
        E75673E73E62E52E57EAFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000}
      Layout = blGlyphRight
      ParentShowHint = False
      ParentBiDiMode = False
      ShowHint = True
      OnClick = sbCansClick
    end
  end
  object PnlEdit: TPanel
    Left = 0
    Top = 0
    Width = 256
    Height = 97
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object Label5: TLabel
      Left = 5
      Top = 5
      Width = 41
      Height = 13
      Caption = #1057#1083#1086#1074#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 30
      Width = 56
      Height = 13
      Caption = #1055#1077#1088#1077#1074#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbmes: TLabel
      Left = 5
      Top = 5
      Width = 51
      Height = 13
      Caption = 'Message'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 80
      Top = 5
      Width = 172
      Height = 21
      Color = clSkyBlue
      MaxLength = 20
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
    object Memo1: TMemo
      Left = 80
      Top = 28
      Width = 172
      Height = 66
      Color = clSkyBlue
      MaxLength = 100
      TabOrder = 1
      OnKeyDown = FormKeyDown
    end
  end
end
