; ===============================================================================================================================
; Name ..........: MetroGUI UDF Example
; Version .......: v5.1
; Author ........: BB_19
; ===============================================================================================================================

;!Highly recommended for improved overall performance and responsiveness of the GUI effects etc.! (after compiling):
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm /pe

;YOU NEED TO EXCLUDE FOLLOWING FUNCTIONS FROM AU3STRIPPER, OTHERWISE IT WON'T WORK:
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
;Please not that Au3Stripper will show errors. You can ignore them as long as you use the above Au3Stripper_Ignore_Funcs parameters.

;Required if you want High DPI scaling enabled. (Also requries _Metro_EnableHighDPIScaling())
#AutoIt3Wrapper_Res_HiDpi=y
; ===============================================================================================================================

#NoTrayIcon
#include "MetroGUI-UDF\MetroGUI_UDF.au3"
#include "MetroGUI-UDF\_GUIDisable.au3" ; For dim effects when msgbox is displayed
#include <GUIConstants.au3>

;=======================================================================Creating the GUI===============================================================================
;Enable high DPI support: Detects the users DPI settings and resizes GUI and all controls to look perfectly sharp.
_Metro_EnableHighDPIScaling() ; Note: Requries "#AutoIt3Wrapper_Res_HiDpi=y" for compiling. To see visible changes without compiling, you have to disable dpi scaling in compatibility settings of Autoit3.exe

;Set Theme
_SetTheme("DarkTeal") ;See MetroThemes.au3 for selectable themes or to add more

;Create resizable Metro GUI
$Form1 = _Metro_CreateGUI("Example", 500, 300, -1, -1, False)

;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, True, True, True, True) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
$GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]
;======================================================================================================================================================================

;Create  Buttons
$Button1 = _Metro_CreateButton("Button Style 1", 50, 245, 115, 40)
$Button2 = _Metro_CreateButtonEx("Button Style 2", 195, 245, 115, 40)
$Button3 = _Metro_CreateButtonEx2("Button Style 3", 340, 245, 115, 40)

;Create Checkboxes
$Checkbox1 = _Metro_CreateCheckbox("Checkbox 1", 30, 70, 125, 30)
$Checkbox2 = _Metro_CreateCheckboxEx("Checkbox 2", 30, 107, 125, 30)
$Checkbox3 = _Metro_CreateCheckboxEx2("Checkbox 3", 29, 142, 125, 30)
;Set status to checked
_Metro_CheckboxCheck($Checkbox1, True)
_Metro_CheckboxCheck($Checkbox2, True)
_Metro_CheckboxCheck($Checkbox3, True)

;Create 3 Radios that are assigned to Radio Group 1
$Radio1 = _Metro_CreateRadio("1", "Radio 1", 180, 70, 100, 30)
$Radio2 = _Metro_CreateRadio("1", "Radio 2", 180, 110, 100, 30)
$Radio3 = _Metro_CreateRadioEx("1", "Radio 3", 180, 150, 100, 30) ;Style with colored checkmark
_Metro_RadioCheck("1", $Radio1) ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"

;Create Toggles
$Toggle1 = _Metro_CreateToggle("Toggle 1", 320, 70, 130, 30)
$Toggle2 = _Metro_CreateToggleEx("Toggle 2", 322, 107, 128, 30)
$Toggle3 = _Metro_CreateOnOffToggle("Enabled", "Disabled", 320, 144, 130, 30) ; Creates a toggle with different texts for on/off. Alternatively you can use _Metro_CreateOnOffToggleEx for the secondary toggle style.

;Create Progressbar
$Progress1 = _Metro_CreateProgress(100, 195, 300, 26)

;Set resizing options for the controls so they don't change in size or position. This can be customized to match your gui perfectly for resizing. See AutoIt Help file.
GUICtrlSetResizing($Button1, 768 + 8)
GUICtrlSetResizing($Button2, 768 + 8)
GUICtrlSetResizing($Button3, 768 + 8)
GUICtrlSetResizing($Checkbox1, 768 + 2 + 32)
GUICtrlSetResizing($Checkbox2, 768 + 2 + 32)
GUICtrlSetResizing($Checkbox3, 768 + 2 + 32)
GUICtrlSetResizing($Radio1, 768 + 2 + 32)
GUICtrlSetResizing($Radio2, 768 + 2 + 32)
GUICtrlSetResizing($Radio3, 768 + 2 + 32)
GUICtrlSetResizing($Toggle1, 768 + 2 + 32)
GUICtrlSetResizing($Toggle2, 768 + 2 + 32)
GUICtrlSetResizing($Toggle3, 768 + 2 + 32)
GUICtrlSetResizing($Progress1[0], 768 + 2 + 32)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
			_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
			Exit
		Case $GUI_MAXIMIZE_BUTTON
			GUISetState(@SW_MAXIMIZE, $Form1)
		Case $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $Form1)
		Case $GUI_RESTORE_BUTTON
			GUISetState(@SW_RESTORE, $Form1)
		Case $GUI_FULLSCREEN_BUTTON, $GUI_FSRestore_BUTTON
			ConsoleWrite("Fullscreen toggled" & @CRLF) ;Fullscreen toggle is processed automatically when $ControlBtnsAutoMode is set to true, otherwise you need to use here _Metro_FullscreenToggle($Form1)
		Case $GUI_MENU_BUTTON
			;Create an Array containing menu button names
			Local $MenuButtonsArray[5] = ["Themes Demo", "Settings", "About", "Contact", "Exit"]
			; Open the metro Menu. See decleration of $MenuButtonsArray above.
			Local $MenuSelect = _Metro_MenuStart($Form1, 150, $MenuButtonsArray)
			Switch $MenuSelect ;Above function returns the index number of the selected button from the provided buttons array.
				Case "0"
					ConsoleWrite("Returned 0 = Starting themes demo. Please note that the window border colors are not updated during this demo." & @CRLF)
					_ThemesDemo()
				Case "1"
					ConsoleWrite("Returned 1 = Settings button clicked." & @CRLF)
				Case "2"
					ConsoleWrite("Returned 2 = About button clicked." & @CRLF)
				Case "3"
					ConsoleWrite("Returned 3 = Contact button clicked." & @CRLF)
				Case "4"
					ConsoleWrite("Returned 4 = Exit button clicked." & @CRLF)
					_Metro_GUIDelete($Form1)
					Exit
			EndSwitch
		Case $Button3
			_GUIDisable($Form1, 0, 30) ;For better visibility of the MsgBox on top of the first GUI.
			_Metro_MsgBox(0, "Metro MsgBox Example", "Try a rightclick on this button for rightclick menu demo.", 400, 11, $Form1) ; with 3 secs timeout
			_GUIDisable($Form1)
		Case $GUI_EVENT_SECONDARYDOWN ;Demo for starting rightclick menu
			Local $aCInfo = GUIGetCursorInfo($Form1)
			If $aCInfo[4] = $Button3 Then
				;Create an Array containing menu button names
				Local $MenuButtonsArray[4] = ["Button 1", "Button 2", "Button 3", "Button 4"]
				; Open the rightclick Menu. See decleration of $MenuButtonsArray above.
				Local $MenuSelect = _Metro_RightClickMenu($Form1, 300, $MenuButtonsArray)
				Switch $MenuSelect ;Above function returns the index number of the selected button from the provided buttons array.
					Case "0"
						ConsoleWrite("Returned 0 = Button 1 clicked." & @CRLF)
					Case "1"
						ConsoleWrite("Returned 1 = Button 2 clicked." & @CRLF)
					Case "2"
						ConsoleWrite("Returned 2 = Button 3 clicked." & @CRLF)
					Case "3"
						ConsoleWrite("Returned 3 = Button 4 clicked." & @CRLF)
				EndSwitch
			EndIf
		Case $Button2
			_GUIDisable($Form1, 0, 30) ;For better visibility of the MsgBox on top of the first GUI.
			_Metro_MsgBox(0, "Metro MsgBox Example", "Button 2 clicked. (Button with 3 secs timeout)", 400, 11, $Form1, 3) ; with 3 secs timeout
			_GUIDisable($Form1)
		Case $Button1
			_GUIDisable($Form1, 0, 30)
			Local $mInput = _Metro_InputBox("Please enter your name.", 11, "", False, True)
			If Not @error Then _Metro_MsgBox(0, "Metro MsgBox Example", "Hello " & $mInput & ", Press ok to set the progressbar.", 350, 11, $Form1)
			_GUIDisable($Form1)
			For $i = 0 To 85 Step +2
				Sleep(1)
				_Metro_SetProgress($Progress1, $i)
			Next
			_GUIDisable($Form1, 0, 30)
			Local $Select_YesNo = _Metro_MsgBox(4, "Metro MsgBox Example", "Select yes to create a second GUI.", 350, 11, $Form1)
			If $Select_YesNo = "Yes" Then _SecondGUI()
			_GUIDisable($Form1)
		Case $Toggle1
			If _Metro_ToggleIsChecked($Toggle1) Then
				_Metro_ToggleUnCheck($Toggle1)
				ConsoleWrite("Toggle unchecked!" & @CRLF)
			Else
				_Metro_ToggleCheck($Toggle1)
				ConsoleWrite("Toggle checked!" & @CRLF)
			EndIf
		Case $Toggle2
			If _Metro_ToggleIsChecked($Toggle2) Then
				_Metro_ToggleUnCheck($Toggle2)
				ConsoleWrite("Toggle unchecked!" & @CRLF)
			Else
				_Metro_ToggleCheck($Toggle2)
				ConsoleWrite("Toggle checked!" & @CRLF)
			EndIf
		Case $Toggle3
			If _Metro_ToggleIsChecked($Toggle3) Then
				_Metro_ToggleUnCheck($Toggle3)
				ConsoleWrite("Disabled!" & @CRLF)
			Else
				_Metro_ToggleCheck($Toggle3)
				ConsoleWrite("Enabled!" & @CRLF)
			EndIf
		Case $Checkbox1
			If _Metro_CheckboxIsChecked($Checkbox1) Then
				_Metro_CheckboxUnCheck($Checkbox1)
				ConsoleWrite("Checkbox unchecked!" & @CRLF)
			Else
				_Metro_CheckboxCheck($Checkbox1)
				ConsoleWrite("Checkbox checked!" & @CRLF)
			EndIf
		Case $Checkbox2
			If _Metro_CheckboxIsChecked($Checkbox2) Then
				_Metro_CheckboxUnCheck($Checkbox2)
				ConsoleWrite("Checkbox unchecked!" & @CRLF)
			Else
				_Metro_CheckboxCheck($Checkbox2)
				ConsoleWrite("Checkbox checked!" & @CRLF)
			EndIf
		Case $Checkbox3
			If _Metro_CheckboxIsChecked($Checkbox3) Then
				_Metro_CheckboxUnCheck($Checkbox3)
				ConsoleWrite("Checkbox unchecked!" & @CRLF)
			Else
				_Metro_CheckboxCheck($Checkbox3)
				ConsoleWrite("Checkbox checked!" & @CRLF)
			EndIf
		Case $Radio1
			_Metro_RadioCheck(1, $Radio1)
			ConsoleWrite("Radio 1 selected!" & @CRLF)
		Case $Radio2
			_Metro_RadioCheck(1, $Radio2)
			ConsoleWrite("Radio 2 selected = " & _Metro_RadioIsChecked(1, $Radio2) & @CRLF)
		Case $Radio3
			_Metro_RadioCheck(1, $Radio3)
			ConsoleWrite("Radio 3 (ExStyle) selected!" & @CRLF)
	EndSwitch
WEnd


Func _SecondGUI()
	Local $Form2 = _Metro_CreateGUI("Example2", 600, 400, -1, -1, True)

	;Add control buttons
	Local $Control_Buttons_2 = _Metro_AddControlButtons(True, True, True, True)
	Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]
	Local $GUI_MAXIMIZE_BUTTON = $Control_Buttons_2[1]
	Local $GUI_RESTORE_BUTTON = $Control_Buttons_2[2]
	Local $GUI_MINIMIZE_BUTTON = $Control_Buttons_2[3]

	Local $Button1 = _Metro_CreateButton("Close", 250, 340, 100, 40)
	GUICtrlSetResizing($Button1, 768 + 8)
	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $Button1, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form2) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0
			Case $GUI_MAXIMIZE_BUTTON
				GUISetState(@SW_MAXIMIZE, $Form2)
			Case $GUI_MINIMIZE_BUTTON
				GUISetState(@SW_MINIMIZE, $Form2)
			Case $GUI_RESTORE_BUTTON
				GUISetState(@SW_RESTORE, $Form2)
		EndSwitch
	WEnd
EndFunc   ;==>_SecondGUI


Func _ThemesDemo() ;Loop through all themes by recreating all controls
	Local $ThemesArray[25] = ["DarkMidnightTeal", "DarkMidnightBlue", "DarkMidnightCyan", "DarkMidnight", "DarkTeal", "DarkBlueV2", "DarkBlue", "DarkCyan", "DarkRuby", "DarkGray", "DarkGreen", "DarkGreenV2", "DarkPurple", "DarkAmber", "DarkOrange", "LightTeal", "LightGray", "LightBlue", "LightCyan", "LightGreen", "LightRed", "LightOrange", "LightPurple", "LightPink", "DarkTealV2"]
	For $i = 0 To 24
		GUISetState($Form1, @SW_LOCK)
		ConsoleWrite($ThemesArray[$i] & @CRLF)
		_SetTheme($ThemesArray[$i]) ;See MetroThemes.au3 for selectable themes or to add more
		GUICtrlDelete($Button1)
		GUICtrlDelete($Button2)
		GUICtrlDelete($Button3)
		GUICtrlDelete($Checkbox1)
		GUICtrlDelete($Checkbox2)
		GUICtrlDelete($Checkbox3)
		GUICtrlDelete($Radio1)
		GUICtrlDelete($Radio2)
		GUICtrlDelete($Radio3)
		GUICtrlDelete($Toggle1)
		GUICtrlDelete($Toggle2)
		GUICtrlDelete($Toggle3)
		GUICtrlDelete($Progress1[0])
		GUICtrlDelete($GUI_CLOSE_BUTTON)
		GUICtrlDelete($GUI_MAXIMIZE_BUTTON)
		GUICtrlDelete($GUI_RESTORE_BUTTON)
		GUICtrlDelete($GUI_MINIMIZE_BUTTON)
		GUICtrlDelete($GUI_FULLSCREEN_BUTTON)
		GUICtrlDelete($GUI_FSRestore_BUTTON)
		GUICtrlDelete($GUI_MENU_BUTTON)
		GUISetBkColor($GUIThemeColor, $Form1)
		$Control_Buttons = _Metro_AddControlButtons(True, True, True, True, True)
		$GUI_CLOSE_BUTTON = $Control_Buttons[0]
		$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
		$GUI_RESTORE_BUTTON = $Control_Buttons[2]
		$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
		$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
		$GUI_FSRestore_BUTTON = $Control_Buttons[5]
		$GUI_MENU_BUTTON = $Control_Buttons[6]
		$Button1 = _Metro_CreateButton("Button Style 1", 50, 245, 115, 40)
		$Button2 = _Metro_CreateButtonEx("Button Style 2", 195, 245, 115, 40)
		$Button3 = _Metro_CreateButtonEx2("Button Style 3", 340, 245, 115, 40)
		$Checkbox1 = _Metro_CreateCheckbox("Checkbox 1", 30, 70, 125, 30)
		$Checkbox2 = _Metro_CreateCheckboxEx("Checkbox 2", 30, 107, 125, 30)
		$Checkbox3 = _Metro_CreateCheckboxEx2("Checkbox 3", 29, 142, 125, 30)
		_Metro_CheckboxCheck($Checkbox1, True)
		_Metro_CheckboxCheck($Checkbox2, True)
		_Metro_CheckboxCheck($Checkbox3, True)
		$Radio1 = _Metro_CreateRadio("1", "Radio 1", 180, 70, 100, 30)
		$Radio2 = _Metro_CreateRadio("1", "Radio 2", 180, 110, 100, 30)
		$Radio3 = _Metro_CreateRadioEx("1", "Radio 3", 180, 150, 100, 30)
		_Metro_RadioCheck("1", $Radio1)
		$Toggle1 = _Metro_CreateToggle("Toggle 1", 320, 70, 130, 30)
		$Toggle2 = _Metro_CreateToggleEx("Toggle 2", 322, 107, 128, 30)
		$Toggle3 = _Metro_CreateOnOffToggle("Enabled", "Disabled", 320, 144, 130, 30)
		$Progress1 = _Metro_CreateProgress(100, 195, 300, 26)
		GUICtrlSetResizing($Button1, 768 + 8)
		GUICtrlSetResizing($Button2, 768 + 8)
		GUICtrlSetResizing($Button3, 768 + 8)
		GUICtrlSetResizing($Checkbox1, 768 + 2 + 32)
		GUICtrlSetResizing($Checkbox2, 768 + 2 + 32)
		GUICtrlSetResizing($Checkbox3, 768 + 2 + 32)
		GUICtrlSetResizing($Radio1, 768 + 2 + 32)
		GUICtrlSetResizing($Radio2, 768 + 2 + 32)
		GUICtrlSetResizing($Radio3, 768 + 2 + 32)
		GUICtrlSetResizing($Toggle1, 768 + 2 + 32)
		GUICtrlSetResizing($Toggle2, 768 + 2 + 32)
		GUICtrlSetResizing($Toggle3, 768 + 2 + 32)
		GUICtrlSetResizing($Progress1[0], 768 + 2 + 32)
		GUISetState($Form1, @SW_UNLOCK)
		Sleep(1500)
	Next
EndFunc   ;==>_ThemesDemo
