Func _Metro_MsgBox2($Flag, $Title, $Text, $mWidth = 600, $Fontsize = 11, $ParentGUI = "", $Timeout = 0)
	Local $1stButton, $2ndButton, $3rdButton, $1stButtonText = "-", $2ndButtonText = "-", $3rdButtonText = "-", $Buttons_Count = 1
	Switch $Flag
		Case 7 ; Custom
			$Buttons_Count = 3
			$1stButtonText = "Yes"
			$2ndButtonText = "Save File"
			$3rdButtonText = "No Need"
		Case 8 ; Custom
			$Buttons_Count = 3
			$1stButtonText = "Yes"
			$2ndButtonText = "Save File"
			$3rdButtonText = "No Need"
		Case Else
			$Buttons_Count = 1
			$1stButtonText = "OK"
	EndSwitch

	If ($Buttons_Count = 1) And ($mWidth < 180) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 180px for the selected message style/flag.")
	If ($Buttons_Count = 2) And ($mWidth < 240) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 240px for the selected message style/flag.")
	If ($Buttons_Count = 3) And ($mWidth < 360) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 360px for the selected message style/flag.")

	;HighDPI Support
	Local $msgbDPI = _HighDPICheck()
	If $HIGHDPI_SUPPORT Then
		$mWidth = Round($mWidth * $gDPI)
	Else
		$Fontsize = ($Fontsize / $Font_DPI_Ratio)
	EndIf

	Local $LabelSize = _StringSize($Text, $Fontsize, 400, 0, "Arial", $mWidth - (30 * $msgbDPI))
	Local $mHeight = 120 + ($LabelSize[3] / $msgbDPI)
	Local $MsgBox_Form = _Metro_CreateGUI($Title, $mWidth / $msgbDPI, $mHeight, -1, -1, False, $ParentGUI)
	$mHeight = $mHeight * $msgbDPI
	GUICtrlCreateLabel(" " & $Title, 2 * $msgbDPI, 2 * $msgbDPI, $mWidth - (4 * $msgbDPI), 30 * $msgbDPI, 0x0200, 0x00100000)
	GUICtrlSetBkColor(-1, _AlterBrightness($GUIThemeColor, 30))
	GUICtrlSetColor(-1, $FontThemeColor)
	_GUICtrlSetFont(-1, 11, 600, 0, "Arial", 5)
	GUICtrlCreateLabel($Text, 15 * $msgbDPI, 50 * $msgbDPI, $LabelSize[2], $LabelSize[3], -1, 0x00100000)
	GUICtrlSetBkColor(-1, $GUIThemeColor)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, $Fontsize, 400, 0, "Arial", 5)

	Local $1stButton_Left = (($mWidth / $msgbDPI) - ($Buttons_Count * 100) - (($Buttons_Count - 1) * 20)) / 2
	Local $1stButton_Left1 = ($mWidth - ($Buttons_Count * (100 * $msgbDPI)) - (($Buttons_Count - 1) * (20 * $msgbDPI))) / 2
	Local $2ndButton_Left = $1stButton_Left + 120
	Local $3rdButton_Left = $2ndButton_Left + 120

	GUICtrlCreateLabel("", 2 * $msgbDPI, $mHeight - (53 * $msgbDPI), $1stButton_Left1 - (4 * $msgbDPI), (50 * $msgbDPI), -1, 0x00100000)
	GUICtrlCreateLabel("", $mWidth - $1stButton_Left1 + (2 * $msgbDPI), $mHeight - (53 * $msgbDPI), $1stButton_Left1 - (4 * $msgbDPI), (50 * $msgbDPI), -1, 0x00100000)

	Local $cEnter = GUICtrlCreateDummy()
	Local $aAccelKeys[1][2] = [["{ENTER}", $cEnter]]
	Local $1stButton = _Metro_CreateButton($1stButtonText, $1stButton_Left, ($mHeight / $msgbDPI) - 50, 100, 34, $ButtonBKColor, $ButtonTextColor)
	Local $2ndButton = _Metro_CreateButton($2ndButtonText, $2ndButton_Left, ($mHeight / $msgbDPI) - 50, 100, 34, $ButtonBKColor, $ButtonTextColor)
	If $Buttons_Count < 2 Then GUICtrlSetState($2ndButton, 32)
	Local $3rdButton = _Metro_CreateButton($3rdButtonText, $3rdButton_Left, ($mHeight / $msgbDPI) - 50, 100, 34, $ButtonBKColor, $ButtonTextColor)
	If $Buttons_Count < 3 Then GUICtrlSetState($3rdButton, 32)

	;Set default btn.
	Switch $Flag
		Case 0, 1, 5
			GUICtrlSetState($1stButton, 512)
		Case 2, 4, 6
			GUICtrlSetState($2ndButton, 512)
		Case 3
			GUICtrlSetState($3rdButton, 512)
		Case Else
			GUICtrlSetState($1stButton, 512)
	EndSwitch
	GUISetAccelerators($aAccelKeys, $MsgBox_Form)

	GUISetState(@SW_SHOW)

	If $Timeout <> 0 Then
		$iMsgBoxTimeout = $Timeout
		AdlibRegister("_iMsgBoxTimeout", 1000)
	EndIf

	If $mOnEventMode Then Opt("GUIOnEventMode", 0) ;Temporarily deactivate oneventmode

	While 1
		If $Timeout <> 0 Then
			If $iMsgBoxTimeout <= 0 Then
				AdlibUnRegister("_iMsgBoxTimeout")
				_Metro_GUIDelete($MsgBox_Form)
				If $mOnEventMode Then Opt("GUIOnEventMode", 1) ;Reactivate oneventmode
				Return SetError(1)
			EndIf
		EndIf
		Local $nMsg = GUIGetMsg()
		Switch $nMsg
			Case -3, $1stButton
				_Metro_GUIDelete($MsgBox_Form)
				If $mOnEventMode Then Opt("GUIOnEventMode", 1) ;Reactivate oneventmode
				Return $1stButtonText
			Case $2ndButton
				_Metro_GUIDelete($MsgBox_Form)
				If $mOnEventMode Then Opt("GUIOnEventMode", 1) ;Reactivate oneventmode
				Return $2ndButtonText
			Case $3rdButton
				_Metro_GUIDelete($MsgBox_Form)
				If $mOnEventMode Then Opt("GUIOnEventMode", 1) ;Reactivate oneventmode
				Return $3rdButtonText
			Case $cEnter
				_Metro_GUIDelete($MsgBox_Form)
				Local $ReturnText
				Switch $Flag
					Case 0, 1, 5
						$ReturnText = $1stButtonText
					Case 2, 4, 6
						$ReturnText = $2ndButtonText
					Case 3
						$ReturnText = $3rdButtonText
					Case Else
						$ReturnText = $1stButtonText
				EndSwitch
				If $mOnEventMode Then Opt("GUIOnEventMode", 1) ;Reactivate oneventmode
				Return $ReturnText
		EndSwitch
	WEnd
EndFunc   ;==>_Metro_MsgBox2