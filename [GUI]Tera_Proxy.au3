#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=syringe_pJV_icon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Description=[GUI]Tera Proxy
#AutoIt3Wrapper_Res_Fileversion=2.0.0.3
#AutoIt3Wrapper_Res_ProductVersion=2.0.0.3
#AutoIt3Wrapper_Res_LegalCopyright=Fukki
#AutoIt3Wrapper_Res_Field=CompanyName|Fukki
#AutoIt3Wrapper_Res_Field=ProductVersion|2.0.0.3
#AutoIt3Wrapper_Res_Field=ProductName|[GUI]Tera Proxy
#AutoIt3Wrapper_Res_Field=Publisher|[GUI]Tera Proxy
#AutoIt3Wrapper_Res_Field=LegalTrademarks|Fukki
#AutoIt3Wrapper_Res_Field=InternalName|[GUI]Tera Proxy
#AutoIt3Wrapper_Res_Field=OriginalFilename|[GUI]Tera Proxy
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)
#include <ListViewConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <UDFGlobalID.au3>
#include <Constants.au3>
#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <WinAPI.au3>
#include <array.au3>
#include <StructureConstants.au3>
#include <TrayConstants.au3>
#include <GuiMenu.au3>
#include 'MetroUDF-v5.1\MetroGUI-UDF\MetroGUI_UDF.au3'
#include 'MetroUDF-v5.1\MetroGUI-UDF\_GUIDisable.au3'
#include 'MetroUDF-v5.1\MetroGUI-UDF\MetroCustom.au3'
#include '_Startup.au3'
_SetTheme("DarkTeal")
_GUICtrlListView_Init_Optim()
Global $FORM[10] = ['[GUI]Tera Proxy'], $FORM2[17], $FORM3[8], $FORM4[8], $TRAY[7]
Global $iPID = 0, $gPID = 0, $iLineSize = 0, $sLine = '', $_isStarted = False, $Module
Global Const $sTemp = @TempDir & '\[GUI]Tera_Proxy'
Global Const $_ConfigFile = @ScriptDir & '\bin\Proxy_GUI.ini'
Global Const $_Config_Region = @ScriptDir & '\bin\config.json'
Global Const $_Module = @ScriptDir & '\bin\node_modules'
If _CheckPID(True) Then
	If _Metro_MsgBox(4, $FORM[0], 'Another ' & $FORM[0] & ' has now running...' & @CRLF & 'Do you want to run new ' & $FORM[0] & '?', 400, 11) <> 'Yes' Then Exit
	_ClosePID(True)
EndIf
$hOpen = FileOpen($_ConfigFile, 0)
If $hOpen < 0 Then _CreateINI()
FileClose($hOpen)
_CreateTRAY()
_CreateGUI()
_AutoRun()
Func _CreateTRAY()
	$TRAY[1] = TrayCreateItem("Start Proxy")
	$TRAY[2] = TrayCreateItem("Module")
	$TRAY[3] = TrayCreateItem("Setting")
	$TRAY[4] = TrayCreateItem("Fix GUI")
	$TRAY[5] = TrayCreateItem("About")
	$TRAY[6] = TrayCreateItem("Exit")
	TrayItemSetOnEvent($TRAY[1], "_RunProxy")
	TrayItemSetOnEvent($TRAY[2], "_Module_Open")
	TrayItemSetOnEvent($TRAY[3], "On_Click_Config")
	TrayItemSetOnEvent($TRAY[4], "_FixGUI")
	TrayItemSetOnEvent($TRAY[5], "_About")
	TrayItemSetOnEvent($TRAY[6], "_EXIT")
	TraySetOnEvent($TRAY_EVENT_PRIMARYDOWN, "On_Click")
EndFunc   ;==>_CreateTRAY
Func _CreateGUI()
	$FORM[1] = _Metro_CreateGUI($FORM[0], 1015, 668, -1, -1, False)
	$FORM[2] = _Metro_AddControlButtons(True, False, True, False, True)
	$FORM[3] = GUICtrlCreateListView("", 8, 62, 998, 596, $LVS_REPORT)
	$FORM[4] = _Metro_CreateButton("Print", 8, 38, 101, 21)
	$FORM[5] = _Metro_CreateButton("Clear", 116, 38, 101, 21)
	$FORM[6] = _Metro_CreateButton("Hosts", 224, 38, 101, 21)
	$FORM[7] = _Metro_CreateButton('Start Proxy', 805, 38, 201, 21)
	$FORM[8] = _Metro_CreateButton("Close Proxy", 597, 38, 201, 21)
	$FORM[9] = GUICtrlGetHandle($FORM[3])
	_GUICtrlListView_SetExtendedListViewStyle($FORM[9], BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_INFOTIP))
	_GUICtrlListView_AddColumn($FORM[9], 'Console', 698, 0)
	_GUICtrlListView_SetColumnWidth($FORM[9], 0, $LVSCW_AUTOSIZE_USEHEADER)
	ControlDisable($FORM[1], "", HWnd(_GUICtrlListView_GetHeader($FORM[3])))
	_Metro_SetGUIOption($FORM[1], True, False)
	_ControlEvent($FORM[2])
	_Metro_DisableButton($FORM[8])
	GUICtrlSetOnEvent($FORM[4], "_PrintConsole")
	GUICtrlSetOnEvent($FORM[5], "_ClearConsole")
	GUICtrlSetOnEvent($FORM[6], "_HostsFileOpen")
	GUICtrlSetOnEvent($FORM[7], "_RunProxy")
	GUICtrlSetOnEvent($FORM[8], "_RunProxy")
	GUISetOnEvent($GUI_EVENT_CLOSE, "_EXIT", $FORM[1])
	$FORM2[1] = _Metro_CreateGUI($FORM[0], 404, 323, -1, -1, False)
	$FORM2[2] = _Metro_CreateToggleEx("Auto start when windows startup", 8, 8, 300, 30)
	$FORM2[3] = _Metro_CreateToggleEx("Auto start Tera Proxy when program up", 8, 40, 343, 30)
	$FORM2[4] = _Metro_CreateToggleEx("Tray icon when minimize", 8, 72, 248, 30)
	$FORM2[5] = _GuiLabel("Run:", 8, 112, 38, 17)
	$FORM2[6] = GUICtrlCreateInput(IniRead($_ConfigFile, 'Config', 'Run', 'node bin/lib/proxy.js'), 50, 104, 345, 21)
	$FORM2[7] = _Metro_CreateToggleEx("Use custom application to run Tera Proxy", 8, 136, 353, 30)
	$FORM2[8] = _GuiLabel("Name:", 8, 176, 38, 17)
	$FORM2[9] = GUICtrlCreateInput(IniRead($_ConfigFile, 'Config', 'Custom_Application_Name', 'electron.exe'), 50, 168, 345, 21)
	$FORM2[10] = _GuiLabel("Regeion:", 8, 208, 55, 17)
	$FORM2[11] = GUICtrlCreateInput(_GetRegion(), 70, 200, 105, 21, 0x0001)
	$FORM2[12] = _Metro_CreateToggleEx("Auto clear console", 8, 232, 212, 30)
	$FORM2[13] = _GuiLabel("When:", 8, 272, 40, 17)
	$FORM2[14] = GUICtrlCreateInput(IniRead($_ConfigFile, 'Config', 'Auto_Clear_When', 1000), 70, 264, 105, 21, 0x0001)
	$FORM2[15] = _Metro_CreateButton("Save", 56, 296, 145, 21)
	$FORM2[16] = _Metro_CreateButton("Close", 208, 296, 145, 21)
	If _StartupRegistry_Exists() Then _Metro_ToggleCheck($FORM2[2])
	If IniRead($_ConfigFile, 'Config', 'Auto_Run', 0) > 0 Then _Metro_ToggleCheck($FORM2[3])
	If IniRead($_ConfigFile, 'Config', 'Minimize_Tray_Icon', 0) > 0 Then _Metro_ToggleCheck($FORM2[4])
	If IniRead($_ConfigFile, 'Config', 'Custom_Application_Use', 0) > 0 Then _Metro_ToggleCheck($FORM2[7])
	If IniRead($_ConfigFile, 'Config', 'Auto_Clear_Console', 0) > 0 Then _Metro_ToggleCheck($FORM2[12])
	GUICtrlSetOnEvent($FORM2[2], "_Config_AutoStartup")
	GUICtrlSetOnEvent($FORM2[3], "_Config_AutoRun")
	GUICtrlSetOnEvent($FORM2[4], "_Config_TrayIcon")
	GUICtrlSetOnEvent($FORM2[7], "_Config_UseElectron")
	GUICtrlSetOnEvent($FORM2[12], "_Config_ClearLine")
	GUICtrlSetOnEvent($FORM2[15], "_Config_Save")
	GUICtrlSetOnEvent($FORM2[16], "_Config_Close")
	_Metro_SetGUIOption($FORM2[1], True, False)
	$FORM3[1] = _Metro_CreateGUI($FORM[0], 615, 438, -1, -1, False)
	$FORM3[2] = GUICtrlCreateListView("", 8, 8, 601, 393)
	$FORM3[3] = _Metro_CreateButton("All Enable", 8, 408, 129, 21)
	$FORM3[4] = _Metro_CreateButton("All Disable", 144, 408, 129, 21)
	$FORM3[5] = _Metro_CreateButton("Refresh", 280, 408, 129, 21)
	$FORM3[6] = _Metro_CreateButton("Close", 472, 408, 129, 21)
	$FORM3[7] = GUICtrlGetHandle($FORM3[2])
	_GUICtrlListView_SetExtendedListViewStyle($FORM3[7], BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_INFOTIP, $LVS_EX_CHECKBOXES))
	_GUICtrlListView_AddColumn($FORM3[7], 'Modules', 601, 0)
	_GUICtrlListView_SetColumnWidth($FORM3[7], 0, $LVSCW_AUTOSIZE_USEHEADER)
	ControlDisable($FORM3[1], "", HWnd(_GUICtrlListView_GetHeader($FORM3[2])))
	GUICtrlSetOnEvent($FORM3[3], "_Modules_All_Enable")
	GUICtrlSetOnEvent($FORM3[4], "_Modules_All_Disable")
	GUICtrlSetOnEvent($FORM3[5], "_Modules_Get")
	GUICtrlSetOnEvent($FORM3[6], "_Module_Close")
	_Metro_SetGUIOption($FORM3[1], True, False)
	$FORM4[1] = _Metro_CreateGUI($FORM[0], 1015, 668, -1, -1, False)
	$FORM4[2] = GUICtrlCreateEdit("", 8, 62, 998, 596)
	$FORM4[3] = _Metro_CreateButton('Close', 597, 38, 201, 21)
	$FORM4[4] = _Metro_CreateButton('Save', 805, 38, 201, 21)
	GUICtrlSetOnEvent($FORM4[3], "_HostFileClose")
	GUICtrlSetOnEvent($FORM4[4], "_HostFileSave")
	_Metro_SetGUIOption($FORM4[1], True, False)
	GUIRegisterMsg(0x11, "_ForceClose")
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
	OnAutoItExitRegister('_EXIT')
	GUISetState(@SW_SHOW, $FORM[1])
	_Active($FORM[1])
EndFunc   ;==>_CreateGUI
Func _FixGUI()
	_Metro_GUIDelete($FORM[1])
	_Metro_GUIDelete($FORM2[1])
	_Metro_GUIDelete($FORM3[1])
	_Metro_GUIDelete($FORM4[1])
	_CreateGUI()
	If $_isStarted Then
		_Metro_DisableButton($FORM[7])
		_Metro_EnableButton($FORM[8])
		TrayItemSetText($TRAY[1], 'Close Proxy')
	EndIf
EndFunc   ;==>_FixGUI
Func _RunProxy()
	If $_isStarted Then
		If _Metro_MsgBox(4, $FORM[0], "Tera Proxy is now running..." & @CRLF & "Do you sure to close it now?", 400, 11, $FORM[1]) = 'Yes' Then
			$_isStarted = False
			_ClosePID()
			_Metro_DisableButton($FORM[8])
			_Metro_EnableButton($FORM[7])
			TrayItemSetText($TRAY[1], 'Start Proxy')
			_Console('Closed...')
			$iLineSize = 0
		EndIf
	Else
		If _CheckPID() Or _isProxyRun() Then
			If _Metro_MsgBox(4, $FORM[0], "Another Tera Proxy is now running..." & @CRLF & "Do you want to run new Tera Proxy?", 400, 11, $FORM[1]) <> 'Yes' Then Return
			_ClosePID()
			_closeProxy()
		EndIf
		$_isStarted = True
		$iLineSize = 0
		_Metro_DisableButton($FORM[7])
		_Metro_EnableButton($FORM[8])
		TrayItemSetText($TRAY[1], 'Close Proxy')
		_GUICtrlListView_DeleteAllItems($FORM[9])
		AdlibRegister('_RunProxy_StartProxy', 0)
	EndIf
EndFunc   ;==>_RunProxy
Func _RunProxy_StartProxy()
	AdlibUnRegister('_RunProxy_StartProxy')
	$iPID = Run('cmd.exe /k "' & IniRead($_ConfigFile, 'Config', 'Run', 'node bin/lib/proxy.js') & '"', @ScriptDir, @SW_HIDE, 2 + 4)
	ProcessWait(_isCustomApplication())
	$gPID = ProcessList(_isCustomApplication())
	_WritePID()
EndFunc   ;==>_RunProxy_StartProxy
Func _WritePID()
	Local Const $sDatFile = $sTemp & '\TempPID.dat'
	Local $hOpen = FileOpen($sDatFile, 10)
	Local $sData = @ScriptName & @TAB & @AutoItPID & @CR & 'cmd.exe' & @TAB & $iPID
	Local $sApp = _isCustomApplication()
	For $n = 1 To $gPID[0][0]
		$sData &= @CR & $sApp & @TAB & $gPID[$n][1]
	Next
	FileWrite($hOpen, $sData)
	FileClose($hOpen)
EndFunc   ;==>_WritePID
Func _CheckPID($aMode = False)
	Local Const $sDatFile = $sTemp & '\TempPID.dat'
	Local $hOpen = FileOpen($sDatFile, 0)
	If $hOpen <= 0 Then Return False
	Local $sPID = _GetLine(FileRead($hOpen)), $aPID
	FileClose($hOpen)
	$aMode = $aMode ? 1 : 2
	For $n = $aMode To $sPID[0]
		$aPID = StringSplit($sPID[$n], @TAB)
		If ProcessExists($aPID[2]) Then
			If StringInStr($aPID[1], _ProcessName($aPID[2])) Then Return True
		EndIf
	Next
	FileDelete($sDatFile)
	Return False
EndFunc   ;==>_CheckPID
Func _ClosePID($aMode = False)
	Local Const $sDatFile = $sTemp & '\TempPID.dat'
	Local $hOpen = FileOpen($sDatFile, 0)
	If $hOpen <= 0 Then Return False
	Local $sPID = _GetLine(FileRead($hOpen)), $aPID
	FileClose($hOpen)
	FileDelete($sDatFile)
	For $n = 2 To $sPID[0]
		$aPID = StringSplit($sPID[$n], @TAB)
		If ProcessExists($aPID[2]) Then
			If StringInStr($aPID[1], _ProcessName($aPID[2])) Then ProcessClose($aPID[2])
		EndIf
	Next
	If $aMode Then
		$aPID = StringSplit($sPID[1], @TAB)
		If ProcessExists($aPID[2]) Then
			If StringInStr($aPID[1], _ProcessName($aPID[2])) Then ProcessClose($aPID[2])
		EndIf
	EndIf
	Return True
EndFunc   ;==>_ClosePID
Func _isCustomApplication()
	Return IniRead($_ConfigFile, 'Config', 'Custom_Application_Use', 0) > 0 ? IniRead($_ConfigFile, 'Config', 'Custom_Application_Name', 'electron.exe') : 'node.exe'
EndFunc   ;==>_isCustomApplication
Func _ProcessName($p)
	Local $pList = ProcessList()
	For $i = 1 To UBound($pList) - 1
		If $pList[$i][1] = $p Then
			Return $pList[$i][0]
		EndIf
	Next
	Return SetError(1, 0, "")
EndFunc   ;==>_ProcessName
Func _AutoRun()
	If IniRead($_ConfigFile, 'Config', 'Auto_Run', 0) > 0 Then _RunProxy()
EndFunc   ;==>_AutoRun
Func _Console($sStr)
	Local $iItem = _GUICtrlListView_GetItemCount($FORM[9])
	Local $iLen = StringLen($sStr)
	_GUICtrlListView_InsertItem_Optim($FORM[3], $sStr)
	;_GUICtrlListView_AddItem($FORM[9], $sStr)
	_GUICtrlListView_EnsureVisible($FORM[9], $iItem)
	If $iLen > $iLineSize Then
		_GUICtrlListView_SetColumnWidth($FORM[9], 0, $LVSCW_AUTOSIZE_USEHEADER)
		$iLineSize = $iLen
	EndIf
	If IniRead($_ConfigFile, 'Config', 'Auto_Clear_Console', 0) > 0 Then
		If IniRead($_ConfigFile, 'Config', 'Auto_Clear_When', 0) <= $iItem Then _GUICtrlListView_DeleteAllItems($FORM[9])
	EndIf
EndFunc   ;==>_Console
Func _GUICtrlListView_Init_Optim()
	Global $pBuffer, $tBuffer, $pItem, $tItem
	$tItem = DllStructCreate($tagLVITEM)
	$pItem = DllStructGetPtr($tItem)
	$tBuffer = DllStructCreate("char Text[2048]")
	$pBuffer = DllStructGetPtr($tBuffer)
	DllStructSetData($tItem, "Text", $pBuffer)
	DllStructSetData($tItem, "TextMax", 2048)
	DllStructSetData($tItem, "Mask", BitOR($LVIF_TEXT, $LVIF_PARAM))
	DllStructSetData($tItem, "Item", 999999999)
	DllStructSetData($tItem, "Image", -1)
EndFunc   ;==>_GUICtrlListView_Init_Optim
Func _GUICtrlListView_InsertItem_Optim($hWnd, $sText)
	DllStructSetData($tBuffer, "Text", $sText)
	Return GUICtrlSendMsg($hWnd, $LVM_INSERTITEMA, 0, $pItem)
EndFunc   ;==>_GUICtrlListView_InsertItem_Optim
Func _GetLine($sStr)
	Local $iLine = StringRegExp(@CRLF & $sStr, "([^\r\n]*)(?:\r\n|\n|\r|$)", 3)
	$iLine[0] = UBound($iLine) - 2
	ReDim $iLine[UBound($iLine) - 1]
	Return $iLine
EndFunc   ;==>_GetLine
Func _FileListToArrayEx($sPath, $sFilter = "*", $iFlag = 0)
	Local $hSearch, $sFile, $sFileList, $iFlags = StringReplace(BitAND($iFlag, 1) + BitAND($iFlag, 2), "3", "0"), $sSubDir = BitAND($iFlag, 4), $DirPath = ""
	$sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\"
	If Not FileExists($sPath) Then Return SetError(1, 1, "")
	If StringRegExp($sFilter, "[\\/:><]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
	If BitAND($iFlag, 8) Then $DirPath = $sPath
	If Not ($iFlags = 0 Or $iFlags = 1 Or $iFlags = 2 Or $sSubDir = 4 Or $DirPath <> "") Then Return SetError(3, 3, "")
	$hSearch = FileFindFirstFile($sPath & "*")
	If @error Then Return SetError(4, 4, "")
	Local $hWSearch = $hSearch, $hWSTMP = $hSearch, $SearchWD, $Extended, $sDelim = "|", $sDirFilter = StringReplace($sFilter, "*", "")
	$sFilter = StringRegExpReplace(BitAND($iFlag, 16) & "(?i)", "16\(\?\i\)|\d+", "") & "(" & StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace("|" & $sFilter & "|", '\|\h*\|[\|\h]*', "\|"), '[\^\$\(\)\+\[\]\{\}\,\.\]', "\\$0"), "\|([^\*])", "\|^$1"), "([^\*])\|", "$1\$\|"), '\*', ".*"), '^\||\|$', "") & ")"
	While 1
		$sFile = FileFindNextFile($hWSearch)
		If @error Then
			If $hWSearch = $hSearch Then ExitLoop
			FileClose($hWSearch)
			$hWSearch -= 1
			$SearchWD = StringLeft($SearchWD, StringInStr(StringTrimRight($SearchWD, 1), "\", 1, -1))
		ElseIf $sSubDir Then
			$Extended = @extended
			If ($iFlags + $Extended <> 2) Then
				If $sDirFilter Then
					If StringRegExp($sFile, $sFilter) Then $sFileList &= $sDelim & $DirPath & $SearchWD & $sFile
				Else
					$sFileList &= $sDelim & $DirPath & $SearchWD & $sFile
				EndIf
			EndIf
			If Not $Extended Then ContinueLoop
			$hWSTMP = FileFindFirstFile($sPath & $SearchWD & $sFile & "\*")
			If $hWSTMP = -1 Then ContinueLoop
			$hWSearch = $hWSTMP
			$SearchWD &= $sFile & "\"
		Else
			If ($iFlags + @extended = 2) Or StringRegExp($sFile, $sFilter) = 0 Then ContinueLoop
			$sFileList &= $sDelim & $DirPath & $sFile
		EndIf
	WEnd
	FileClose($hSearch)
	If Not $sFileList Then Return SetError(4, 4, "")
	Return StringSplit(StringTrimLeft($sFileList, 1), "|", StringReplace(BitAND($iFlag, 32), "32", 2))
EndFunc   ;==>_FileListToArrayEx
Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tInfo, $index
	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $FORM[9]
			Switch $iCode
				Case $NM_RCLICK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$index = _GUICtrlListView_GetSelectedCount($FORM[9])
					If $index <= 0 Then Return
					Local $hMenu = _GUICtrlMenu_CreatePopup(), $idCopy
					$index = _GUICtrlListView_GetSelectedIndices($FORM[9])
					_GUICtrlMenu_AddMenuItem($hMenu, "Copy", $idCopy)
					Switch _GUICtrlMenu_TrackPopupMenu($hMenu, $FORM[9], -1, -1, 1, 1, 2)
						Case $idCopy
							$idCopy = ''
							$index = StringSplit($index, '|')
							;ClipPut(_GUICtrlListView_GetItemText($FORM[9], DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem")))
							For $x = 1 To $index[0]
								$idCopy &= _GUICtrlListView_GetItemText($FORM[9], $index[$x]) & @CRLF
							Next
							ClipPut($idCopy)
					EndSwitch
					_GUICtrlMenu_DestroyMenu($hMenu)
			EndSwitch
		Case $FORM3[7]
			Switch $iCode
				Case $NM_CLICK, $NM_RCLICK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$index = DllStructGetData($tInfo, "Index")
					If $index < 0 Then Return
					If _GUICtrlListView_GetItemChecked($FORM3[7], $index) Then
						_GUICtrlListView_SetItemChecked($FORM3[7], $index, False)
						Local $path = _GetPathName($Module[$index + 1], 1) & '_' & _GetPathName($Module[$index + 1])
						If StringInStr(FileGetAttrib($Module[$index + 1]), 'D') Then
							DirMove($Module[$index + 1], $path)
						Else
							FileMove($Module[$index + 1], $path)
						EndIf
						$Module[$index + 1] = $path
					Else
						_GUICtrlListView_SetItemChecked($FORM3[7], $index)
						Local $path = _GetPathName($Module[$index + 1], 1) & StringReplace(_GetPathName($Module[$index + 1]), '_', '')
						If StringInStr(FileGetAttrib($Module[$index + 1]), 'D') Then
							DirMove($Module[$index + 1], $path)
						Else
							FileMove($Module[$index + 1], $path)
						EndIf
						$Module[$index + 1] = $path
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
Func _GetPathName($sStr, $iMode = 0)
	For $x = StringLen($sStr) To 0 Step -1
		If StringMid($sStr, $x, 1) = '\' Then Return $iMode = 0 ? StringMid($sStr, $x + 1, StringLen($sStr) - $x) : StringLeft($sStr, $x)
	Next
	Return ''
EndFunc   ;==>_GetPathName
Func _PrintConsole()
	If _GUICtrlListView_GetItemCount($FORM[9]) = 0 Then
		_Metro_MsgBox(0, $FORM[0], "No any data in console for print now :/", 400, 11, $FORM[1])
		Return False
	EndIf
	Local $hFile = FileSaveDialog("Save to ...", @ScriptDir, "Text Documents (*.ini;*.txt;*log)|All Files (*.*)", 18, 'Console_' & @MDAY & '-' & @MON & '-' & @YEAR & '.log'), $_FileExtension
	If Not @error And $hFile <> '' Then
		$_FileExtension = StringRegExpReplace($hFile, "^(?:.*\\[^\\]*?)(\.[^.]+)?$", '\1')
		If @error Or $_FileExtension = '' Then $hFile = $hFile & '.log'
		$hOpen = FileOpen($hFile, 10)
		For $i = 0 To _GUICtrlListView_GetItemCount($FORM[9]) - 1
			FileWrite($hOpen, _GUICtrlListView_GetItemTextString($FORM[9], $i) & @CRLF)
		Next
		FileClose($hOpen)
		Return True
	EndIf
	Return False
EndFunc   ;==>_PrintConsole
Func _ClearConsole()
	If _GUICtrlListView_GetItemCount($FORM[9]) > 0 Then
		If _Metro_MsgBox(4, $FORM[0], "Do you sure to clear this console?", 400, 11, $FORM[1]) = 'Yes' Then _GUICtrlListView_DeleteAllItems($FORM[9])
	Else
		_Metro_MsgBox(0, $FORM[0], "No any data in console for clear now :x", 400, 11, $FORM[1])
	EndIf
EndFunc   ;==>_ClearConsole
Func _GuiLabel($sText, $left, $top, $width, $height)
	Local $aLabel = GUICtrlCreateLabel($sText, $left, $top, $width, $height, -1, 0x00100000)
	GUICtrlSetBkColor($aLabel, $GUIThemeColor)
	GUICtrlSetColor($aLabel, $FontThemeColor)
	GUICtrlSetFont($aLabel, 11, 400, 0, "Arial", 5)
	Return $aLabel
EndFunc   ;==>_GuiLabel
Func _ControlEvent($aControl)
	GUICtrlSetOnEvent($aControl[0], "_EXIT")
	GUICtrlSetOnEvent($aControl[3], "_Minimize")
	GUICtrlSetOnEvent($aControl[6], "_Menu")
EndFunc   ;==>_ControlEvent
Func _Menu()
	Local $MenuButtonsArray[5] = [$_isStarted ? 'Close Proxy' : 'Start Proxy', "Module", "Settings", "About", "Exit"]
	Local $MenuSelect = _Metro_MenuStart($FORM[1], 150, $MenuButtonsArray)
	Switch $MenuSelect
		Case "0"
			_RunProxy()
		Case "1"
			_Module_Open()
		Case "2"
			GUISetState(@SW_SHOW, $FORM2[1])
		Case "3"
			_About()
		Case "4"
			_EXIT()
	EndSwitch
EndFunc   ;==>_Menu
Func _Minimize()
	If IniRead($_ConfigFile, 'Config', 'Minimize_Tray_Icon', 0) > 0 Then
		GUISetState(@SW_HIDE, $FORM[1])
	Else
		GUISetState(@SW_MINIMIZE, $FORM[1])
	EndIf
EndFunc   ;==>_Minimize
Func On_Click_Config()
	GUISetState(@SW_SHOW, $FORM2[1])
	_Active($FORM2[1])
EndFunc   ;==>On_Click_Config
Func On_Click()
	GUISetState(@SW_SHOW, $FORM[1])
	_Active($FORM[1])
EndFunc   ;==>On_Click
Func _GetRegion()
	Local $hOpen = FileOpen($_Config_Region)
	Local $hRead = FileRead($hOpen)
	FileClose($hOpen)
	Local $rOpen = StringRegExp($hRead, '"region".*?:.*?"(.*?)"', 3)
	If Not @error Then Return StringUpper($rOpen[0])
	Return ''
EndFunc   ;==>_GetRegion
Func _Config_Close()
	GUISetState(@SW_HIDE, $FORM2[1])
EndFunc   ;==>_Config_Close
Func _Config_AutoStartup()
	If _Metro_ToggleIsChecked($FORM2[2]) Then
		_Metro_ToggleUnCheck($FORM2[2])
	Else
		_Metro_ToggleCheck($FORM2[2])
	EndIf
EndFunc   ;==>_Config_AutoStartup
Func _Config_AutoRun()
	If _Metro_ToggleIsChecked($FORM2[3]) Then
		_Metro_ToggleUnCheck($FORM2[3])
	Else
		_Metro_ToggleCheck($FORM2[3])
	EndIf
EndFunc   ;==>_Config_AutoRun
Func _Config_TrayIcon()
	If _Metro_ToggleIsChecked($FORM2[4]) Then
		_Metro_ToggleUnCheck($FORM2[4])
	Else
		_Metro_ToggleCheck($FORM2[4])
	EndIf
EndFunc   ;==>_Config_TrayIcon
Func _Config_UseElectron()
	If _Metro_ToggleIsChecked($FORM2[7]) Then
		_Metro_ToggleUnCheck($FORM2[7])
	Else
		_Metro_ToggleCheck($FORM2[7])
	EndIf
EndFunc   ;==>_Config_UseElectron
Func _Config_ClearLine()
	If _Metro_ToggleIsChecked($FORM2[12]) Then
		_Metro_ToggleUnCheck($FORM2[12])
	Else
		_Metro_ToggleCheck($FORM2[12])
	EndIf
EndFunc   ;==>_Config_ClearLine
Func _CreateINI()
	IniWrite($_ConfigFile, 'Config', 'Run', 'node bin/lib/proxy.js')
	IniWrite($_ConfigFile, 'Config', 'Auto_Run', 0)
	IniWrite($_ConfigFile, 'Config', 'Minimize_Tray_Icon', 0)
	IniWrite($_ConfigFile, 'Config', 'Custom_Application_Use', 0)
	IniWrite($_ConfigFile, 'Config', 'Custom_Application_Name', 'electron.exe')
	IniWrite($_ConfigFile, 'Config', 'Auto_Clear_Console', 0)
	IniWrite($_ConfigFile, 'Config', 'Auto_Clear_When', 1000)
EndFunc   ;==>_CreateINI
Func _Config_Save()
	IniWrite($_ConfigFile, 'Config', 'Run', GUICtrlRead($FORM2[6]))
	IniWrite($_ConfigFile, 'Config', 'Auto_Run', _Metro_ToggleIsChecked($FORM2[3]) ? 1 : 0)
	IniWrite($_ConfigFile, 'Config', 'Minimize_Tray_Icon', _Metro_ToggleIsChecked($FORM2[4]) ? 1 : 0)
	IniWrite($_ConfigFile, 'Config', 'Custom_Application_Use', _Metro_ToggleIsChecked($FORM2[7]) ? 1 : 0)
	IniWrite($_ConfigFile, 'Config', 'Custom_Application_Name', GUICtrlRead($FORM2[9]))
	IniWrite($_ConfigFile, 'Config', 'Auto_Clear_Console', _Metro_ToggleIsChecked($FORM2[12]) ? 1 : 0)
	IniWrite($_ConfigFile, 'Config', 'Auto_Clear_When', GUICtrlRead($FORM2[14]))
	If _Metro_ToggleIsChecked($FORM2[2]) Then
		If Not _StartupRegistry_Exists() Then _StartupRegistry_Install()
	Else
		If _StartupRegistry_Exists() Then _StartupRegistry_Uninstall()
	EndIf
	If GUICtrlRead($FORM2[11]) <> _GetRegion() Then
		Local $hOpen = FileOpen($_Config_Region, 0)
		Local $hRead = FileRead($hOpen)
		FileClose($hOpen)
		$hRead = StringRegExpReplace($hRead, '"region".*?:.*?"(.*?)"', '"region": "' & StringUpper(GUICtrlRead($FORM2[11])) & '"')
		$hOpen = FileOpen($_Config_Region, 10)
		FileWrite($hOpen, $hRead)
		FileClose($hOpen)
		GUICtrlSetData($FORM2[11], StringUpper(GUICtrlRead($FORM2[11])))
	EndIf
	GUISetState(@SW_HIDE, $FORM2[1])
EndFunc   ;==>_Config_Save
Func _Module_Open()
	_Modules_Get()
	GUISetState(@SW_SHOW, $FORM3[1])
	_Active($FORM3[1])
EndFunc   ;==>_Module_Open
Func _Module_Close()
	$Module = ''
	_GUICtrlListView_DeleteAllItems($FORM3[7])
	GUISetState(@SW_HIDE, $FORM3[1])
EndFunc   ;==>_Module_Close
Func _Modules_All_Disable()
	Local $path
	For $m = 1 To $Module[0]
		$path = _GetPathName($Module[$m])
		If StringLeft($path, 1) <> '_' Then
			$path = _GetPathName($Module[$m], 1) & '_' & $path
			If StringInStr(FileGetAttrib($Module[$m]), 'D') Then
				DirMove($Module[$m], $path)
			Else
				FileMove($Module[$m], $path)
			EndIf
			$Module[$m] = $path
			_GUICtrlListView_SetItemChecked($FORM3[7], $m - 1, False)
		EndIf
	Next
EndFunc   ;==>_Modules_All_Disable
Func _Modules_All_Enable()
	Local $path
	For $m = 1 To $Module[0]
		$path = _GetPathName($Module[$m])
		If StringLeft($path, 1) = '_' Then
			$path = _GetPathName($Module[$m], 1) & StringReplace(_GetPathName($Module[$m]), '_', '')
			If StringInStr(FileGetAttrib($Module[$m]), 'D') Then
				DirMove($Module[$m], $path)
			Else
				FileMove($Module[$m], $path)
			EndIf
			$Module[$m] = $path
			_GUICtrlListView_SetItemChecked($FORM3[7], $m - 1)
		EndIf
	Next
EndFunc   ;==>_Modules_All_Enable
Func _Modules_Get()
	If Not FileExists($_Module) Then Return
	_GUICtrlListView_DeleteAllItems($FORM3[7])
	$Module = _FileListToArrayEx($_Module, '*', 8)
	Local $iLen = 0, $tLen = 0, $path
	For $m = 1 To $Module[0]
		$path = _GetPathName($Module[$m])
		;_GUICtrlListView_AddItem($FORM3[7], StringLeft($mList[$m], 1) = '_' ? StringReplace(_GetPathName($Module[$m]), '_', '') : $mList[$m])
		_GUICtrlListView_InsertItem_Optim($FORM3[2], StringLeft($path, 1) = '_' ? StringReplace($path, '_', '') : $path)
		If StringLeft($path, 1) = '_' Then
			_GUICtrlListView_SetItemChecked($FORM3[7], $m - 1, False)
		Else
			_GUICtrlListView_SetItemChecked($FORM3[7], $m - 1)
		EndIf
		_GUICtrlListView_EnsureVisible($FORM3[7], _GUICtrlListView_GetItemCount($FORM3[7]) - 1)
		$iLen = StringLen($path)
		If $iLen > $tLen Then
			_GUICtrlListView_SetColumnWidth($FORM3[7], 0, $LVSCW_AUTOSIZE_USEHEADER)
			$tLen = $iLen
		EndIf
	Next
EndFunc   ;==>_Modules_Get
Func _HostsFileOpen()
	Local $path = @SystemDir & '\Drivers\Etc\hosts'
	Local $hOpen = FileOpen($path, 0 + FileGetEncoding($path))
	GUICtrlSetData($FORM4[2], FileRead($hOpen, FileGetSize($path)))
	FileClose($hOpen)
	GUISetState(@SW_SHOW, $FORM4[1])
EndFunc   ;==>_HostsFileOpen
Func _HostFileClose()
	GUICtrlSetData($FORM4[2], '')
	GUISetState(@SW_HIDE, $FORM4[1])
EndFunc   ;==>_HostFileClose
Func _HostFileSave()
	Local $path = @SystemDir & '\Drivers\Etc\hosts'
	Local $hOpen = FileOpen($path, 10 + FileGetEncoding($path))
	FileWrite($hOpen, GUICtrlRead($FORM4[2]))
	FileClose($hOpen)
	GUISetState(@SW_HIDE, $FORM4[1])
EndFunc   ;==>_HostFileSave
Func _isProxyRun()
	Local $pList = ProcessList(_isCustomApplication())
	Return $pList[0][0] > 1
EndFunc   ;==>_isProxyRun
Func _closeProxy()
	Local $pList = ProcessList(_isCustomApplication())
	For $i = 1 To $pList[0][0]
		ProcessClose($pList[$i][1])
	Next
EndFunc   ;==>_closeProxy
Func _Active($h)
	If Not WinActive($h) Then WinActivate($h)
EndFunc   ;==>_Active
Func _ClearGUI()
	_Metro_GUIDelete($FORM[1])
	_Metro_GUIDelete($FORM2[1])
	_Metro_GUIDelete($FORM3[1])
	_Metro_GUIDelete($FORM4[1])
	ProcessClose(@AutoItPID)
	Exit
EndFunc   ;==>_ClearGUI
Func _ForceClose($hWndGUI, $MsgID, $wParam, $lParam)
	_ClosePID()
	_ClearGUI()
	Return True
EndFunc   ;==>_ForceClose
Func _About()
	_Metro_MsgBox(0, $FORM[0], "Kappa :v" & @CRLF & @CRLF & "Version: 2.3" & @CRLF & 'Create by: Fukki' & @CRLF & 'Github: https://github.com/Fukki/Tera-Proxy-Gui/', 400, 11, $FORM[1])
EndFunc   ;==>_About
Func _EXIT()
	If $_isStarted Then
		If _Metro_MsgBox(4, $FORM[0], "Tera Proxy is now running..." & @CRLF & "Do you sure to exit now?", 400, 11, $FORM[1]) <> 'Yes' Then Return
		_ClosePID()
	EndIf
	_ClearGUI()
EndFunc   ;==>_EXIT
While Sleep(250)
	If $_isStarted And $iPID > 0 Then
		$sLine = StdoutRead($iPID)
		If $sLine <> '' Then
			$sLine = _GetLine($sLine)
			For $i = 1 To $sLine[0]
				If $sLine[$i] <> '' Then
					_Console($sLine[$i])
					Sleep(1)
				EndIf
			Next
			$sLine = ''
		EndIf
	EndIf
WEnd
