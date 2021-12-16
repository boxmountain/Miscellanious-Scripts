Attribute VB_Name = "Module1"
Sub Fetch(EP_File)
    Dim Path As String
    Dim intFileNum%, bytTemp As Single, intCellRow%
    Path = EP_File
    intFileNum = FreeFile
    intCellRow = 0
    Open EP_File For Binary Access Read As intFileNum
    Do While Not EOF(intFileNum)
        intCellRow = intCellRow + 1
        Get intFileNum, , bytTemp
        Cells(intCellRow, 2) = bytTemp
    Loop
    Close intFileNum

    Range("B2052:B4102").Select
    Selection.Cut
    Range("C1").Select
    ActiveSheet.Paste

    Range("B4103:B6153").Select
    Selection.Cut
    Range("D1").Select
    ActiveSheet.Paste

    Range("B6154:B8204").Select
    Selection.Cut
    Range("E1").Select
    ActiveSheet.Paste

    Range("B8205:B10255").Select
    Selection.Cut
    Range("F1").Select
    ActiveSheet.Paste

    Range("B10256:B12306").Select
    Selection.Cut
    Range("G1").Select
    ActiveSheet.Paste

    Range("B12307:B14357").Select
    Selection.Cut
    Range("H1").Select
    ActiveSheet.Paste

    Range("B14358:B16408").Select
    Selection.Cut
    Range("I1").Select
    ActiveSheet.Paste

    Range("B16409:B18459").Select
    Selection.Cut
    Range("J1").Select
    ActiveSheet.Paste

    Range("B18460:B20510").Select
    Selection.Cut
    Range("K1").Select
    ActiveSheet.Paste

    Range("B1").Select
    Application.CutCopyMode = False

End Sub

Sub FULL_IMPORT()
'
' FULL_IMPORT Macro
' Full import of sample, dark spec, and ref spec data for analysis.
'

'
    Dim diaFolder As FileDialog

    Set diaFolder = Application.FileDialog(msoFileDialogFolderPicker)
    diaFolder.AllowMultiSelect = False
    diaFolder.Show

    Rel_Path = diaFolder.SelectedItems(1)

    Set diaFolder = Nothing

    Dim Sample_Name As String
    Dim Sample_Low As String
    Dim Sample_High As String
    Dim Dark_Low As String
    Dim Dark_High As String
    Dim Reference_Low As String
    Dim Reference_High As String

    Sample_Name = Sheets("Main Data Sheet").Range("B1").Value

    Sample_High = Rel_Path & "\Sample Spectra\" & Sample_Name & ".EP1"
    Sample_Low = Rel_Path & "\Sample Spectra\" & Sample_Name & ".EP2"

    Dark_High = Rel_Path & "\Dark Spectra\Dark.EP1"
    Dark_Low = Rel_Path & "\Dark Spectra\Dark.EP2"

    Reference_High = Rel_Path & "\Reference Spectra\Reference.EP1"
    Reference_Low = Rel_Path & "\Reference Spectra\Reference.EP2"

    Sheets("Sample.EP1").Select
    Range("B1").Select
    Fetch (Sample_High)

    Sheets("Sample.EP2").Select
    Range("B1").Select
    Fetch (Sample_Low)

    Sheets("Dark Spectra.EP1").Select
    Range("B1").Select
    Fetch (Dark_High)

    Sheets("Dark Spectra.EP2").Select
    Range("B1").Select
    Fetch (Dark_Low)

    Sheets("Reference Spectra.EP1").Select
    Range("B1").Select
    Fetch (Reference_High)

    Sheets("Reference Spectra.EP2").Select
    Range("B1").Select
    Fetch (Reference_Low)

    If Round(Worksheets("Sample.EP1").Range("B9").Value, 0) = 858 Then
        Sheets("Sample.EP1").Select
        Range("B12:K569").Select
        Selection.Copy
        Sheets("Main Data Sheet").Select
        Range("E1479").Select
        ActiveSheet.Paste

        Sheets("Dark Spectra.EP1").Select
        Range("B12:K569").Select
        Selection.Copy
        Sheets("Dark Spectra").Select
        Range("C1479").Select
        ActiveSheet.Paste

        Sheets("Reference Spectra.EP1").Select
        Range("B12:K569").Select
        Selection.Copy
        Sheets("Reference Spectra").Select
        Range("C1479").Select
        ActiveSheet.Paste

        Sheets("Sample.EP2").Select
        Range("B12:K1485").Select
        Selection.Copy
        Sheets("Main Data Sheet").Select
        Range("E5").Select
        ActiveSheet.Paste

        Sheets("Dark Spectra.EP2").Select
        Range("B12:K1485").Select
        Selection.Copy
        Sheets("Dark Spectra").Select
        Range("C5").Select
        ActiveSheet.Paste

        Sheets("Reference Spectra.EP2").Select
        Range("B12:K1485").Select
        Selection.Copy
        Sheets("Reference Spectra").Select
        Range("C5").Select
        ActiveSheet.Paste

        Sheets("Main Data Sheet").Range("B2").Value = "RWave = EP1"
        Sheets("Main Data Sheet").Range("C2").Value = "BComet = EP2"


    Else
        Sheets("Sample.EP2").Select
        Range("B12:K569").Select
        Selection.Copy
        Sheets("Main Data Sheet").Select
        Range("E1479").Select
        ActiveSheet.Paste

        Sheets("Dark Spectra.EP2").Select
        Range("B12:K569").Select
        Selection.Copy
        Sheets("Dark Spectra").Select
        Range("C1479").Select
        ActiveSheet.Paste

        Sheets("Reference Spectra.EP2").Select
        Range("B12:K569").Select
        Selection.Copy
        Sheets("Reference Spectra").Select
        Range("C1479").Select
        ActiveSheet.Paste

        Sheets("Sample.EP1").Select
        Range("B12:K1485").Select
        Selection.Copy
        Sheets("Main Data Sheet").Select
        Range("E5").Select
        ActiveSheet.Paste

        Sheets("Dark Spectra.EP1").Select
        Range("B12:K1485").Select
        Selection.Copy
        Sheets("Dark Spectra").Select
        Range("C5").Select
        ActiveSheet.Paste

        Sheets("Reference Spectra.EP1").Select
        Range("B12:K1485").Select
        Selection.Copy
        Sheets("Reference Spectra").Select
        Range("C5").Select
        ActiveSheet.Paste

        Sheets("Main Data Sheet").Range("B2").Value = "BComet = EP1"
        Sheets("Main Data Sheet").Range("C2").Value = "RWave = EP2"

    End If

    Sheets("Dark Spectra").Select
    Range("A1").Select
    Application.CutCopyMode = False

    Sheets("Reference Spectra").Select
    Range("A1").Select
    Application.CutCopyMode = False

    Sheets("Main Data Sheet").Select
    Range("A1").Select
    Application.CutCopyMode = False

End Sub

