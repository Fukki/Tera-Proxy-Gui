#RequireAdmin
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)
Global Const $0 = -1
Global Const $1 = 0x0001
Global Const $2 = 0x0010
Global Const $3 = 0x0004
Global Const $4 = 0x0002
Global Const $5 = 0x1000
Global Const $6 = 0x0002
Global Const $7 = 0x8000
Global Const $8 = 0x0800
Global Const $9 = 0x0000
Global Const $a = 0x0001
Global Const $b = 0x00000004
Global Const $c = 0x00000008
Global Const $d = 0x00000001
Global Const $e = 0x0002
Global Const $f = 0x0001
Global Const $g = 0x00000004
Global Const $h = 0x00000020
Global Const $i = 0x00000001
Global Const $j = 0x00000400
Global Const $k = 0x1000
Global Const $l =($k + 9)
Global Const $m =($k + 19)
Global Const $n =($k + 31)
Global Const $o =($k + 5)
Global Const $p =($k + 75)
Global Const $q =($k + 4)
Global Const $r =($k + 44)
Global Const $s =($k + 45)
Global Const $t =($k + 115)
Global Const $u =($k + 12)
Global Const $v =($k + 50)
Global Const $w = 0x2000 + 6
Global Const $x =($k + 27)
Global Const $y =($k + 97)
Global Const $0z =($k + 7)
Global Const $10 =($k + 26)
Global Const $11 =($k + 96)
Global Const $12 =($k + 30)
Global Const $13 =($k + 54)
Global Const $14 =($k + 6)
Global Const $15 =($k + 76)
Global Const $16 = 0x0100
Global Const $17 = 0x0200
Global Const $18 = 0x0400
Global Const $19 = 0x0800
Global Const $1a = 0x0000
Global Const $1b = 0x0004
Global Const $1c = 0x0008
Global Const $1d = 0x0001
Global Const $1e = 0x0002
Global Const $1f = -2
Global Const $1g = -3
Global Const $1h = 'GUI_RUNDEFMSG'
Global Const $1i = 1
Global Const $1j = 2
Global Const $1k = 0x0001
Global Const $1l = 0x0002
Global Const $1m = 0x0008
Global Const $1n = 0x0020
Global Const $1o = 2
Global Const $1p = 8
Global Const $1q = 11
Global $1r[$1q]
Global Const $1s = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($1t, $1u, $1v)
If $1r[3] = $1r[4] Then
If Not $1r[7] Then
$1r[5] *= -1
$1r[7] = 1
EndIf
Else
$1r[7] = 1
EndIf
$1r[6] = $1r[3]
Local $1w = _a($1v, $1t, $1r[3])
Local $1x = _a($1v, $1u, $1r[3])
If $1r[8] = 1 Then
If(StringIsFloat($1w) Or StringIsInt($1w)) Then $1w = Number($1w)
If(StringIsFloat($1x) Or StringIsInt($1x)) Then $1x = Number($1x)
EndIf
Local $1y
If $1r[8] < 2 Then
$1y = 0
If $1w < $1x Then
$1y = -1
ElseIf $1w > $1x Then
$1y = 1
EndIf
Else
$1y = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $1w, 'wstr', $1x)[0]
EndIf
$1y = $1y * $1r[5]
Return $1y
EndFunc
Func _a($1v, $1z, $20 = 0)
Local $21 = DllStructCreate("wchar Text[4096]")
Local $22 = DllStructGetPtr($21)
Local $23 = DllStructCreate($1s)
DllStructSetData($23, "SubItem", $20)
DllStructSetData($23, "TextMax", 4096)
DllStructSetData($23, "Text", $22)
If IsHWnd($1v) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $1v, "uint", 0x1073, "wparam", $1z, "struct*", $23)
Else
Local $24 = DllStructGetPtr($23)
GUICtrlSendMsg($1v, 0x1073, $1z, $24)
EndIf
Return DllStructGetData($21, "Text")
EndFunc
Global Const $25 = 0x00001000
Global Const $26 = 0x00002000
Global Const $27 = 0x00000004
Global Const $28 = 0x00008000
Global Const $29 = 0x00000008
Global Const $2a = 0x00000010
Global Const $2b = 0x00000020
Global Const $2c = 0x00000002
Global Enum $2d = 0, $2e, $2f, $2g
Global Const $2h = 0x00000008
Global Const $2i = 0x00000020
Func _1l(Const $2j = @error, Const $2k = @extended)
Local $2l = DllCall("kernel32.dll", "dword", "GetLastError")
Return SetError($2j, $2k, $2l[0])
EndFunc
Func _1u($2m, $2n, $2o, $2p, $2q = 0, $2r = 0)
Local $2s = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $2m, "bool", $2n, "struct*", $2o, "dword", $2p, "struct*", $2q, "struct*", $2r)
If @error Then Return SetError(@error, @extended, False)
Return Not($2s[0] = 0)
EndFunc
Func _20($2t = $2f)
Local $2s = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $2t)
If @error Then Return SetError(@error, @extended, False)
Return Not($2s[0] = 0)
EndFunc
Func _24($2u, $2v)
Local $2s = DllCall("advapi32.dll", "bool", "LookupPrivilegeValueW", "wstr", $2u, "wstr", $2v, "int64*", 0)
If @error Or Not $2s[0] Then Return SetError(@error, @extended, 0)
Return $2s[3]
EndFunc
Func _26($2w, $2x = 0, $2y = False)
If $2x = 0 Then
Local $2l = DllCall("kernel32.dll", "handle", "GetCurrentThread")
If @error Then Return SetError(@error + 10, @extended, 0)
$2x = $2l[0]
EndIf
Local $2s = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $2x, "dword", $2w, "bool", $2y, "handle*", 0)
If @error Or Not $2s[0] Then Return SetError(@error, @extended, 0)
Return $2s[4]
EndFunc
Func _27($2w, $2x = 0, $2y = False)
Local $2m = _26($2w, $2x, $2y)
If $2m = 0 Then
Local Const $2z = 1008
If _1l() <> $2z Then Return SetError(20, _1l(), 0)
If Not _20() Then Return SetError(@error + 10, _1l(), 0)
$2m = _26($2w, $2x, $2y)
If $2m = 0 Then Return SetError(@error, _1l(), 0)
EndIf
Return $2m
EndFunc
Func _28($2m, $30, $31)
Local $32 = _24("", $30)
If $32 = 0 Then Return SetError(@error + 10, @extended, False)
Local Const $33 = "dword Count;align 4;int64 LUID;dword Attributes"
Local $34 = DllStructCreate($33)
Local $35 = DllStructGetSize($34)
Local $2q = DllStructCreate($33)
Local $36 = DllStructGetSize($2q)
Local $37 = DllStructCreate("int Data")
DllStructSetData($34, "Count", 1)
DllStructSetData($34, "LUID", $32)
If Not _1u($2m, False, $34, $35, $2q, $37) Then Return SetError(2, @error, False)
DllStructSetData($2q, "Count", 1)
DllStructSetData($2q, "LUID", $32)
Local $38 = DllStructGetData($2q, "Attributes")
If $31 Then
$38 = BitOR($38, $2c)
Else
$38 = BitAND($38, BitNOT($2c))
EndIf
DllStructSetData($2q, "Attributes", $38)
If Not _1u($2m, False, $2q, $36, $34, $37) Then Return SetError(3, @error, False)
Return True
EndFunc
Global Const $39 = "struct;long X;long Y;endstruct"
Global Const $3a = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $3b = "struct;hwnd hWndFrom;uint_ptr IDFrom;INT Code;endstruct"
Global Const $3c = "struct;float X;float Y;float Width;float Height;endstruct"
Global Const $3d = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $3e = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
Global Const $3f = $3b & ";int Index;int SubItem;uint NewState;uint OldState;uint Changed;" & $39 & ";lparam lParam;uint KeyFlags"
Global Const $3g = "dword Size;INT Mask;dword Style;uint YMax;handle hBack;dword ContextHelpID;ulong_ptr MenuData"
Global Const $3h = "uint Size;uint Mask;uint Type;uint State;uint ID;handle SubMenu;handle BmpChecked;handle BmpUnchecked;" & "ulong_ptr ItemData;ptr TypeData;uint CCH;handle BmpItem"
Global Const $3i = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & "int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;handle hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & "uint cyIntegral;uint cxIdeal;lparam lParam;uint cxHeader" &((@OSVersion = "WIN_XP") ? "" : ";" & $3a & ";uint uChevronState")
Global Const $3j = "uint length;uint flags;uint showCmd;long ptMinPosition[2];long ptMaxPosition[2];long rcNormalPosition[4]"
Global Const $3k = "handle hProc;ulong_ptr Size;ptr Mem"
Func _2d(ByRef $3l)
Local $3m = DllStructGetData($3l, "Mem")
Local $3n = DllStructGetData($3l, "hProc")
Local $3o = _2q($3n, $3m, 0, $28)
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $3n)
If @error Then Return SetError(@error, @extended, False)
Return $3o
EndFunc
Func _2j($1v, $3p, ByRef $3l)
Local $2l = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $1v, "dword*", 0)
If @error Then Return SetError(@error + 10, @extended, 0)
Local $3q = $2l[2]
If $3q = 0 Then Return SetError(1, 0, 0)
Local $2w = BitOR($29, $2a, $2b)
Local $3n = _2r($2w, False, $3q, True)
Local $3r = BitOR($26, $25)
Local $3m = _2o($3n, 0, $3p, $3r, $27)
If $3m = 0 Then Return SetError(2, 0, 0)
$3l = DllStructCreate($3k)
DllStructSetData($3l, "hProc", $3n)
DllStructSetData($3l, "Size", $3p)
DllStructSetData($3l, "Mem", $3m)
Return $3m
EndFunc
Func _2l(ByRef $3l, $3s, $3t, $3p)
Local $2l = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", DllStructGetData($3l, "hProc"), "ptr", $3s, "struct*", $3t, "ulong_ptr", $3p, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _2m(ByRef $3l, $3s, $3t = 0, $3p = 0, $3u = "struct*")
If $3t = 0 Then $3t = DllStructGetData($3l, "Mem")
If $3p = 0 Then $3p = DllStructGetData($3l, "Size")
Local $2l = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($3l, "hProc"), "ptr", $3t, $3u, $3s, "ulong_ptr", $3p, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _2o($3n, $3v, $3p, $3w, $3x)
Local $2l = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $3n, "ptr", $3v, "ulong_ptr", $3p, "dword", $3w, "dword", $3x)
If @error Then Return SetError(@error, @extended, 0)
Return $2l[0]
EndFunc
Func _2q($3n, $3v, $3p, $3y)
Local $2l = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $3n, "ptr", $3v, "ulong_ptr", $3p, "dword", $3y)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _2r($2w, $3z, $40, $41 = False)
Local $2l = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $2w, "bool", $3z, "dword", $40)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return $2l[0]
If Not $41 Then Return SetError(100, 0, 0)
Local $2m = _27(BitOR($2i, $2h))
If @error Then Return SetError(@error + 10, @extended, 0)
_28($2m, "SeDebugPrivilege", True)
Local $42 = @error
Local $43 = @extended
Local $44 = 0
If Not @error Then
$2l = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $2w, "bool", $3z, "dword", $40)
$42 = @error
$43 = @extended
If $2l[0] Then $44 = $2l[0]
_28($2m, "SeDebugPrivilege", False)
If @error Then
$42 = @error + 20
$43 = @extended
EndIf
Else
$42 = @error + 30
EndIf
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $2m)
Return SetError($42, $43, $44)
EndFunc
Func _2s($1v, $45, $46 = 0, $47 = 0, $48 = 0, $49 = "wparam", $4a = "lparam", $4b = "lresult")
Local $2l = DllCall("user32.dll", $4b, "SendMessageW", "hwnd", $1v, "uint", $45, $49, $46, $4a, $47)
If @error Then Return SetError(@error, @extended, "")
If $48 >= 0 And $48 <= 4 Then Return $2l[$48]
Return $2l
EndFunc
Global Const $4c = 10000
Global $4d, $4e = 0
Global Const $4f = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $4g = _3h()
Func _2x($4h)
Local $2l = DllCall("kernel32.dll", "bool", "FreeLibrary", "handle", $4h)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _2z($1v)
Local $2l = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $1v)
If @error Then Return SetError(@error, @extended, 0)
Return $2l[0]
EndFunc
Func _34($4i)
Local $2l = DllCall("kernel32.dll", "handle", "LoadLibraryW", "wstr", $4i)
If @error Then Return SetError(@error, @extended, 0)
Return $2l[0]
EndFunc
Func _3f(ByRef $4j, $4k = 100)
Select
Case UBound($4j, $1j)
If $4k < 0 Then
ReDim $4j[$4j[0][0] + 1][UBound($4j, $1j)]
Else
$4j[0][0] += 1
If $4j[0][0] > UBound($4j) - 1 Then
ReDim $4j[$4j[0][0] + $4k][UBound($4j, $1j)]
EndIf
EndIf
Case UBound($4j, $1i)
If $4k < 0 Then
ReDim $4j[$4j[0] + 1]
Else
$4j[0] += 1
If $4j[0] > UBound($4j) - 1 Then
ReDim $4j[$4j[0] + $4k]
EndIf
EndIf
Case Else
Return 0
EndSelect
Return 1
EndFunc
Func _3h()
Local $4l = DllStructCreate($4f)
DllStructSetData($4l, 1, DllStructGetSize($4l))
Local $4m = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $4l)
If @error Or Not $4m[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($4l, 2), -8), DllStructGetData($4l, 3))
EndFunc
Func _4c($1v, ByRef $4n)
Local $2l = DllCall("user32.dll", "bool", "ScreenToClient", "hwnd", $1v, "struct*", $4n)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _4q($4o)
Local $2l = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $4o)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Global $4p[64][2] = [[0, 0]]
Func _5c($1v)
Local $2l = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $1v)
If @error Then Return SetError(@error, @extended, 0)
Return $2l[0]
EndFunc
Func _5k($1v, ByRef $40)
Local $2l = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $1v, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
$40 = $2l[2]
Return $2l[0]
EndFunc
Func _5m($1v, ByRef $4q)
If $1v = $4q Then Return True
For $4r = $4p[0][0] To 1 Step -1
If $1v = $4p[$4r][0] Then
If $4p[$4r][1] Then
$4q = $1v
Return True
Else
Return False
EndIf
EndIf
Next
Local $40
_5k($1v, $40)
Local $4s = $4p[0][0] + 1
If $4s >= 64 Then $4s = 1
$4p[0][0] = $4s
$4p[$4s][0] = $1v
$4p[$4s][1] =($40 = @AutoItPID)
Return $4p[$4s][1]
EndFunc
Func _5n($1v, $4t = 0, $4u = True)
Local $2l = DllCall("user32.dll", "bool", "InvalidateRect", "hwnd", $1v, "struct*", $4t, "bool", $4u)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _5v($1v, $4v, $4w, $4x, $4y, $4z, $50)
Local $2l = DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $1v, "hwnd", $4v, "int", $4w, "int", $4x, "int", $4y, "int", $4z, "uint", $50)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _7x($3v, $51)
Local $4m = DllCall('kernel32.dll', 'bool', 'IsBadReadPtr', 'struct*', $3v, 'uint_ptr', $51)
If @error Then Return SetError(@error, @extended, False)
Return $4m[0]
EndFunc
Func _7z($3v, $51)
Local $4m = DllCall('kernel32.dll', 'bool', 'IsBadWritePtr', 'struct*', $3v, 'uint_ptr', $51)
If @error Then Return SetError(@error, @extended, False)
Return $4m[0]
EndFunc
Func _82($52, $53, $51)
If _7x($53, $51) Then Return SetError(10, @extended, 0)
If _7z($52, $51) Then Return SetError(11, @extended, 0)
DllCall('ntdll.dll', 'none', 'RtlMoveMemory', 'struct*', $52, 'struct*', $53, 'ulong_ptr', $51)
If @error Then Return SetError(@error, @extended, 0)
Return 1
EndFunc
Func _8j($54 = False, $1v = 0)
Local $55 = Opt("MouseCoordMode", 1)
Local $56 = MouseGetPos()
Opt("MouseCoordMode", $55)
Local $4n = DllStructCreate($39)
DllStructSetData($4n, "X", $56[0])
DllStructSetData($4n, "Y", $56[1])
If $54 And Not _4c($1v, $4n) Then Return SetError(@error + 20, @extended, 0)
Return $4n
EndFunc
Func _8k($54 = False, $1v = 0)
Local $4n = _8j($54, $1v)
If @error Then Return SetError(@error, @extended, 0)
Return DllStructGetData($4n, "X")
EndFunc
Func _8l($54 = False, $1v = 0)
Local $4n = _8j($54, $1v)
If @error Then Return SetError(@error, @extended, 0)
Return DllStructGetData($4n, "Y")
EndFunc
Func _ck($57 = 0, $4t = 0)
Local $58 = DllCallbackRegister('_gw', 'bool', 'handle;handle;ptr;lparam')
Dim $4d[101][2] = [[0]]
Local $4m = DllCall('user32.dll', 'bool', 'EnumDisplayMonitors', 'handle', $57, 'struct*', $4t, 'ptr', DllCallbackGetPtr($58), 'lparam', 0)
If @error Or Not $4m[0] Or Not $4d[0][0] Then
$4d = @error + 10
EndIf
DllCallbackFree($58)
If $4d Then Return SetError($4d, 0, 0)
_3f($4d, -1)
Return $4d
EndFunc
Func _dt($4t)
Local $2l[4]
For $59 = 0 To 3
$2l[$59] = DllStructGetData($4t, $59 + 1)
If @error Then Return SetError(@error, @extended, 0)
Next
For $59 = 2 To 3
$2l[$59] -= $2l[$59 - 2]
Next
Return $2l
EndFunc
Func _es($1v, $5a = 1)
Local $4m = DllCall('user32.dll', 'handle', 'MonitorFromWindow', 'hwnd', $1v, 'dword', $5a)
If @error Then Return SetError(@error, @extended, 0)
Return $4m[0]
EndFunc
Func _gw($5b, $57, $5c, $47)
#forceref $57, $47
_3f($4d)
$4d[$4d[0][0]][0] = $5b
If Not $5c Then
$4d[$4d[0][0]][1] = 0
Else
$4d[$4d[0][0]][1] = DllStructCreate($3a)
If Not _82(DllStructGetPtr($4d[$4d[0][0]][1]), $5c, 16) Then Return 0
EndIf
Return 1
EndFunc
Global $5d
Global Const $5e = 11
Global $5f[1][$5e]
Global Const $5g = "uint Mask;int Fmt;int CX;ptr Text;int TextMax;int SubItem;int Image;int Order;int cxMin;int cxDefault;int cxIdeal"
Func _i8($1v, $5h, $5i = 50, $5j = -1, $5k = -1, $5l = False)
Return _lf($1v, _j7($1v), $5h, $5i, $5j, $5k, $5l)
EndFunc
Func _in($1v)
If _jy($1v) = 0 Then Return True
Local $5m = 0
If IsHWnd($1v) Then
$5m = _2z($1v)
Else
$5m = $1v
$1v = GUICtrlGetHandle($1v)
EndIf
If $5m < $4c Then
Local $5n = 0
For $1z = _jy($1v) - 1 To 0 Step -1
$5n = _k7($1v, $1z)
If GUICtrlGetState($5n) > 0 And GUICtrlGetHandle($5n) = 0 Then
GUICtrlDelete($5n)
EndIf
Next
If _jy($1v) = 0 Then Return True
EndIf
Return _2s($1v, $l) <> 0
EndFunc
Func _ix($1v, $1z, $5o = False)
If IsHWnd($1v) Then
Return _2s($1v, $m, $1z, $5o)
Else
Return GUICtrlSendMsg($1v, $m, $1z, $5o)
EndIf
EndFunc
Func _j7($1v)
Return _2s(_jn($1v), 0x1200)
EndFunc
Func _jn($1v)
If IsHWnd($1v) Then
Return HWnd(_2s($1v, $n))
Else
Return HWnd(GUICtrlSendMsg($1v, $n, 0, 0))
EndIf
EndFunc
Func _jx($1v, $1z)
Local $5p = _l3($1v)
Local $5q = DllStructCreate($3e)
Local $3p = DllStructGetSize($5q)
If @error Then Return SetError($0, $0, False)
DllStructSetData($5q, "Mask", $c)
DllStructSetData($5q, "Item", $1z)
DllStructSetData($5q, "StateMask", 0xffff)
Local $44
If IsHWnd($1v) Then
If _5m($1v, $5d) Then
$44 = _2s($1v, $p, 0, $5q, 0, "wparam", "struct*") <> 0
Else
Local $3l
Local $3m = _2j($1v, $3p, $3l)
_2m($3l, $5q)
If $5p Then
$44 = _2s($1v, $p, 0, $3m, 0, "wparam", "ptr") <> 0
Else
$44 = _2s($1v, $o, 0, $3m, 0, "wparam", "ptr") <> 0
EndIf
_2l($3l, $3m, $5q, $3p)
_2d($3l)
EndIf
Else
Local $24 = DllStructGetPtr($5q)
If $5p Then
$44 = GUICtrlSendMsg($1v, $p, 0, $24) <> 0
Else
$44 = GUICtrlSendMsg($1v, $o, 0, $24) <> 0
EndIf
EndIf
If Not $44 Then Return SetError($0, $0, False)
Return BitAND(DllStructGetData($5q, "State"), 0x2000) <> 0
EndFunc
Func _jy($1v)
If IsHWnd($1v) Then
Return _2s($1v, $q)
Else
Return GUICtrlSendMsg($1v, $q, 0, 0)
EndIf
EndFunc
Func _k1($1v, ByRef $23)
Local $5p = _l3($1v)
Local $44
If IsHWnd($1v) Then
If _5m($1v, $5d) Then
$44 = _2s($1v, $p, 0, $23, 0, "wparam", "struct*")
Else
Local $5r = DllStructGetSize($23)
Local $3l
Local $3m = _2j($1v, $5r, $3l)
_2m($3l, $23)
If $5p Then
_2s($1v, $p, 0, $3m, 0, "wparam", "ptr")
Else
_2s($1v, $o, 0, $3m, 0, "wparam", "ptr")
EndIf
_2l($3l, $3m, $23, $5r)
_2d($3l)
EndIf
Else
Local $24 = DllStructGetPtr($23)
If $5p Then
$44 = GUICtrlSendMsg($1v, $p, 0, $24)
Else
$44 = GUICtrlSendMsg($1v, $o, 0, $24)
EndIf
EndIf
Return $44 <> 0
EndFunc
Func _k7($1v, $1z)
Local $23 = DllStructCreate($3e)
DllStructSetData($23, "Mask", $b)
DllStructSetData($23, "Item", $1z)
_k1($1v, $23)
Return DllStructGetData($23, "Param")
EndFunc
Func _kj($1v, $1z, $20 = 0)
Local $5p = _l3($1v)
Local $21
If $5p Then
$21 = DllStructCreate("wchar Text[4096]")
Else
$21 = DllStructCreate("char Text[4096]")
EndIf
Local $22 = DllStructGetPtr($21)
Local $23 = DllStructCreate($3e)
DllStructSetData($23, "SubItem", $20)
DllStructSetData($23, "TextMax", 4096)
If IsHWnd($1v) Then
If _5m($1v, $5d) Then
DllStructSetData($23, "Text", $22)
_2s($1v, $t, $1z, $23, 0, "wparam", "struct*")
Else
Local $5r = DllStructGetSize($23)
Local $3l
Local $3m = _2j($1v, $5r + 4096, $3l)
Local $5s = $3m + $5r
DllStructSetData($23, "Text", $5s)
_2m($3l, $23, $3m, $5r)
If $5p Then
_2s($1v, $t, $1z, $3m, 0, "wparam", "ptr")
Else
_2s($1v, $s, $1z, $3m, 0, "wparam", "ptr")
EndIf
_2l($3l, $5s, $21, 4096)
_2d($3l)
EndIf
Else
Local $24 = DllStructGetPtr($23)
DllStructSetData($23, "Text", $22)
If $5p Then
GUICtrlSendMsg($1v, $t, $1z, $24)
Else
GUICtrlSendMsg($1v, $s, $1z, $24)
EndIf
EndIf
Return DllStructGetData($21, "Text")
EndFunc
Func _kl($1v, $5r = -1)
Local $5t = "", $5u = Opt('GUIDataSeparatorChar'), $5v
If $5r = -1 Then
$5v = _km($1v)
Else
$5v = $5r
EndIf
For $5w = 0 To _j7($1v) - 1
$5t &= _kj($1v, $5v, $5w) & $5u
Next
Return StringTrimRight($5t, 1)
EndFunc
Func _km($1v, $5x = -1, $5y = 0, $5z = 8)
Local $60[5] = [$1a, $16, $17, $18, $19]
Local $50 = $60[$5y]
If BitAND($5z, 1) <> 0 Then $50 = BitOR($50, $1b)
If BitAND($5z, 2) <> 0 Then $50 = BitOR($50, $1c)
If BitAND($5z, 4) <> 0 Then $50 = BitOR($50, $1d)
If BitAND($5z, 8) <> 0 Then $50 = BitOR($50, $1e)
If IsHWnd($1v) Then
Return _2s($1v, $u, $5x, $50)
Else
Return GUICtrlSendMsg($1v, $u, $5x, $50)
EndIf
EndFunc
Func _kt($1v)
If IsHWnd($1v) Then
Return _2s($1v, $v)
Else
Return GUICtrlSendMsg($1v, $v, 0, 0)
EndIf
EndFunc
Func _kv($1v, $61 = False)
Local $62, $63[1] = [0]
Local $44, $4s = _jy($1v)
For $5r = 0 To $4s
If IsHWnd($1v) Then
$44 = _2s($1v, $r, $5r, $e)
Else
$44 = GUICtrlSendMsg($1v, $r, $5r, $e)
EndIf
If $44 Then
If(Not $61) Then
If StringLen($62) Then
$62 &= "|" & $5r
Else
$62 = $5r
EndIf
Else
ReDim $63[UBound($63) + 1]
$63[0] = UBound($63) - 1
$63[UBound($63) - 1] = $5r
EndIf
EndIf
Next
If(Not $61) Then
Return String($62)
Else
Return $63
EndIf
EndFunc
Func _l3($1v)
If IsHWnd($1v) Then
Return _2s($1v, $w) <> 0
Else
Return GUICtrlSendMsg($1v, $w, 0, 0) <> 0
EndIf
EndFunc
Func _lf($1v, $1z, $5h, $5i = 50, $5j = -1, $5k = -1, $5l = False)
Local $64[3] = [$9, $a, $6]
Local $5p = _l3($1v)
Local $65 = StringLen($5h) + 1
Local $21
If $5p Then
$21 = DllStructCreate("wchar Text[" & $65 & "]")
$65 *= 2
Else
$21 = DllStructCreate("char Text[" & $65 & "]")
EndIf
Local $22 = DllStructGetPtr($21)
Local $66 = DllStructCreate($5g)
Local $67 = BitOR($1, $4, $3)
If $5j < 0 Or $5j > 2 Then $5j = 0
Local $68 = $64[$5j]
If $5k <> -1 Then
$67 = BitOR($67, $2)
$68 = BitOR($68, $7, $8)
EndIf
If $5l Then $68 = BitOR($68, $5)
DllStructSetData($21, "Text", $5h)
DllStructSetData($66, "Mask", $67)
DllStructSetData($66, "Fmt", $68)
DllStructSetData($66, "CX", $5i)
DllStructSetData($66, "TextMax", $65)
DllStructSetData($66, "Image", $5k)
Local $44
If IsHWnd($1v) Then
If _5m($1v, $5d) Then
DllStructSetData($66, "Text", $22)
$44 = _2s($1v, $y, $1z, $66, 0, "wparam", "struct*")
Else
Local $69 = DllStructGetSize($66)
Local $3l
Local $3m = _2j($1v, $69 + $65, $3l)
Local $5s = $3m + $69
DllStructSetData($66, "Text", $5s)
_2m($3l, $66, $3m, $69)
_2m($3l, $21, $5s, $65)
If $5p Then
$44 = _2s($1v, $y, $1z, $3m, 0, "wparam", "ptr")
Else
$44 = _2s($1v, $x, $1z, $3m, 0, "wparam", "ptr")
EndIf
_2d($3l)
EndIf
Else
Local $6a = DllStructGetPtr($66)
DllStructSetData($66, "Text", $22)
If $5p Then
$44 = GUICtrlSendMsg($1v, $y, $1z, $6a)
Else
$44 = GUICtrlSendMsg($1v, $x, $1z, $6a)
EndIf
EndIf
If $5j > 0 Then _ly($1v, $44, $5h, $5i, $5j, $5k, $5l)
Return $44
EndFunc
Func _ly($1v, $1z, $5h, $5i = -1, $5j = -1, $5k = -1, $5l = False)
Local $5p = _l3($1v)
Local $64[3] = [$9, $a, $6]
Local $65 = StringLen($5h) + 1
Local $21
If $5p Then
$21 = DllStructCreate("wchar Text[" & $65 & "]")
$65 *= 2
Else
$21 = DllStructCreate("char Text[" & $65 & "]")
EndIf
Local $22 = DllStructGetPtr($21)
Local $66 = DllStructCreate($5g)
Local $67 = $3
If $5j < 0 Or $5j > 2 Then $5j = 0
$67 = BitOR($67, $1)
Local $68 = $64[$5j]
If $5i <> -1 Then $67 = BitOR($67, $4)
If $5k <> -1 Then
$67 = BitOR($67, $2)
$68 = BitOR($68, $7, $8)
Else
$5k = 0
EndIf
If $5l Then $68 = BitOR($68, $5)
DllStructSetData($21, "Text", $5h)
DllStructSetData($66, "Mask", $67)
DllStructSetData($66, "Fmt", $68)
DllStructSetData($66, "CX", $5i)
DllStructSetData($66, "TextMax", $65)
DllStructSetData($66, "Image", $5k)
Local $44
If IsHWnd($1v) Then
If _5m($1v, $5d) Then
DllStructSetData($66, "Text", $22)
$44 = _2s($1v, $11, $1z, $66, 0, "wparam", "struct*")
Else
Local $69 = DllStructGetSize($66)
Local $3l
Local $3m = _2j($1v, $69 + $65, $3l)
Local $5s = $3m + $69
DllStructSetData($66, "Text", $5s)
_2m($3l, $66, $3m, $69)
_2m($3l, $21, $5s, $65)
If $5p Then
$44 = _2s($1v, $11, $1z, $3m, 0, "wparam", "ptr")
Else
$44 = _2s($1v, $10, $1z, $3m, 0, "wparam", "ptr")
EndIf
_2d($3l)
EndIf
Else
Local $6a = DllStructGetPtr($66)
DllStructSetData($66, "Text", $22)
If $5p Then
$44 = GUICtrlSendMsg($1v, $11, $1z, $6a)
Else
$44 = GUICtrlSendMsg($1v, $10, $1z, $6a)
EndIf
EndIf
Return $44 <> 0
EndFunc
Func _m1($1v, $6b, $5i)
If IsHWnd($1v) Then
Return _2s($1v, $12, $6b, $5i)
Else
Return GUICtrlSendMsg($1v, $12, $6b, $5i)
EndIf
EndFunc
Func _m2($1v, $6c, $6d = 0)
Local $44
If IsHWnd($1v) Then
$44 = _2s($1v, $13, $6d, $6c)
_5n($1v)
Else
$44 = GUICtrlSendMsg($1v, $13, $6d, $6c)
_5n(GUICtrlGetHandle($1v))
EndIf
Return $44
EndFunc
Func _md($1v, $1z, $6e = True)
Local $5p = _l3($1v)
Local $3m, $3l, $44
Local $23 = DllStructCreate($3e)
Local $24 = DllStructGetPtr($23)
Local $5r = DllStructGetSize($23)
If @error Then Return SetError($0, $0, $0)
If $1z <> -1 Then
DllStructSetData($23, "Mask", $c)
DllStructSetData($23, "Item", $1z)
If($6e) Then
DllStructSetData($23, "State", 0x2000)
Else
DllStructSetData($23, "State", 0x1000)
EndIf
DllStructSetData($23, "StateMask", 0xf000)
If IsHWnd($1v) Then
If _5m($1v, $5d) Then
Return _2s($1v, $15, 0, $23, 0, "wparam", "struct*") <> 0
Else
$3m = _2j($1v, $5r, $3l)
_2m($3l, $23)
If $5p Then
$44 = _2s($1v, $15, 0, $3m, 0, "wparam", "ptr")
Else
$44 = _2s($1v, $14, 0, $3m, 0, "wparam", "ptr")
EndIf
_2d($3l)
Return $44 <> 0
EndIf
Else
If $5p Then
Return GUICtrlSendMsg($1v, $15, 0, $24) <> 0
Else
Return GUICtrlSendMsg($1v, $14, 0, $24) <> 0
EndIf
EndIf
Else
For $5w = 0 To _jy($1v) - 1
DllStructSetData($23, "Mask", $c)
DllStructSetData($23, "Item", $5w)
If($6e) Then
DllStructSetData($23, "State", 0x2000)
Else
DllStructSetData($23, "State", 0x1000)
EndIf
DllStructSetData($23, "StateMask", 0xf000)
If IsHWnd($1v) Then
If _5m($1v, $5d) Then
If Not _2s($1v, $15, 0, $23, 0, "wparam", "struct*") <> 0 Then Return SetError($0, $0, $0)
Else
$3m = _2j($1v, $5r, $3l)
_2m($3l, $23)
If $5p Then
$44 = _2s($1v, $15, 0, $3m, 0, "wparam", "ptr")
Else
$44 = _2s($1v, $14, 0, $3m, 0, "wparam", "ptr")
EndIf
_2d($3l)
If Not $44 <> 0 Then Return SetError($0, $0, $0)
EndIf
Else
If $5p Then
If Not GUICtrlSendMsg($1v, $15, 0, $24) <> 0 Then Return SetError($0, $0, $0)
Else
If Not GUICtrlSendMsg($1v, $14, 0, $24) <> 0 Then Return SetError($0, $0, $0)
EndIf
EndIf
Next
Return True
EndIf
Return False
EndFunc
#Au3Stripper_Ignore_Funcs=__GUICtrlListView_Sort
Func __GUICtrlListView_Sort($1t, $1u, $1v)
Local $1z, $1w, $1x, $1y
For $5w = 1 To $5f[0][0]
If $1v = $5f[$5w][1] Then
$1z = $5w
ExitLoop
EndIf
Next
If $5f[$1z][3] = $5f[$1z][4] Then
If Not $5f[$1z][7] Then
$5f[$1z][5] *= -1
$5f[$1z][7] = 1
EndIf
Else
$5f[$1z][7] = 1
EndIf
$5f[$1z][6] = $5f[$1z][3]
$1w = _kj($1v, $1t, $5f[$1z][3])
$1x = _kj($1v, $1u, $5f[$1z][3])
If $5f[$1z][8] = 1 Then
If(StringIsFloat($1w) Or StringIsInt($1w)) Then $1w = Number($1w)
If(StringIsFloat($1x) Or StringIsInt($1x)) Then $1x = Number($1x)
EndIf
If $5f[$1z][8] < 2 Then
$1y = 0
If $1w < $1x Then
$1y = -1
ElseIf $1w > $1x Then
$1y = 1
EndIf
Else
$1y = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $1w, 'wstr', $1x)[0]
EndIf
$1y = $1y * $5f[$1z][5]
Return $1y
EndFunc
Global Const $6f = 0x00010000
Global Const $6g = 0x00020000
Global Const $6h = 0x00040000
Global Const $6i = 0x80000000
Global Const $6j = 0x00000040
Global Const $6k = 0x004E
Global Const $6l = 0
Global Const $6m = $6l - 2
Global Const $6n = $6l - 5
Global Const $6o = 2
Global Const $6p = -7
Global Const $6q = Ptr(-1)
Global Const $6r = Ptr(-1)
Global Const $6s = 0x0100
Global Const $6t = 0x2000
Global Const $6u = 0x8000
Global Const $6v = BitShift($6s, 8)
Global Const $6w = BitShift($6t, 8)
Global Const $6x = BitShift($6u, 8)
Func _sd($1v)
Local $6y = DllStructCreate($3j)
DllStructSetData($6y, "length", DllStructGetSize($6y))
Local $4m = DllCall("user32.dll", "bool", "GetWindowPlacement", "hwnd", $1v, "struct*", $6y)
If @error Or Not $4m[0] Then Return SetError(@error + 10, @extended, 0)
Return $6y
EndFunc
Func _sz($1v, $6y)
Local $2l = DllCall("user32.dll", "bool", "SetWindowPlacement", "hwnd", $1v, "struct*", $6y)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _u8($4h, $6z)
Local $70 = "str"
If IsNumber($6z) Then $70 = "word"
Local $2l = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", $4h, $70, $6z)
If @error Or Not $2l[0] Then Return SetError(@error, @extended, 0)
Return $2l[0]
EndFunc
Func _vb()
Local $2l = DllCall("user32.dll", "bool", "ReleaseCapture")
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _ve($1v)
Local $2l = DllCall("user32.dll", "hwnd", "SetCapture", "hwnd", $1v)
If @error Then Return SetError(@error, @extended, 0)
Return $2l[0]
EndFunc
Func _w0($1v, $45, $46, $47)
Local $4m = DllCall('comctl32.dll', 'lresult', 'DefSubclassProc', 'hwnd', $1v, 'uint', $45, 'wparam', $46, 'lparam', $47)
If @error Then Return SetError(@error, @extended, 0)
Return $4m[0]
EndFunc
Func _w6($1v, $71, $72)
Local $4m = DllCall('comctl32.dll', 'bool', 'RemoveWindowSubclass', 'hwnd', $1v, 'ptr', $71, 'uint_ptr', $72)
If @error Then Return SetError(@error, @extended, False)
Return $4m[0]
EndFunc
Func _w8($1v, $71, $72, $73 = 0)
Local $4m = DllCall('comctl32.dll', 'bool', 'SetWindowSubclass', 'hwnd', $1v, 'ptr', $71, 'uint_ptr', $72, 'dword_ptr', $73)
If @error Then Return SetError(@error, @extended, 0)
Return $4m[0]
EndFunc
Global Const $74 = 0x0
Global Const $75 = 0x00000800
Global Const $76 = $74
Global Const $77 = $75
Global Const $78 = 0x00000002
Global Const $79 = 0x00000004
Global Const $7a = 0x00000040
Global Const $7b = 0x00000100
Global Const $7c = 0x00000010
Global Const $7d = 0x04000000
Global Const $7e = 0x0
Global Const $7f = 0x0
Global Const $7g = 0x0
Global Const $7h = 0x00000002
Global Const $7i = 0x00000004
Global Const $7j = 0x00000008
Global Const $7k = 0x00000010
Global Const $7l = 0x00000020
Global Const $7m = 0x00000080
Global Const $7n = 0x00000100
Func _12z($7o, $5h, $7p = 0, $7q = 0)
Local $1z = _13h($7o)
Local $7r = DllStructCreate($3h)
DllStructSetData($7r, "Size", DllStructGetSize($7r))
DllStructSetData($7r, "ID", $7p)
DllStructSetData($7r, "SubMenu", $7q)
If $5h = "" Then
DllStructSetData($7r, "Mask", $7b)
DllStructSetData($7r, "Type", $77)
Else
DllStructSetData($7r, "Mask", BitOR($78, $7a, $79))
DllStructSetData($7r, "Type", $76)
Local $7s = DllStructCreate("wchar Text[" & StringLen($5h) + 1 & "]")
DllStructSetData($7s, "Text", $5h)
DllStructSetData($7r, "TypeData", DllStructGetPtr($7s))
EndIf
Local $2l = DllCall("user32.dll", "bool", "InsertMenuItemW", "handle", $7o, "uint", $1z, "bool", True, "struct*", $7r)
If @error Then Return SetError(@error, @extended, -1)
Return SetExtended($2l[0], $1z)
EndFunc
Func _135($7t = $7d)
Local $2l = DllCall("user32.dll", "handle", "CreatePopupMenu")
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] = 0 Then Return SetError(10, 0, 0)
_152($2l[0], $7t)
Return $2l[0]
EndFunc
Func _137($7o)
Local $2l = DllCall("user32.dll", "bool", "DestroyMenu", "handle", $7o)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _13h($7o)
Local $2l = DllCall("user32.dll", "int", "GetMenuItemCount", "handle", $7o)
If @error Then Return SetError(@error, @extended, -1)
Return $2l[0]
EndFunc
Func _151($7o, ByRef $7u)
DllStructSetData($7u, "Size", DllStructGetSize($7u))
Local $2l = DllCall("user32.dll", "bool", "SetMenuInfo", "handle", $7o, "struct*", $7u)
If @error Then Return SetError(@error, @extended, False)
Return $2l[0]
EndFunc
Func _152($7o, $7t)
Local $7u = DllStructCreate($3g)
DllStructSetData($7u, "Mask", $7c)
DllStructSetData($7u, "Style", $7t)
Return _151($7o, $7u)
EndFunc
Func _153($7o, $1v, $4w = -1, $4x = -1, $7v = 1, $7w = 1, $7x = 0, $7y = 0)
If $4w = -1 Then $4w = _8k()
If $4x = -1 Then $4x = _8l()
Local $50 = 0
Switch $7v
Case 1
$50 = BitOR($50, $7f)
Case 2
$50 = BitOR($50, $7j)
Case Else
$50 = BitOR($50, $7i)
EndSwitch
Switch $7w
Case 1
$50 = BitOR($50, $7g)
Case 2
$50 = BitOR($50, $7k)
Case Else
$50 = BitOR($50, $7l)
EndSwitch
If BitAND($7x, 1) <> 0 Then $50 = BitOR($50, $7m)
If BitAND($7x, 2) <> 0 Then $50 = BitOR($50, $7n)
Switch $7y
Case 1
$50 = BitOR($50, $7h)
Case Else
$50 = BitOR($50, $7e)
EndSwitch
Local $2l = DllCall("user32.dll", "bool", "TrackPopupMenu", "handle", $7o, "uint", $50, "int", $4w, "int", $4x, "int", 0, "hwnd", $1v, "ptr", 0)
If @error Then Return SetError(@error, @extended, 0)
Return $2l[0]
EndFunc
Global $7z = "0x13161C"
Global $80 = "0xFFFFFF"
Global $81 = "0x2D2D2D"
Global $82 = "0x00796b"
Global $83 = "0xFFFFFF"
Global $84 = "0xFFFFFF"
Global $85 = "DarkTealV2"
Global $86 = "0xD8D8D8"
Global $87 = "0x1a1a1a"
Func _154($88 = "DarkTeal")
$85 = $88
Switch($88)
Case "LightTeal"
$7z = "0xcccccc"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0x00796b"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "DarkTeal"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0x00796b"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkTealV2"
$7z = "0x13161C"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0x35635B"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkRuby"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0x712043"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkMidnightTeal"
$7z = "0x0A0D16"
$80 = "0xFFFFFF"
$81 = "0x242B47"
$82 = "0x336058"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkMidnightCyan"
$7z = "0x0A0D16"
$80 = "0xFFFFFF"
$81 = "0x242B47"
$82 = "0x0D5C63"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkMidnightBlue"
$7z = "0x0A0D16"
$80 = "0xFFFFFF"
$81 = "0x242B47"
$82 = "0x1A4F70"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkMidnight"
$7z = "0x0A0D16"
$80 = "0xFFFFFF"
$81 = "0x242B47"
$82 = "0x3C4D66"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkBlue"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x303030"
$82 = "0x1E648C"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkBlueV2"
$7z = "0x040D11"
$80 = "0xFFFFFF"
$81 = "0x303030"
$82 = "0x1E648C"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "LightBlue"
$7z = "0xcccccc"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0x244E80"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "LightCyan"
$7z = "0xD7D7D7"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0x00838f"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "DarkCyan"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0x00838f"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "LightGray"
$7z = "0xcccccc"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0x3F5863"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "LightGreen"
$7z = "0xD7D7D7"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0x2E7D32"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "DarkGreen"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0x5E8763"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkGreenV2"
$7z = "0x061319"
$80 = "0xFFFFFF"
$81 = "0x242B47"
$82 = "0x5E8763"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "LightRed"
$7z = "0xD7D7D7"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0xc62828"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "DarkGray"
$7z = "0x1B2428"
$80 = "0xFFFFFF"
$81 = "0x4F6772"
$82 = "0x607D8B"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "DarkAmber"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0xffa000"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "LightOrange"
$7z = "0xD7D7D7"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0xBC5E05"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "DarkOrange"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0xC76810"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "LightPurple"
$7z = "0xD7D7D7"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0x512DA8"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case "DarkPurple"
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0x512DA8"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
Case "LightPink"
$7z = "0xD7D7D7"
$80 = "0x000000"
$81 = "0xD8D8D8"
$82 = "0xE91E63"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xE8E8E8"
$87 = "0x1a1a1a"
Case Else
ConsoleWrite("Metro-UDF-Error: Theme not found, using default theme." & @CRLF)
$7z = "0x191919"
$80 = "0xFFFFFF"
$81 = "0x2D2D2D"
$82 = "0x00796b"
$83 = "0xFFFFFF"
$84 = "0xFFFFFF"
$86 = "0xD8D8D8"
$87 = "0x1a1a1a"
$85 = "DarkTealV2"
EndSwitch
EndFunc
Func _155($5h, $3p = 8.5, $89 = 400, $8a = 0, $2v = "", $8b = 0, $1v = 0)
If $3p = Default Then $3p = 8.5
If $89 = Default Then $89 = 400
If $8a = Default Then $8a = 0
If $2v = "" Or $2v = Default Then $2v = _157()
If Not IsString($5h) Then Return SetError(1, 1, 0)
If Not IsNumber($3p) Then Return SetError(1, 2, 0)
If Not IsInt($89) Then Return SetError(1, 3, 0)
If Not IsInt($8a) Then Return SetError(1, 4, 0)
If Not IsString($2v) Then Return SetError(1, 5, 0)
If Not IsNumber($8b) Then Return SetError(1, 6, 0)
If Not IsHwnd($1v) And $1v <> 0 Then Return SetError(1, 7, 0)
Local $4m, $57, $8c, $8d = 0, $8e
Local $8f = BitAnd($8a, 1)
$8a = BitAnd($8a, BitNot(1))
If IsHWnd($1v) Then
$8d = GUICtrlCreateLabel("", -10, -10, 10, 10)
$8e = GUICtrlGetHandle(-1)
GUICtrlSetFont(-1, $3p, $89, $8a, $2v)
$4m = DllCall("user32.dll", "handle", "GetDC", "hwnd", $8e)
If @error Or $4m[0] = 0 Then
GUICtrlDelete($8d)
Return SetError(2, 1, 0)
EndIf
$57 = $4m[0]
$4m = DllCall("user32.dll", "lparam", "SendMessage", "hwnd", $8e, "int", 0x0031, "wparam", 0, "lparam", 0)
If @error Or $4m[0] = 0 Then
GUICtrlDelete($8d)
Return SetError(2, _156(2, $57), 0)
EndIf
$8c = $4m[0]
Else
$4m = DllCall("user32.dll", "handle", "GetDC", "hwnd", $1v)
If @error Or $4m[0] = 0 Then Return SetError(2, 1, 0)
$57 = $4m[0]
$4m = DllCall("gdi32.dll", "int", "GetDeviceCaps", "handle", $57, "int", 90)
If @error Or $4m[0] = 0 Then Return SetError(2, _156(3, $57), 0)
Local $8g = $4m[0]
$4m = DllCall("gdi32.dll", "handle", "CreateFontW", "int", -$8g * $3p / 72, "int", 0, "int", 0, "int", 0, "int", $89, "dword", BitAND($8a, 2), "dword", BitAND($8a, 4), "dword", BitAND($8a, 8), "dword", 0, "dword", 0, "dword", 0, "dword", 5, "dword", 0, "wstr", $2v)
If @error Or $4m[0] = 0 Then Return SetError(2, _156(4, $57), 0)
$8c = $4m[0]
EndIf
$4m = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $57, "handle", $8c)
If @error Or $4m[0] = 0 Then Return SetError(2, _156(5, $57, $8c, $8d), 0)
Local $8h = $4m[0]
Local $8i[4], $8j, $8k = 0, $8l = 0, $8m = 0, $8n, $8o, $8p
Local $8q = DllStructCreate("int X;int Y")
DllStructSetData($8q, "X", 0)
DllStructSetData($8q, "Y", 0)
$5h = StringRegExpReplace($5h, "((?<!\x0d)\x0a|\x0d(?!\x0a))", @CRLF)
Local $8r = StringSplit($5h, @CRLF, 1)
For $59 = 1 To $8r[0]
If $8f Then
$8r[$59] = StringReplace($8r[$59], @TAB, " XXXXXXXX")
EndIf
$8j = StringLen($8r[$59])
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $57, "wstr", $8r[$59], "int", $8j, "ptr", DllStructGetPtr($8q))
If @error Then Return SetError(2, _156(6, $57, $8c, $8d), 0)
If DllStructGetData($8q, "X") > $8m Then $8m = DllStructGetData($8q, "X")
If DllStructGetData($8q, "Y") > $8k Then $8k = DllStructGetData($8q, "Y")
Next
If $8b <> 0 And $8m > $8b Then
For $8s = 1 To $8r[0]
$8j = StringLen($8r[$8s])
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $57, "wstr", $8r[$8s], "int", $8j, "ptr", DllStructGetPtr($8q))
If @error Then Return SetError(2, _156(6, $57, $8c, $8d), 0)
If DllStructGetData($8q, "X") < $8b - 4 Then
$8l += 1
$8i[0] &= $8r[$8s] & @CRLF
Else
$8n = 0
While 1
$8m = 0
$8o = 0
For $59 = 1 To StringLen($8r[$8s])
If StringMid($8r[$8s], $59, 1) = " " Then $8o = $59 - 1
$8p = StringMid($8r[$8s], 1, $59)
$8j = StringLen($8p)
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $57, "wstr", $8p, "int", $8j, "ptr", DllStructGetPtr($8q))
If @error Then Return SetError(2, _156(6, $57, $8c, $8d), 0)
$8m = DllStructGetData($8q, "X")
If $8m >= $8b - 4 Then ExitLoop
Next
If $59 > StringLen($8r[$8s]) Then
$8n += 1
$8i[0] &= $8p & @CRLF
ExitLoop
Else
$8n += 1
If $8o = 0 Then Return SetError(3, _156(0, $57, $8c, $8d), 0)
$8i[0] &= StringLeft($8p, $8o) & @CRLF
$8r[$8s] = StringTrimLeft($8r[$8s], $8o)
$8r[$8s] = StringStripWS($8r[$8s], 1)
EndIf
WEnd
$8l += $8n
EndIf
Next
If $8f Then
$8i[0] = StringRegExpReplace($8i[0], "\x20?XXXXXXXX", @TAB)
EndIf
$8i[1] = $8k
$8i[2] = $8b
$8i[3] =($8l * $8k) + 4
Else
Local $8i[4] = [$5h, $8k, $8m,($8r[0] * $8k) + 4]
EndIf
DllCall("gdi32.dll", "handle", "SelectObject", "handle", $57, "handle", $8h)
DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $8c)
DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $57)
If $8d Then GUICtrlDelete($8d)
Return $8i
EndFunc
Func _156($8t, $57 = 0, $8c = 0, $8d = 0)
If $8c <> 0 Then DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $8c)
If $57 <> 0 Then DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $57)
If $8d Then GUICtrlDelete($8d)
Return $8t
EndFunc
Func _157()
Local $8u = DllStructCreate("uint;int;int;int;int;int;byte[60];int;int;byte[60];int;int;byte[60];byte[60];byte[60]")
DLLStructSetData($8u, 1, DllStructGetSize($8u))
DLLCall("user32.dll", "int", "SystemParametersInfo", "int", 41, "int", DllStructGetSize($8u), "ptr", DllStructGetPtr($8u), "int", 0)
Local $8v = DllStructCreate("long;long;long;long;long;byte;byte;byte;byte;byte;byte;byte;byte;char[32]", DLLStructGetPtr($8u, 13))
If IsString(DllStructGetData($8v, 14)) Then
Return DllStructGetData($8v, 14)
Else
Return "Tahoma"
EndIf
EndFunc
Global Const $8w = 0x0026200A
Global Const $8x = 0
Global Const $8y = 5
Global $8z = 0
Global $90 = 0
Global $91 = 0
Global $92 = 0
Global $93 = 0
Global $94 = True
Func _15p($5i, $95, $96 = $8w, $97 = 0, $98 = 0)
Local $2l = DllCall($90, "uint", "GdipCreateBitmapFromScan0", "int", $5i, "int", $95, "int", $97, "int", $96, "struct*", $98, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[6]
EndFunc
Func _15r($99, $9a = 0xFF000000)
Local $2l = DllCall($90, "int", "GdipCreateHBITMAPFromBitmap", "handle", $99, "handle*", 0, "dword", $9a)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[2]
EndFunc
Func _15s($99)
Local $2l = DllCall($90, "int", "GdipDisposeImage", "handle", $99)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _161($9a = 0xFF000000)
Local $2l = DllCall($90, "int", "GdipCreateSolidFill", "int", $9a, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[2]
EndFunc
Func _162($9b)
Local $2l = DllCall($90, "int", "GdipDeleteBrush", "handle", $9b)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _16r($9c, $9d, $7t = 0, $9e = 3)
Local $2l = DllCall($90, "int", "GdipCreateFont", "handle", $9c, "float", $9d, "int", $7t, "int", $9e, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[5]
EndFunc
Func _16s($8c)
Local $2l = DllCall($90, "int", "GdipDeleteFont", "handle", $8c)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _16t($9f, $9g = 0)
Local $2l = DllCall($90, "int", "GdipCreateFontFamilyFromName", "wstr", $9f, "ptr", $9g, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[3]
EndFunc
Func _16v($9c)
Local $2l = DllCall($90, "int", "GdipDeleteFontFamily", "handle", $9c)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _175($9h, $9a = 0xFF000000)
Local $2l = DllCall($90, "int", "GdipGraphicsClear", "handle", $9h, "dword", $9a)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _177($1v)
Local $2l = DllCall($90, "int", "GdipCreateFromHWND", "hwnd", $1v, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[2]
EndFunc
Func _178($9h)
Local $2l = DllCall($90, "int", "GdipDeleteGraphics", "handle", $9h)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _17k($9h, $9i, $9j, $9k, $9l, $9m = 0)
_1dz($9m)
Local $2l = DllCall($90, "int", "GdipDrawLine", "handle", $9h, "handle", $9m, "float", $9i, "float", $9j, "float", $9k, "float", $9l)
_1e0()
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _17o($9h, $9n, $9o, $9p, $9q, $9m = 0)
_1dz($9m)
Local $2l = DllCall($90, "int", "GdipDrawRectangle", "handle", $9h, "handle", $9m, "float", $9n, "float", $9o, "float", $9p, "float", $9q)
_1e0()
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _17q($9h, $9r, $8c, $9s, $9t, $9b)
Local $2l = DllCall($90, "int", "GdipDrawString", "handle", $9h, "wstr", $9r, "int", -1, "handle", $8c, "struct*", $9s, "handle", $9t, "handle", $9b)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _17x($9h, $9n, $9o, $9p, $9q, $9b = 0)
_1dv($9b)
Local $2l = DllCall($90, "int", "GdipFillRectangle", "handle", $9h, "handle", $9b, "float", $9n, "float", $9o, "float", $9p, "float", $9q)
_1dw()
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _18l($9h, $9u)
If $9u < $8x Or $9u > $8y Then $9u = $8x
Local $2l = DllCall($90, "int", "GdipSetSmoothingMode", "handle", $9h, "int", $9u)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _18m($9h, $9v)
Local $2l = DllCall($90, "int", "GdipSetTextRenderingHint", "handle", $9h, "int", $9v)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _193($9w)
Local $2l = DllCall($90, "int", "GdipGetImageGraphicsContext", "handle", $9w, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[2]
EndFunc
Func _1ce($9a = 0xFF000000, $9p = 1, $9e = 2)
Local $2l = DllCall($90, "int", "GdipCreatePen1", "dword", $9a, "float", $9p, "int", $9e, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[4]
EndFunc
Func _1cg($9m)
Local $2l = DllCall($90, "int", "GdipDeletePen", "handle", $9m)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _1d5($9n = 0, $9o = 0, $9p = 0, $9q = 0)
Local $9x = DllStructCreate($3c)
DllStructSetData($9x, "X", $9n)
DllStructSetData($9x, "Y", $9o)
DllStructSetData($9x, "Width", $9p)
DllStructSetData($9x, "Height", $9q)
Return $9x
EndFunc
Func _1dk()
If $90 = 0 Then Return SetError(-1, -1, False)
$92 -= 1
If $92 = 0 Then
DllCall($90, "none", "GdiplusShutdown", "ulong_ptr", $93)
DllClose($90)
$90 = 0
EndIf
Return True
EndFunc
Func _1dl($9y = Default, $9z = False)
$92 += 1
If $92 > 1 Then Return True
If $9y = Default Then $9y = "gdiplus.dll"
$90 = DllOpen($9y)
If $90 = -1 Then
$92 = 0
Return SetError(1, 2, False)
EndIf
Local $a0 = FileGetVersion($9y)
$a0 = StringSplit($a0, ".")
If $a0[1] > 5 Then $94 = False
Local $a1 = DllStructCreate($3d)
Local $a2 = DllStructCreate("ulong_ptr Data")
DllStructSetData($a1, "Version", 1)
Local $2l = DllCall($90, "int", "GdiplusStartup", "struct*", $a2, "struct*", $a1, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
$93 = DllStructGetData($a2, "Data")
If $9z Then Return $90
Return SetExtended($a0[1], True)
EndFunc
Func _1dm($a3 = 0, $a4 = 0)
Local $2l = DllCall($90, "int", "GdipCreateStringFormat", "int", $a3, "word", $a4, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2l[0] Then Return SetError(10, $2l[0], 0)
Return $2l[3]
EndFunc
Func _1dn($9t)
Local $2l = DllCall($90, "int", "GdipDeleteStringFormat", "handle", $9t)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _1dp($a5, $5a)
Local $2l = DllCall($90, "int", "GdipSetStringFormatAlign", "handle", $a5, "int", $5a)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _1dq($a5, $a6)
Local $2l = DllCall($90, "int", "GdipSetStringFormatLineAlign", "handle", $a5, "int", $a6)
If @error Then Return SetError(@error, @extended, False)
If $2l[0] Then Return SetError(10, $2l[0], False)
Return True
EndFunc
Func _1dv(ByRef $9b)
If $9b = 0 Then
$8z = _161()
$9b = $8z
EndIf
EndFunc
Func _1dw($a7 = @error, $a8 = @extended)
If $8z <> 0 Then
_162($8z)
$8z = 0
EndIf
Return SetError($a7, $a8)
EndFunc
Func _1dz(ByRef $9m)
If $9m = 0 Then
$91 = _1ce()
$9m = $91
EndIf
EndFunc
Func _1e0($a7 = @error, $a8 = @extended)
If $91 <> 0 Then
_1cg($91)
$91 = 0
EndIf
Return SetError($a7, $a8)
EndFunc
Local $a9[0]
Local Const $aa = _34('comctl32.dll')
_1f7($aa <> 0, 'This UDF requires comctl32.dll')
Local Const $ab = _u8($aa, 'DefSubclassProc')
Local Const $ac = DllCallbackRegister('_1et', 'NONE', 'HWND;UINT;WPARAM;LPARAM;DWORD')
Local Const $ad = DllCallbackGetPtr($ac)
OnAutoItExitRegister("_1f6")
Local Const $ae = Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86')
Local Const $af = DllCall('kernel32.dll', 'HANDLE', 'HeapCreate', 'DWORD', 0x00040000, 'ULONG_PTR', 0, 'ULONG_PTR', 0)[0]
_1f7($af <> 0, 'Failed to create executable heap object')
Local Const $ag = _1f4(Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86'))
Func _1es($ah, $ai = '', $aj = '', $ak = '', $al = '', $am = 0,$an = 0,$ao = '')
Local $1v = GUICtrlGetHandle($ah)
If(Not(IsHWnd($1v))) Then Return SetError(1, 0, -1)
Local $ap = _1f8($1v)
Local $4j[13]
$4j[0] = $1v
$4j[1] = $ah
$4j[3] = $ai
$4j[4] = $am
$4j[5] = $aj
$4j[6] = $am
$4j[7] = $ao
$4j[8] = $an
$4j[9] = $ak
$4j[10] = $an
$4j[11] = $al
$4j[12] = $an
$a9[$ap] = $4j
_w8($1v, $ag, $1v, $ap)
Return $ap
EndFunc
Func _1et($1v, $aq, $46, $47, $ar)
Switch $aq
Case 0x0200
GUISetCursor(2, 1)
_1ev($a9[$ar], $1v, $aq, $46, $47)
Case 0x0201
_1eu($a9[$ar], $1v, $aq, $46, $47)
Case 0x0202
_1ew($a9[$ar], $1v, $aq, $46, $47)
Return False
Case 0x0203
_1ex($a9[$ar], $1v, $aq, $46, $47)
Case 0x0204
_1ey($a9[$ar], $1v, $aq, $46, $47)
Case 0x02A3
_1ez($a9[$ar], $1v, $aq, $46, $47)
Case 0x0082
_1f5($ar, $1v)
EndSwitch
Return True
EndFunc
Func _1eu(ByRef $as, $1v, $aq, ByRef $46, ByRef $47)
_ve($1v)
_1f0($as, 9)
EndFunc
Func _1ev(ByRef $as, $1v, $aq, ByRef $46, ByRef $47)
If(_1f9() = $1v) Then
Local $at = _1f2($1v, $47)
If Not $as[2] Then
If $at Then
$as[2] = 1
_1f0($as, 9)
EndIf
Else
If Not $at Then
$as[2] = 0
_1f0($as, 3)
EndIf
EndIf
ElseIf Not $as[2] Then
$as[2] = 1
_1f0($as, 5)
Local $au = DllStructCreate('DWORD;DWORD;HWND;DWORD')
DllStructSetData($au, 1, DllStructGetSize($au))
DllStructSetData($au, 2, 2)
DllStructSetData($au, 3, $1v)
DllCall('user32.dll', 'BOOL', 'TrackMouseEvent', 'STRUCT*', $au)
EndIf
EndFunc
Func _1ew(ByRef $as, $1v, $aq, ByRef $46, ByRef $47)
Local $av = _w0($1v, $aq, $46, $47)
If(_1f9() = $1v) Then
_vb()
If _1f2($1v, $47) Then
_1f0($as, 9)
EndIf
EndIf
Return $av
EndFunc
Func _1ex(ByRef $as, $1v, $aq, ByRef $46, ByRef $47)
_1f0($as, 11)
EndFunc
Func _1ey(ByRef $as, $1v, $aq, ByRef $46, ByRef $47)
_1f0($as, 7)
EndFunc
Func _1ez(ByRef $as, $1v, $aq, ByRef $46, ByRef $47)
$as[2] = 0
_1f0($as, 3)
EndFunc
Func _1f0(ByRef $as, $aw)
Call($as[$aw], $as[1], $as[$aw + 1])
EndFunc
Func _1f1(ByRef $ax, Const $ay = Default, Const $az = Default, Const $b0 = Default, Const $b1 = Default, Const $b2 = Default)
While(UBound($ax) <($ax[0] + @NumParams))
ReDim $ax[UBound($ax) * 2]
WEnd
If Not($ay = Default) Then
$ax[0] += 1
$ax[$ax[0]] = $ay
EndIf
If Not($az = Default) Then
$ax[0] += 1
$ax[$ax[0]] = $az
EndIf
If Not($b0 = Default) Then
$ax[0] += 1
$ax[$ax[0]] = $b0
EndIf
If Not($b1 = Default) Then
$ax[0] += 1
$ax[$ax[0]] = $b1
EndIf
If Not($b2 = Default) Then
$ax[0] += 1
$ax[$ax[0]] = $b2
EndIf
EndFunc
Func _1f2($1v, $47)
Local $4w = BitShift(BitShift($47, -16), 16)
Local $4x = BitShift($47, 16)
Local $b3 = WinGetClientSize($1v)
Return Not($4w < 0 Or $4x < 0 Or $4w > $b3[0] Or $4x > $b3[1])
EndFunc
Func _cHvr_CSCP_X86()
Local $b4 = 'align 1;'
Local $b5[100]
$b5[0] = 0
Local $b6[5]
Local $b7[5]
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x55)
_1f1($b5, 0x8B, 0xEC)
$b4 &= 'BYTE;'
_1f1($b5, 0x53)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x8B, 0x5D, 16)
$b4 &= 'BYTE;'
_1f1($b5, 0x56)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x8B, 0x75, 12)
$b4 &= 'BYTE;'
_1f1($b5, 0x57)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x8B, 0x7D, 20)
$b4 &= 'BYTE;BYTE;DWORD;'
_1f1($b5, 0x81, 0xFE, 0x82)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x74, 0)
$b6[0] = DllStructGetSize(DllStructCreate($b4))
$b7[0] = $b5[0]
$b4 &= 'BYTE;BYTE;DWORD;'
_1f1($b5, 0x81, 0xFE, 0x2A3)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x74, 0)
$b6[1] = DllStructGetSize(DllStructCreate($b4))
$b7[1] = $b5[0]
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x8D, 0x86, -0x200)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x83, 0xF8, 3)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x77, 0)
$b6[2] = DllStructGetSize(DllStructCreate($b4))
$b7[2] = $b5[0]
$b5[$b7[0]] = $b6[2] - $b6[0]
$b5[$b7[1]] = $b6[2] - $b6[1]
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x8B, 0x4D, 28)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x8B, 0x55, 8)
$b4 &= 'BYTE;'
_1f1($b5, 0x51)
$b4 &= 'BYTE;'
_1f1($b5, 0x57)
$b4 &= 'BYTE;'
_1f1($b5, 0x53)
$b4 &= 'BYTE;'
_1f1($b5, 0x56)
$b4 &= 'BYTE;'
_1f1($b5, 0x52)
$b4 &= 'BYTE;PTR;'
_1f1($b5, 0xB8, $ad)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0xFF, 0xD0)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x85, 0xC0)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x74, 0)
$b6[3] = DllStructGetSize(DllStructCreate($b4))
$b7[3] = $b5[0]
$b5[$b7[2]] = $b6[3] - $b6[2]
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x8B, 0x45, 8)
$b4 &= 'BYTE;'
_1f1($b5, 0x57)
$b4 &= 'BYTE;'
_1f1($b5, 0x53)
$b4 &= 'BYTE;'
_1f1($b5, 0x56)
$b4 &= 'BYTE;'
_1f1($b5, 0x50)
$b4 &= 'BYTE;PTR;'
_1f1($b5, 0xB8, $ab)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0xFF, 0xD0)
$b6[4] = DllStructGetSize(DllStructCreate($b4))
$b5[$b7[3]] = $b6[4] - $b6[3]
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x5F)
_1f1($b5, 0x5E)
_1f1($b5, 0x5B)
$b4 &= 'BYTE;BYTE;BYTE;WORD'
_1f1($b5, 0x5D)
_1f1($b5, 0xC2, 24)
Return _1f3($b4, $b5)
EndFunc
Func _cHvr_CSCP_X64()
Local $b4 = 'align 1;'
Local $b5[100]
$b5[0] = 0
Local $b6[5]
Local $b7[5]
$b4 &= 'BYTE;BYTE;DWORD;'
_1f1($b5, 0x81, 0xFA, 0x82)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x74, 0)
$b6[0] = DllStructGetSize(DllStructCreate($b4))
$b7[0] = $b5[0]
$b4 &= 'BYTE;BYTE;DWORD;'
_1f1($b5, 0x81, 0xFA, 0x2A3)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x74, 0)
$b6[1] = DllStructGetSize(DllStructCreate($b4))
$b7[1] = $b5[0]
$b4 &= 'BYTE;BYTE;DWORD;'
_1f1($b5, 0x8D, 0x82, -0x200)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x83, 0xF8, 3)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x77, 0)
$b6[2] = DllStructGetSize(DllStructCreate($b4))
$b7[2] = $b5[0]
$b5[$b7[0]] = $b6[2] - $b6[0]
$b5[$b7[1]] = $b6[2] - $b6[1]
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x89, 0x5C, 0x24, 8)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x89, 0x6C, 0x24, 16)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x89, 0x74, 0x24, 24)
$b4 &= 'BYTE;'
_1f1($b5, 0x57)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x83, 0xEC, 48)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x49, 0x8B, 0xF9)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x49, 0x8B, 0xF0)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x8B, 0xDA)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x8B, 0xE9)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x8B, 0x44, 0x24, 104)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x89, 0x44, 0x24, 32)
$b4 &= 'BYTE;BYTE;PTR;'
_1f1($b5, 0x48, 0xB8, $ad)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0xFF, 0xD0)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x85, 0xC0)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x74, 0)
$b6[3] = DllStructGetSize(DllStructCreate($b4))
$b7[3] = $b5[0]
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x4C, 0x8B, 0xCF)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x4C, 0x8B, 0xC6)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x8B, 0xD3)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x8B, 0xCD)
$b5[$b7[3]] = DllStructGetSize(DllStructCreate($b4)) - $b6[3]
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x8B, 0x5C, 0x24, 64)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x8B, 0x6C, 0x24, 72)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x8B, 0x74, 0x24, 80)
$b4 &= 'BYTE;BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x83, 0xc4, 48)
$b4 &= 'BYTE;'
_1f1($b5, 0x5F)
$b4 &= 'BYTE;BYTE;BYTE;'
_1f1($b5, 0x48, 0x85, 0xC0)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0x74, 0)
$b6[4] = DllStructGetSize(DllStructCreate($b4))
$b7[4] = $b5[0]
$b5[$b7[2]] = DllStructGetSize(DllStructCreate($b4)) - $b6[2]
$b4 &= 'BYTE;BYTE;PTR;'
_1f1($b5, 0x48, 0xB8, $ab)
$b4 &= 'BYTE;BYTE;'
_1f1($b5, 0xFF, 0xE0)
$b5[$b7[4]] = DllStructGetSize(DllStructCreate($b4)) - $b6[4]
$b4 &= 'BYTE;'
_1f1($b5, 0xC3)
Return _1f3($b4, $b5)
EndFunc
Func _1f3(ByRef $b4, ByRef $b5)
Local $b8 = DllStructCreate($b4)
_1f7(@error = 0, 'DllStrucCreate Failed With Error = ' & @error)
For $59 = 1 To $b5[0]
DllStructSetData($b8, $59, $b5[$59])
Next
Return $b8
EndFunc
Func _1f4($b8)
Local $b9 = DllCall('kernel32.dll', 'PTR', 'HeapAlloc', 'HANDLE', $af, 'DWORD', 8, 'ULONG_PTR', DllStructGetSize($b8))[0]
_1f7($b9 <> 0, 'Allocate memory failed')
DllCall("kernel32.dll", "none", "RtlMoveMemory", "PTR", $b9, "PTR", DllStructGetPtr($b8), "ULONG_PTR", DllStructGetSize($b8))
_1f7(@error = 0, 'Failed to copy memory')
Return $b9
EndFunc
Func _1f5($ar, $1v)
_w6($1v, $ag, $1v)
Local $4j=$a9[$ar]
$a9[$ar] = 0
Call( "_iControlDelete",$4j[1])
EndFunc
Func _1f6()
DllCallbackFree($ac)
_2x($aa)
If($af <> 0) Then
If($ag <> 0) Then
DllCall('kernel32.dll', 'BOOL', 'HeapFree', 'HANDLE', $af, 'DWORD', 0, 'PTR', $ag)
EndIf
DllCall('kernel32.dll', 'BOOL', 'HeapDestroy', 'HANDLE', $af)
EndIf
EndFunc
Func _1f7($ba, $bb = '', $bc = @ScriptName, $bd = @ScriptFullPath, $be = @ScriptLineNumber, $42 = @error, $bf = @extended)
If(Not($ba)) Then
MsgBox(BitOR(1, 0x10), 'Assertion Error!', @CRLF & 'Script' & @TAB & ': ' & $bc & @CRLF & 'Path' & @TAB & ': ' & $bd & @CRLF & 'Line' & @TAB & ': ' & $be & @CRLF & 'Error' & @TAB & ': ' &($42 > 0x7FFF ? Hex($42) : $42) &($bf <> 0 ? '  (Extended : ' &($bf > 0x7FFF ? Hex($bf) : $bf) & ')' : '') & @CRLF & 'Message' & @TAB & ': ' & $bb & @CRLF & @CRLF & 'OK: Exit Script' & @TAB & 'Cancel: Continue')
Exit
EndIf
EndFunc
Func _1f8($1v)
For $59 = 0 To UBound($a9) - 1 Step +1
If Not IsArray($a9[$59]) Then
Return $59
EndIf
Next
ReDim $a9[UBound($a9) + 1]
Return UBound($a9) - 1
EndFunc
Func _1f9()
Return DllCall("user32.dll", "HWND", "GetCapture")[0]
EndFunc
_1dl()
Opt("WinWaitDelay", 0)
Global $bg = _1gn()[2], $bh = _1gu()
Global $bi[0], $bj[0]
Global $bk = 0
Global $bl = Number(29 * $bh, 1) + Number(10 * $bh, 1)
Global Const $bm = DllCallbackRegister('_1gw', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
Global Const $bn = DllCallbackGetPtr($bm)
OnAutoItExitRegister('_1gx')
Global Const $bo = 4 * $bh
Global $bp = False
Global $bq = True
Global $br = False
If Opt("GUIOnEventMode", 0) Then
Opt("GUIOnEventMode", 1)
$br = True
EndIf
Func _1fa($bs, $bt, $bu, $bv = -1, $bw = -1, $bx = False, $by = "")
Local $bz
If $bp Then
$bt = Round($bt * $bh)
$bu = Round($bu * $bh)
EndIf
Local $c0
If $bx Then
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$bz = GUICreate($bs, $bt, $bu, $bv, $bw, BitOR($6h, $6g, $6f), -1, $by)
$c0 = _1fb($bz, True, True, $bt, $bu)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Else
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$bz = GUICreate($bs, $bt, $bu, $bv, $bw, -1, -1, $by)
$c0 = _1fb($bz, False, False, $bt, $bu)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
EndIf
_w8($bz, $bn, 1010, $c0)
WinMove($bz, "", Default, Default, $bt, $bu)
If Not $by Then
Local $c1 = _1gy($bz)
If($bv = -1) And($bw = -1) Then
WinMove($bz, "",($c1[2] - $bt) / 2,($c1[3] - $bu) / 2, $bt, $bu)
EndIf
Else
If($bv = -1) And($bw = -1) Then
Local $c2 = _1gt($by, $bt, $bu)
WinMove($bz, "", $c2[0], $c2[1], $bt, $bu)
EndIf
EndIf
GUISetBkColor($7z)
_1gs($bz, $bt, $bu, $81)
Return($bz)
EndFunc
Func _1fb($c3, $c4 = False, $bx = False, $c5 = "", $c6 = "")
Local $c7
For $c8 = 0 To UBound($bj) - 1 Step +1
If $bj[$c8][0] = $c3 Then
$c7 = $c8
ExitLoop
EndIf
Next
If($c7 == "") Then
$c7 = UBound($bj)
ReDim $bj[$c7 + 1][16]
EndIf
$bj[$c7][0] = $c3
$bj[$c7][1] = $c4
$bj[$c7][2] = $bx
If $bx Then
If $c5 = "" Then
$c5 = WinGetPos($c3, "")
If @error Then
$c5 = 80 * $bh
Else
$c5 = $c5[2]
EndIf
EndIf
If $c6 = "" Then
$c6 = WinGetPos($c3, "")
If @error Then
$c6 = 50 * $bh
Else
$c6 = $c6[3]
EndIf
EndIf
$bj[$c7][3] = $c5
$bj[$c7][4] = $c6
EndIf
Return $c7
EndFunc
Func _1fc($c9)
GUISetState(@SW_HIDE, $c9)
_w6($c9, $bn, 1010)
GUIDelete($c9)
Local $ca[0]
For $cb = 0 To UBound($bj) - 1 Step +1
If $bj[$cb][0] <> $c9 Then
ReDim $ca[UBound($ca) + 1][16]
For $cc = 0 To 11 Step +1
$ca[UBound($ca) - 1][$cc] = $bj[$cb][$cc]
Next
EndIf
Next
$bj = $ca
EndFunc
Func _iControlDelete($cd)
For $59 = 0 To UBound($bi) - 1
If $bi[$59][0] = $cd Then
Switch($bi[$59][3])
Case "5", "7"
_4q($bi[$59][5])
_4q($bi[$59][6])
_4q($bi[$59][7])
_4q($bi[$59][8])
Case "6"
_4q($bi[$59][5])
_4q($bi[$59][6])
_4q($bi[$59][7])
_4q($bi[$59][8])
_4q($bi[$59][9])
_4q($bi[$59][10])
_4q($bi[$59][11])
_4q($bi[$59][12])
_4q($bi[$59][13])
_4q($bi[$59][14])
Case Else
_4q($bi[$59][5])
_4q($bi[$59][6])
EndSwitch
For $ce = 0 To UBound($bi, 2) - 1
$bi[$59][$ce] = ""
Next
ExitLoop
EndIf
Next
EndFunc
Func _1fd($cf = True, $cg = True, $ch = True, $ci = False, $cj = False, $ck = $7z, $cl = $80, $cm = 2)
Local $cn[5]
$cn[0] = $cf
$cn[1] = $cg
$cn[2] = $ch
$cn[3] = $ci
$cn[4] = $cj
$ck = "0xFF" & Hex($ck, 6)
$cl = "0xFF" & Hex($cl, 6)
Return _1fl($cn, $ck, $cl, False, $cm)
EndFunc
Func _1fg($c3)
GUISetState(@SW_SHOW, $c3)
Local $c7 = _1gz($c3)
If($c7 == "") Then
ConsoleWrite("Fullscreen-Toggle failed: GUI not registered. Not created with _Metro_CreateGUI ?" & @CRLF)
Return SetError(1)
EndIf
If Not $bj[$c7][2] Then
ConsoleWrite("Fullscreen-Toggle failed: GUI is not registered for resizing. Please use _Metro_SetGUIOption to enable resizing." & @CRLF)
Return SetError(2)
EndIf
Local $co = WinGetState($c3)
Local $cp = _sd($c3)
Local $cq = _1gy($c3, True)
Local $cr = WinGetPos($c3)
Local $cs = _1gv("3", $c3)
Local $ct = _1gv("4", $c3)
Local $ci = _1gv("9", $c3)
Local $cu = _1gv("10", $c3)
If $bj[$c7][11] Then
$bj[$c7][11] = False
If(BitAND($bj[$c7][9], 32) = 32) Then
GUISetState(@SW_MAXIMIZE)
$cp = $bj[$c7][10]
DllStructSetData($cp, "rcNormalPosition", $bj[$c7][5], 1)
DllStructSetData($cp, "rcNormalPosition", $bj[$c7][6], 2)
DllStructSetData($cp, "rcNormalPosition", $bj[$c7][7], 3)
DllStructSetData($cp, "rcNormalPosition", $bj[$c7][8], 4)
_sz($c3, $cp)
If $cs Then
GUICtrlSetState($cs, 32)
GUICtrlSetState($ct, 16)
EndIf
Else
WinMove($c3, "", $bj[$c7][5], $bj[$c7][6], $bj[$c7][7], $bj[$c7][8])
If $cs Then
GUICtrlSetState($ct, 32)
GUICtrlSetState($cs, 16)
EndIf
EndIf
GUICtrlSetState($cu, 32)
GUICtrlSetState($ci, 16)
Else
If(BitAND($co, 32) = 32) Then
$cr[0] = DllStructGetData($cp, "rcNormalPosition", 1)
$cr[1] = DllStructGetData($cp, "rcNormalPosition", 2)
$cr[2] = DllStructGetData($cp, "rcNormalPosition", 3)
$cr[3] = DllStructGetData($cp, "rcNormalPosition", 4)
DllStructSetData($cp, "rcNormalPosition", $cq[0], 1)
DllStructSetData($cp, "rcNormalPosition", $cq[1], 2)
DllStructSetData($cp, "rcNormalPosition", $cq[0] + $cq[2], 3)
DllStructSetData($cp, "rcNormalPosition", $cq[1] + $cq[3], 4)
_sz($c3, $cp)
Sleep(50)
$bj[$c7][10] = $cp
GUISetState(@SW_RESTORE)
Else
Sleep(50)
WinMove($c3, "", $cq[0], $cq[1], $cq[2], $cq[3])
EndIf
$bj[$c7][11] = True
GUICtrlSetState($ci, 32)
If $cs Then
GUICtrlSetState($cs, 32)
GUICtrlSetState($ct, 32)
EndIf
GUICtrlSetState($cu, 16)
$bj[$c7][5] = $cr[0]
$bj[$c7][6] = $cr[1]
$bj[$c7][7] = $cr[2]
$bj[$c7][8] = $cr[3]
$bj[$c7][9] = $co
WinActivate("[CLASS:Shell_TrayWnd]")
WinActivate($c3)
EndIf
EndFunc
Func _1fi($c3, $cv, $cw, $cx = "Segoe UI", $cy = 9, $cz = 0)
Local $d0 = _1gv("8", $c3)
If Not $d0 Then Return SetError(1)
GUICtrlSetState($d0, 128)
Local $d1[UBound($cw)]
Local $d2 = _1gk()
Local $d3 = True
Local $d4 = WinGetPos($c3)
Local $d5 = Number(2 * $d2, 1)
Local $d6 = Number(29 * $d2, 1)
Local $d7 = $d4[3] -($d5 * 2) - $d6
Local $d8 = $cv * $d2
Local $d9 = $d4[0] + $d5, $da = $d4[1] + $d5 + $d6
Local $db = $d8 / 10, $dc = $db
Local $dd = GUICreate("", $dc, $d7, $d9, $da, $6i, $6j, $c3)
Local $de =(30 * $d2)
If StringInStr($85, "Light") Then
GUISetBkColor(_1gq($7z, -10), $dd)
Else
GUISetBkColor(_1gq($7z, +10), $dd)
EndIf
For $df = 0 To UBound($cw) - 1 Step +1
$d1[$df] = _1fj($cw[$df], 0, $de * $df +($df * 2), $d8 - $d5, 30 * $d2, $7z, $80, $cx, $cy, $cz)
Next
GUISetState(@SW_SHOW, $dd)
For $59 = 0 To 8 Step +1
$dc = $dc + $db
WinMove($dd, "", $d9, $da, $dc, $d7)
Sleep(1)
Next
If $br Then Opt("GUIOnEventMode", 0)
While 1
If Not $d3 Then
If Not WinActive($dd) Then
$d4 = WinGetPos($c3)
$d9 = $d4[0] + $d5
$da = $d4[1] + $d5 + $d6
For $59 = 0 To 8 Step +1
$dc = $dc - $db
WinMove($dd, "", $d9, $da, $dc, $d7)
Sleep(1)
Next
GUIDelete($dd)
If $br Then Opt("GUIOnEventMode", 1)
GUICtrlSetState($d0, 64)
Return SetError(1, 0, "none")
EndIf
Else
$d3 = False
EndIf
Local $45 = GUIGetMsg()
For $df = 0 To UBound($d1) - 1 Step +1
If $45 = $d1[$df] Then
$d4 = WinGetPos($c3)
$d9 = $d4[0] + $d5
$da = $d4[1] + $d5 + $d6
For $dg = 0 To 8 Step +2
$dc = $dc - $db
WinMove($dd, "", $d9, $da, $dc, $d7)
Sleep(1)
Next
GUIDelete($dd)
If $br Then Opt("GUIOnEventMode", 1)
GUICtrlSetState($d0, 64)
Return $df
EndIf
Next
WEnd
EndFunc
Func _1fj($dh, $bv, $bw, $bt, $bu, $di = $7z, $dj = $80, $dk = "Arial", $dl = 9, $dm = 1)
Local $dn[16]
If Not $bp Then
$dl =($dl / $bg)
EndIf
$dn[1] = False
$dn[3] = "2"
$dn[15] = _1gj()
$di = StringReplace($di, "0x", "0xFF")
$dj = StringReplace($dj, "0x", "0xFF")
Local $do = _161($dj)
If StringInStr($85, "Light") Then
Local $dp = StringReplace(_1gq($7z, -12), "0x", "0xFF")
$di = StringReplace(_1gq($7z, -25), "0x", "0xFF")
Else
Local $dp = StringReplace(_1gq($7z, +12), "0x", "0xFF")
$di = StringReplace(_1gq($7z, +25), "0x", "0xFF")
EndIf
Local $dq = _1gh($bt, $bu, $dp, 0, 5)
Local $dr = _1gh($bt, $bu, $di, 0, 5)
Local $9t = _1dm(), $9c = _16t($dk), $8c = _16r($9c, $dl, $dm)
Local $9s = _1d5(0, 0, $bt, $bu)
_1dp($9t, 1)
_1dq($9t, 1)
_17q($dq[0], $dh, $8c, $9s, $9t, $do)
_17q($dr[0], $dh, $8c, $9s, $9t, $do)
_16s($8c)
_16v($9c)
_1dn($9t)
_162($do)
$dn[0] = GUICtrlCreatePic("", $bv, $bw, $bt, $bu)
$dn[5] = _1gi($dn[0], $dq)
$dn[6] = _1gi($dn[0], $dr, False)
GUICtrlSetResizing($dn[0], 802)
_1es($dn[0], "_iHoverOff", "_iHoverOn", "", "", _1gg($dn))
Return $dn[0]
EndFunc
Func _1fl($cn, $ck = $7z, $cl = "0xFFFFFF", $ds = False, $cm = 2)
Local $d2 = _1gk()
Local $dt = Round(1 * $d2), $du
If StringInStr($85, "Light") Then
$du = StringReplace(_1gq($ck, -20), "0x", "0xFF")
Else
$du = StringReplace(_1gq($ck, +20), "0x", "0xFF")
EndIf
Local $9m = _1ce($cl, Round(1 * $d2))
Local $dv = _1ce($cl, Round(1 * $d2))
Local $dw = _1ce("0xFFFFFFFF", Round(1 * $d2))
If StringInStr($85, "Light") Then
Local $dx = _1ce(StringReplace(_1gq($cl, +90), "0x", "0xFF"), $dt)
Else
Local $dx = _1ce(StringReplace(_1gq($cl, -80), "0x", "0xFF"), $dt)
EndIf
Local $dy = _1ce(StringReplace(_1gq("0xFFFFFF", -80), "0x", "0xFF"), $dt)
If $ck <> 0 Then
$ck = "0xFF" & Hex($ck, 6)
EndIf
Local $9b = _161($ck), $dz = _161($du)
Local $e0[16]
Local $e1[16]
Local $e2[16]
Local $e3[16]
Local $e4[16]
Local $e5[16]
Local $e6[16]
Local $e7[16]
Local $e8 = Number(45 * $d2, 1)
Local $d6 = Number(29 * $d2, 1)
Local $d5 = Number($cm * $d2, 1)
Local $e9 = _1gj()
Local $ea = WinGetPos($e9)
Local $eb = 0
If $cn[0] Then
$eb = $eb + 1
$e1[0] = GUICtrlCreatePic("", $ea[2] - $d5 -($e8 * $eb), $d5, $e8, $d6)
$e1[1] = False
$e1[2] = False
$e1[3] = "0"
$e1[15] = $e9
EndIf
If $cn[1] Then
$eb = $eb + 1
$e3[0] = GUICtrlCreatePic("", $ea[2] - $d5 -($e8 * $eb), $d5, $e8, $d6)
$e3[1] = False
$e3[2] = False
$e3[3] = "3"
$e3[8] = True
$e3[15] = $e9
$e4[0] = GUICtrlCreatePic("", $ea[2] - $d5 -($e8 * $eb), $d5, $e8, $d6)
$e4[1] = False
$e4[2] = False
$e4[3] = "4"
$e4[8] = True
$e4[15] = $e9
If $cn[3] Then
$e7[0] = GUICtrlCreatePic("", $ea[2] - $d5 -($e8 * $eb), $d5, $e8, $d6)
$e7[1] = False
$e7[2] = False
$e7[3] = "10"
$e7[15] = $e9
EndIf
EndIf
If $cn[2] Then
$eb = $eb + 1
$e2[0] = GUICtrlCreatePic("", $ea[2] - $d5 -($e8 * $eb), $d5, $e8, $d6)
$e2[1] = False
$e2[2] = False
$e2[3] = "0"
$e2[15] = $e9
EndIf
If $cn[3] Then
$eb = $eb + 1
$e6[0] = GUICtrlCreatePic("", $ea[2] - $d5 -($e8 * $eb), $d5, $e8, $d6)
$e6[1] = False
$e6[2] = False
$e6[3] = "9"
$e6[15] = $e9
If $e7[15] <> $e9 Then
$e7[0] = GUICtrlCreatePic("", $ea[2] - $d5 -($e8 * $eb), $d5, $e8, $d6)
$e7[1] = False
$e7[2] = False
$e7[3] = "10"
$e7[15] = $e9
EndIf
EndIf
If $cn[4] Then
$e5[0] = GUICtrlCreatePic("", $d5, $d5, $e8, $d6)
$e5[1] = False
$e5[2] = False
$e5[3] = "8"
$e5[15] = $e9
EndIf
If $cn[0] Then
Local $ec = _1gh($e8, $d6, $ck, 4, 4), $ed = _1gh($e8, $d6, "0xFFE81123", 4, 4), $ee = _1gh($e8, $d6, $ck, 4, 4)
EndIf
If $cn[1] Then
Local $ef = _1gh($e8, $d6, $ck, 0, 4), $eg = _1gh($e8, $d6, $du, 0, 4), $eh = _1gh($e8, $d6, $ck, 0, 4)
Local $ei = _1gh($e8, $d6, $ck, 0, 4), $ej = _1gh($e8, $d6, $du, 0, 4), $ek = _1gh($e8, $d6, $ck, 0, 4)
EndIf
If $cn[2] Then
Local $el = _1gh($e8, $d6, $ck, 0, 4), $em = _1gh($e8, $d6, $du, 0, 4), $en = _1gh($e8, $d6, $ck, 0, 4)
EndIf
If $cn[3] Then
Local $eo = _1gh($e8, $d6, $ck, 0, 4), $ep = _1gh($e8, $d6, $du, 0, 4), $eq = _1gh($e8, $d6, $ck, 0, 4)
Local $er = _1gh($e8, $d6, $ck, 0, 4), $es = _1gh($e8, $d6, $du, 0, 4), $et = _1gh($e8, $d6, $ck, 0, 4)
EndIf
If $cn[4] Then
Local $eu = _1gh($e8, $d6, $ck, 0, 4), $ev = _1gh($e8, $d6, $du, 0, 4), $ew = _1gh($e8, $d6, $ck, 0, 4)
EndIf
If $ds Then
_175($ec[0], "0xFFB52231")
_175($ee[0], "0xFFB52231")
EndIf
If $cn[0] Then
If $ds Then
_17k($ec[0], 17 * $d2, 9 * $d2, 27 * $d2, 19 * $d2, $dw)
_17k($ec[0], 27 * $d2, 9 * $d2, 17 * $d2, 19 * $d2, $dw)
_17k($ee[0], 17 * $d2, 9 * $d2, 27 * $d2, 19 * $d2, $dy)
_17k($ee[0], 27 * $d2, 9 * $d2, 17 * $d2, 19 * $d2, $dy)
Else
_17k($ec[0], 17 * $d2, 9 * $d2, 27 * $d2, 19 * $d2, $9m)
_17k($ec[0], 27 * $d2, 9 * $d2, 17 * $d2, 19 * $d2, $9m)
_17k($ee[0], 17 * $d2, 9 * $d2, 27 * $d2, 19 * $d2, $dx)
_17k($ee[0], 27 * $d2, 9 * $d2, 17 * $d2, 19 * $d2, $dx)
EndIf
_17k($ed[0], 17 * $d2, 9 * $d2, 27 * $d2, 19 * $d2, $dw)
_17k($ed[0], 27 * $d2, 9 * $d2, 17 * $d2, 19 * $d2, $dw)
EndIf
If $cn[1] Then
_17o($ef[0], Round(17 * $d2), 9 * $d2, 9 * $d2, 9 * $d2, $9m)
_17o($eg[0], Round(17 * $d2), 9 * $d2, 9 * $d2, 9 * $d2, $dv)
_17o($eh[0], Round(17 * $d2), 9 * $d2, 9 * $d2, 9 * $d2, $dx)
Local $ex = Round(7 * $d2), $ey = Round(2 * $d2)
_17o($ei[0], Round(17 * $d2) + $ey,(11 * $d2) - $ey, $ex, $ex, $9m)
_17x($ei[0], Round(17 * $d2), 11 * $d2, $ex, $ex, $9b)
_17o($ei[0], Round(17 * $d2), 11 * $d2, $ex, $ex, $9m)
_17o($ej[0], Round(17 * $d2) + $ey,(11 * $d2) - $ey, $ex, $ex, $dv)
_17x($ej[0], Round(17 * $d2), 11 * $d2, $ex, $ex, $dz)
_17o($ej[0], Round(17 * $d2), 11 * $d2, $ex, $ex, $dv)
_17o($ek[0], Round(17 * $d2) + $ey,(11 * $d2) - $ey, $ex, $ex, $dx)
_17x($ek[0], Round(17 * $d2), 11 * $d2, $ex, $ex, $9b)
_17o($ek[0], Round(17 * $d2), 11 * $d2, $ex, $ex, $dx)
EndIf
If $cn[2] Then
_17k($el[0], 18 * $d2, 14 * $d2, 27 * $d2, 14 * $d2, $9m)
_17k($em[0], 18 * $d2, 14 * $d2, 27 * $d2, 14 * $d2, $dv)
_17k($en[0], 18 * $d2, 14 * $d2, 27 * $d2, 14 * $d2, $dx)
EndIf
If $cn[3] Then
Local $ez =($dt * 0.3)
Local $f0[2], $f1
$f0[0] = Round($e8 / 2.9)
$f0[1] = Round($d6 / 1.5)
$f1 = _1gl($f0[0], $f0[1], 135, $e8 / 2.5)
$f1[0] = Round($f1[0])
$f1[1] = Round($f1[1])
Local $f2 = _1gl($f0[0] + $ez, $f0[1] + $ez, 180, 5 * $d2)
Local $f3 = _1gl($f0[0] - $ez, $f0[1] - $ez, 90, 5 * $d2)
_17k($eo[0], $f0[0] + $ez, $f0[1] + $ez, $f2[0], $f2[1], $9m)
_17k($eo[0], $f0[0] - $ez, $f0[1] - $ez, $f3[0], $f3[1], $9m)
_17k($ep[0], $f0[0] + $ez, $f0[1] + $ez, $f2[0], $f2[1], $9m)
_17k($ep[0], $f0[0] - $ez, $f0[1] - $ez, $f3[0], $f3[1], $9m)
_17k($eq[0], $f0[0] + $ez, $f0[1] + $ez, $f2[0], $f2[1], $dx)
_17k($eq[0], $f0[0] - $ez, $f0[1] - $ez, $f3[0], $f3[1], $dx)
$f2 = _1gl($f1[0] + $ez, $f1[1] + $ez, 270, 5 * $d2)
$f3 = _1gl($f1[0] - $ez, $f1[1] - $ez, 0, 5 * $d2)
_17k($eo[0], $f1[0] + $ez, $f1[1] + $ez, $f2[0], $f2[1], $9m)
_17k($eo[0], $f1[0] - $ez, $f1[1] - $ez, $f3[0], $f3[1], $9m)
_17k($ep[0], $f1[0] + $ez, $f1[1] + $ez, $f2[0], $f2[1], $9m)
_17k($ep[0], $f1[0] - $ez, $f1[1] - $ez, $f3[0], $f3[1], $9m)
_17k($eq[0], $f1[0] + $ez, $f1[1] + $ez, $f2[0], $f2[1], $dx)
_17k($eq[0], $f1[0] - $ez, $f1[1] - $ez, $f3[0], $f3[1], $dx)
_17k($eo[0], $f0[0] + $ez, $f0[1] - $ez, $f1[0], $f1[1], $9m)
_17k($ep[0], $f0[0] + $ez, $f0[1] - $ez, $f1[0], $f1[1], $9m)
_17k($eq[0], $f0[0] + $ez, $f0[1] - $ez, $f1[0], $f1[1], $dx)
$ez =($dt * 0.3)
Local $f4 = Round($e8 / 2, 0), $f5 = Round($d6 / 2.35, 0)
$f2 = _1gl($f4 - $ez, $f5 - $ez, 90, 4 * $d2)
$f3 = _1gl($f4 + $ez, $f5 + $ez, 180, 4 * $d2)
Local $f6 = _1gl($f4 + $ez, $f5 - $ez, 135, 8 * $d2)
_17k($er[0], $f4 - $ez, $f5 - $ez, $f2[0], $f2[1], $9m)
_17k($er[0], $f4 + $ez, $f5 + $ez, $f3[0], $f3[1], $9m)
_17k($es[0], $f4 - $ez, $f5 - $ez, $f2[0], $f2[1], $9m)
_17k($es[0], $f4 + $ez, $f5 + $ez, $f3[0], $f3[1], $9m)
_17k($et[0], $f4 - $ez, $f5 - $ez, $f2[0], $f2[1], $dx)
_17k($et[0], $f4 + $ez, $f5 + $ez, $f3[0], $f3[1], $dx)
$ez =($dt * 0.3)
Local $f7 = Round($e8 / 2.2, 0), $f8 = Round($d6 / 2, 0)
$f2 = _1gl($f7 - $ez, $f8 - $ez, 360, 4 * $d2)
$f3 = _1gl($f7 + $ez, $f8 + $ez, 270, 4 * $d2)
Local $f9 = _1gl($f7 - $ez, $f8 + $ez, 315, 8 * $d2)
_17k($er[0], $f7 - $ez, $f8 - $ez, $f2[0], $f2[1], $9m)
_17k($er[0], $f7 + $ez, $f8 + $ez, $f3[0], $f3[1], $9m)
_17k($es[0], $f7 - $ez, $f8 - $ez, $f2[0], $f2[1], $9m)
_17k($es[0], $f7 + $ez, $f8 + $ez, $f3[0], $f3[1], $9m)
_17k($et[0], $f7 - $ez, $f8 - $ez, $f2[0], $f2[1], $dx)
_17k($et[0], $f7 + $ez, $f8 + $ez, $f3[0], $f3[1], $dx)
_17k($er[0], $f7 - $ez, $f8 + $ez, $f9[0] + $ez, $f9[1] - $ez, $9m)
_17k($er[0], $f4 + $ez, $f5 - $ez, $f6[0] - $ez, $f6[1] + $ez, $9m)
_17k($es[0], $f7 - $ez, $f8 + $ez, $f9[0] + $ez, $f9[1] - $ez, $9m)
_17k($es[0], $f4 + $ez, $f5 - $ez, $f6[0] - $ez, $f6[1] + $ez, $9m)
_17k($et[0], $f7 - $ez, $f8 + $ez, $f9[0] + $ez, $f9[1] - $ez, $dx)
_17k($et[0], $f4 + $ez, $f5 - $ez, $f6[0] - $ez, $f6[1] + $ez, $dx)
EndIf
If $cn[4] Then
_17k($eu[0], $e8 / 3, $d6 / 2.9,($e8 / 3) * 2, $d6 / 2.9, $9m)
_17k($eu[0], $e8 / 3, $d6 / 2.9 +($dt * 4),($e8 / 3) * 2, $d6 / 2.9 +($dt * 4), $9m)
_17k($eu[0], $e8 / 3, $d6 / 2.9 +($dt * 8),($e8 / 3) * 2, $d6 / 2.9 +($dt * 8), $9m)
_17k($ev[0], $e8 / 3, $d6 / 2.9,($e8 / 3) * 2, $d6 / 2.9, $9m)
_17k($ev[0], $e8 / 3, $d6 / 2.9 +($dt * 4),($e8 / 3) * 2, $d6 / 2.9 +($dt * 4), $9m)
_17k($ev[0], $e8 / 3, $d6 / 2.9 +($dt * 8),($e8 / 3) * 2, $d6 / 2.9 +($dt * 8), $9m)
_17k($ew[0], $e8 / 3, $d6 / 2.9,($e8 / 3) * 2, $d6 / 2.9, $dx)
_17k($ew[0], $e8 / 3, $d6 / 2.9 +($dt * 4),($e8 / 3) * 2, $d6 / 2.9 +($dt * 4), $dx)
_17k($ew[0], $e8 / 3, $d6 / 2.9 +($dt * 8),($e8 / 3) * 2, $d6 / 2.9 +($dt * 8), $dx)
EndIf
_1cg($9m)
_1cg($dv)
_1cg($dw)
_1cg($dx)
_1cg($dy)
_162($9b)
_162($dz)
If $cn[0] Then
$e1[5] = _1gi($e1[0], $ec)
$e1[6] = _1gi($e1[0], $ed, False)
$e1[7] = _1gi($e1[0], $ee, False)
GUICtrlSetResizing($e1[0], 768 + 32 + 4)
$e0[0] = $e1[0]
_1es($e1[0], "_iHoverOff", "_iHoverOn", '', "", _1gg($e1), $e9)
EndIf
If $cn[1] Then
$e3[5] = _1gi($e3[0], $ef)
$e3[6] = _1gi($e3[0], $eg, False)
$e3[7] = _1gi($e3[0], $eh, False)
$e4[5] = _1gi($e4[0], $ei)
$e4[6] = _1gi($e4[0], $ej, False)
$e4[7] = _1gi($e4[0], $ek, False)
GUICtrlSetResizing($e3[0], 768 + 32 + 4)
GUICtrlSetResizing($e4[0], 768 + 32 + 4)
$e0[1] = $e3[0]
$e0[2] = $e4[0]
GUICtrlSetState($e4[0], 32)
_1es($e3[0], "_iHoverOff", "_iHoverOn", "", "", _1gg($e3), $e9)
_1es($e4[0], "_iHoverOff", "_iHoverOn", "", "", _1gg($e4), $e9)
EndIf
If $cn[2] Then
$e2[5] = _1gi($e2[0], $el)
$e2[6] = _1gi($e2[0], $em, False)
$e2[7] = _1gi($e2[0], $en, False)
GUICtrlSetResizing($e2[0], 768 + 32 + 4)
$e0[3] = $e2[0]
_1es($e2[0], "_iHoverOff", "_iHoverOn", "", "", _1gg($e2), $e9)
EndIf
If $cn[3] Then
$e6[5] = _1gi($e6[0], $eo)
$e6[6] = _1gi($e6[0], $ep, False)
$e6[7] = _1gi($e6[0], $eq, False)
$e7[5] = _1gi($e7[0], $er)
$e7[6] = _1gi($e7[0], $es, False)
$e7[7] = _1gi($e7[0], $et, False)
GUICtrlSetResizing($e6[0], 768 + 32 + 4)
GUICtrlSetResizing($e7[0], 768 + 32 + 4)
GUICtrlSetState($e7[0], 32)
$e0[4] = $e6[0]
$e0[5] = $e7[0]
_1es($e6[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _1gg($e6), $e9)
_1es($e7[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _1gg($e7), $e9)
EndIf
If $cn[4] Then
$e5[5] = _1gi($e5[0], $eu)
$e5[6] = _1gi($e5[0], $ev, False)
$e5[7] = _1gi($e5[0], $ew, False)
GUICtrlSetResizing($e5[0], 768 + 32 + 2)
$e0[6] = $e5[0]
_1es($e5[0], "_iHoverOff", "_iHoverOn", "", "", _1gg($e5), $e9)
EndIf
Return $e0
EndFunc
Func _1fm($dh, $bv, $bw, $bt, $bu, $di = $82, $dj = $83, $dk = "Arial", $dl = 10, $dm = 1, $fa = "0xFFFFFF")
Local $dn[16]
Local $fb = _1gk()
If $bp Then
$bv = Round($bv * $bh)
$bw = Round($bw * $bh)
$bt = Round($bt * $bh)
$bu = Round($bu * $bh)
Else
$dl =($dl / $bg)
EndIf
$dn[1] = False
$dn[3] = "2"
$dn[15] = _1gj()
Local $dt = Round(4 * $fb)
If Not(Mod($dt, 2) = 0) Then $dt = $dt - 1
$di = "0xFF" & Hex($di, 6)
$dj = "0xFF" & Hex($dj, 6)
$fa = "0xFF" & Hex($fa, 6)
Local $do = _161($dj)
Local $fc = _161(StringReplace(_1gq($dj, -30), "0x", "0xFF"))
Local $fd = _1ce($fa, $dt)
Local $dq = _1gh($bt, $bu, $di, 0, 5)
Local $dr = _1gh($bt, $bu, $di, 0, 5)
Local $fe = _1gh($bt, $bu, $di, 0, 5)
Local $9t = _1dm(), $9c = _16t($dk), $8c = _16r($9c, $dl, $dm)
Local $9s = _1d5(0, 0, $bt, $bu)
_1dp($9t, 1)
_1dq($9t, 1)
_17q($dq[0], $dh, $8c, $9s, $9t, $do)
_17q($dr[0], $dh, $8c, $9s, $9t, $do)
_17q($fe[0], $dh, $8c, $9s, $9t, $fc)
_17o($dr[0], 0, 0, $bt, $bu, $fd)
_16s($8c)
_16v($9c)
_1dn($9t)
_162($do)
_162($fc)
_1cg($fd)
$dn[0] = GUICtrlCreatePic("", $bv, $bw, $bt, $bu)
$dn[5] = _1gi($dn[0], $dq)
$dn[6] = _1gi($dn[0], $dr, False)
$dn[7] = _1gi($dn[0], $fe, False)
GUICtrlSetResizing($dn[0], 768)
_1es($dn[0], "_iHoverOff", "_iHoverOn", "", "", _1gg($dn))
Return $dn[0]
EndFunc
Func _1fp($ff)
Local $e9 = _1gj()
GUICtrlSetState($ff, 128)
For $fg = 0 To(UBound($bi) - 1)
If($bi[$fg][0] = $ff) And($bi[$fg][15] = $e9) Then
_4q(GUICtrlSendMsg($bi[$fg][0], 0x0172, 0, $bi[$fg][7]))
EndIf
Next
EndFunc
Func _1fq($ff)
Local $e9 = _1gj()
GUICtrlSetState($ff, 64)
For $fg = 0 To(UBound($bi) - 1)
If($bi[$fg][0] = $ff) And($bi[$fg][15] = $e9) Then
_4q(GUICtrlSendMsg($bi[$fg][0], 0x0172, 0, $bi[$fg][5]))
EndIf
Next
EndFunc
Func _1fs($dh, $bv, $bw, $bt, $bu, $di = $7z, $dj = $80, $dk = "Segoe UI", $dl = "11")
Local $fh = _1gk(), $fi = $dh
If $bu < 20 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. height is 20px for metro toggles.")
EndIf
If $bt < 46 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. width for metro toggles must be at least 46px without any text!")
EndIf
If Mod($bu, 2) <> 0 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The toggle height should be an even number to prevent any misplacing.")
EndIf
If $bp Then
$bv = Round($bv * $bh)
$bw = Round($bw * $bh)
$bt = Round($bt * $bh)
$bu = Round($bu * $bh)
If Mod($bu, 2) <> 0 Then $bu = $bu + 1
Else
$dl =($dl / $bg)
EndIf
Local $fj[16]
$fj[1] = False
$fj[2] = False
$fj[3] = "6"
$fj[15] = _1gj()
Local $fk = Number(20 * $fh, 1)
If Mod($fk, 2) <> 0 Then $fk = $fk + 1
Local $fl = Number((($bu - $fk) / 2), 1)
Local $fm = Number(50 * $fh, 1)
If Mod($fm, 2) <> 0 Then $fm = $fm + 1
Local $fn = Number(46 * $fh, 1)
If Mod($fn, 2) <> 0 Then $fn = $fn + 1
Local $fo = Number(20 * $fh, 1)
If Mod($fo, 2) <> 0 Then $fo = $fo + 1
Local $fp = Number(2 * $fh, 1)
Local $fq = Number(3 * $fh, 1)
Local $fr = Number(11 * $fh, 1)
Local $fs = Number(6 * $fh, 1)
$di = "0xFF" & Hex($di, 6)
$dj = "0xFF" & Hex($dj, 6)
Local $do = _161($dj)
Local $ft = _161(StringReplace($84, "0x", "0xFF"))
If StringInStr($85, "Light") Then
Local $fu = StringReplace(_1gq($dj, +45), "0x", "0xFF")
Local $fv = StringReplace(_1gq($dj, +35), "0x", "0xFF")
Local $fw = StringReplace(_1gq($dj, +60), "0x", "0xFF")
Else
Local $fu = StringReplace(_1gq($dj, -45), "0x", "0xFF")
Local $fv = StringReplace(_1gq($dj, -55), "0x", "0xFF")
Local $fw = StringReplace(_1gq($dj, -30), "0x", "0xFF")
EndIf
Local $fx = _161($fu)
Local $fy = _161($fv)
Local $fz = _161($fw)
Local $g0 = _161(StringReplace($82, "0x", "0xFF"))
Local $g1 = _161(StringReplace(_1gq($82, -10), "0x", "0xFF"))
Local $g2 = _161(StringReplace(_1gq($82, +15), "0x", "0xFF"))
Local $g3 = _1gh($bt, $bu, $di, 0, 5), $g4 = _1gh($bt, $bu, $di, 0, 5), $g5 = _1gh($bt, $bu, $di, 0, 5), $g6 = _1gh($bt, $bu, $di, 0, 5), $g7 = _1gh($bt, $bu, $di, 0, 5), $g8 = _1gh($bt, $bu, $di, 0, 5), $g9 = _1gh($bt, $bu, $di, 0, 5), $ga = _1gh($bt, $bu, $di, 0, 5), $gb = _1gh($bt, $bu, $di, 0, 5), $gc = _1gh($bt, $bu, $di, 0, 5)
Local $9t = _1dm(), $9c = _16t($dk), $8c = _16r($9c, $dl, 0)
Local $9s = _1d5($fm, 0, $bt - $fm, $bu)
_1dp($9t, 1)
_1dq($9t, 1)
If StringInStr($dh, "|@|") Then
$fi = StringRegExp($dh, "\|@\|(.+)", 1)
If Not @error Then $fi = $fi[0]
$dh = StringRegExp($dh, "^(.+)\|@\|", 1)
If Not @error Then $dh = $dh[0]
EndIf
_17q($g3[0], $dh, $8c, $9s, $9t, $do)
_17q($g4[0], $dh, $8c, $9s, $9t, $do)
_17q($g5[0], $dh, $8c, $9s, $9t, $do)
_17q($g6[0], $dh, $8c, $9s, $9t, $do)
_17q($g7[0], $dh, $8c, $9s, $9t, $do)
_17q($g8[0], $fi, $8c, $9s, $9t, $do)
_17q($g9[0], $fi, $8c, $9s, $9t, $do)
_17q($ga[0], $fi, $8c, $9s, $9t, $do)
_17q($gb[0], $dh, $8c, $9s, $9t, $do)
_17q($gc[0], $fi, $8c, $9s, $9t, $do)
_17x($g3[0], 0, $fl, $fn, $fo, $fy)
_17x($g3[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $fx)
_17x($g3[0], 0, $fl, $fr, $fo, $ft)
_17x($gb[0], 0, $fl, $fn, $fo, $fy)
_17x($gb[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $fz)
_17x($gb[0], 0, $fl, $fr, $fo, $ft)
_17x($g4[0], 0, $fl, $fn, $fo, $fy)
_17x($g4[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $fz)
_17x($g4[0], 5 * $fh, $fl, $fr, $fo, $ft)
_17x($g5[0], 0, $fl, $fn, $fo, $fy)
_17x($g5[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $fz)
_17x($g5[0], 10 * $fh, $fl, $fr, $fo, $ft)
_17x($g6[0], 0, $fl, $fn, $fo, $fy)
_17x($g6[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $fz)
_17x($g6[0], 15 * $fh, $fl, $fr, $fo, $ft)
_17x($g7[0], 0, $fl, $fn, $fo, $g1)
_17x($g7[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $g2)
_17x($g7[0], $fo, $fl, $fr, $fo, $ft)
_17x($g8[0], 0, $fl, $fn, $fo, $g1)
_17x($g8[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $g2)
_17x($g8[0], 25 * $fh, $fl, $fr, $fo, $ft)
_17x($g9[0], 0, $fl, $fn, $fo, $g1)
_17x($g9[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $g2)
_17x($g9[0], 30 * $fh, $fl, $fr, $fo, $ft)
_17x($ga[0], 0, $fl, $fn, $fo, $g1)
_17x($ga[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $g0)
_17x($ga[0], $fn - $fr, $fl, $fr, $fo, $ft)
_17x($gc[0], 0, $fl, $fn, $fo, $g1)
_17x($gc[0], $fq, $fl + $fq, $fn - $fs, $fo - $fs, $g2)
_17x($gc[0], $fn - $fr, $fl, $fr, $fo, $ft)
_16s($8c)
_16v($9c)
_1dn($9t)
_162($do)
_162($ft)
_162($fx)
_162($fy)
_162($fz)
_162($g0)
_162($g1)
_162($g2)
$fj[0] = GUICtrlCreatePic("", $bv, $bw, $bt, $bu)
$fj[5] = _1gi($fj[0], $g3)
$fj[6] = _1gi($fj[0], $g4, False)
$fj[7] = _1gi($fj[0], $g5, False)
$fj[8] = _1gi($fj[0], $g6, False)
$fj[9] = _1gi($fj[0], $g7, False)
$fj[10] = _1gi($fj[0], $g8, False)
$fj[11] = _1gi($fj[0], $g9, False)
$fj[12] = _1gi($fj[0], $ga, False)
$fj[13] = _1gi($fj[0], $gb, False)
$fj[14] = _1gi($fj[0], $gc, False)
GUICtrlSetResizing($fj[0], 768)
_1es($fj[0], "_iHoverOff", "_iHoverOn", "", "", _1gg($fj))
Return $fj[0]
EndFunc
Func _1fv($gd)
For $59 = 0 To(UBound($bi) - 1) Step +1
If $bi[$59][0] = $gd Then
If $bi[$59][2] Then
Return True
Else
Return False
EndIf
EndIf
Next
EndFunc
Func _1fx($gd, $ge = False)
For $59 = 0 To(UBound($bi) - 1) Step +1
If $bi[$59][0] = $gd Then
If $bi[$59][2] Then
If Not $ge Then
For $ce = 12 To 6 Step -1
_4q(GUICtrlSendMsg($gd, 0x0172, 0, $bi[$59][$ce]))
Sleep(1)
Next
_4q(GUICtrlSendMsg($gd, 0x0172, 0, $bi[$59][13]))
Else
_4q(GUICtrlSendMsg($gd, 0x0172, 0, $bi[$59][13]))
EndIf
$bi[$59][1] = True
$bi[$59][2] = False
ExitLoop
EndIf
EndIf
Next
EndFunc
Func _1fy($gd, $ge = False)
For $59 = 0 To(UBound($bi) - 1) Step +1
If $bi[$59][0] = $gd Then
If Not $bi[$59][2] Then
If Not $ge Then
For $ce = 6 To 11 Step +1
_4q(GUICtrlSendMsg($gd, 0x0172, 0, $bi[$59][$ce]))
Sleep(1)
Next
_4q(GUICtrlSendMsg($gd, 0x0172, 0, $bi[$59][12]))
Else
_4q(GUICtrlSendMsg($gd, 0x0172, 0, $bi[$59][12]))
EndIf
$bi[$59][2] = True
$bi[$59][1] = True
ExitLoop
EndIf
EndIf
Next
EndFunc
Func _1ga($gf, $bs, $dh, $cv = 600, $dl = 11, $by = "", $gg = 0)
Local $gh, $gi, $gj, $gk = "-", $gl = "-", $gm = "-", $gn = 1
Switch $gf
Case 0
$gn = 1
$gk = "OK"
Case 1
$gn = 2
$gk = "OK"
$gl = "Cancel"
Case 2
$gn = 3
$gk = "Abort"
$gl = "Retry"
$gm = "Ignore"
Case 3
$gn = 3
$gk = "Yes"
$gl = "No"
$gm = "Cancel"
Case 4
$gn = 2
$gk = "Yes"
$gl = "No"
Case 5
$gn = 2
$gk = "Retry"
$gl = "Cancel"
Case 6
$gn = 3
$gk = "Cancel"
$gl = "Retry"
$gm = "Continue"
Case 7
$gn = 3
$gk = "Yes"
$gl = "Save File"
$gm = "No Need"
Case Else
$gn = 1
$gk = "OK"
EndSwitch
If($gn = 1) And($cv < 180) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 180px for the selected message style/flag.")
If($gn = 2) And($cv < 240) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 240px for the selected message style/flag.")
If($gn = 3) And($cv < 360) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 360px for the selected message style/flag.")
Local $go = _1gk()
If $bp Then
$cv = Round($cv * $bh)
Else
$dl =($dl / $bg)
EndIf
Local $gp = _155($dh, $dl, 400, 0, "Arial", $cv -(30 * $go))
Local $gq = 120 +($gp[3] / $go)
Local $gr = _1fa($bs, $cv / $go, $gq, -1, -1, False, $by)
$gq = $gq * $go
GUICtrlCreateLabel(" " & $bs, 2 * $go, 2 * $go, $cv -(4 * $go), 30 * $go, 0x0200, 0x00100000)
GUICtrlSetBkColor(-1, _1gq($7z, 30))
GUICtrlSetColor(-1, $80)
_1gm(-1, 11, 600, 0, "Arial", 5)
GUICtrlCreateLabel($dh, 15 * $go, 50 * $go, $gp[2], $gp[3], -1, 0x00100000)
GUICtrlSetBkColor(-1, $7z)
GUICtrlSetColor(-1, $80)
GUICtrlSetFont(-1, $dl, 400, 0, "Arial", 5)
Local $gs =(($cv / $go) -($gn * 100) -(($gn - 1) * 20)) / 2
Local $gt =($cv -($gn *(100 * $go)) -(($gn - 1) *(20 * $go))) / 2
Local $gu = $gs + 120
Local $gv = $gu + 120
GUICtrlCreateLabel("", 2 * $go, $gq -(53 * $go), $gt -(4 * $go),(50 * $go), -1, 0x00100000)
GUICtrlCreateLabel("", $cv - $gt +(2 * $go), $gq -(53 * $go), $gt -(4 * $go),(50 * $go), -1, 0x00100000)
Local $gw = GUICtrlCreateDummy()
Local $gx[1][2] = [["{ENTER}", $gw]]
Local $gh = _1fm($gk, $gs,($gq / $go) - 50, 100, 34, $82, $83)
Local $gi = _1fm($gl, $gu,($gq / $go) - 50, 100, 34, $82, $83)
If $gn < 2 Then GUICtrlSetState($gi, 32)
Local $gj = _1fm($gm, $gv,($gq / $go) - 50, 100, 34, $82, $83)
If $gn < 3 Then GUICtrlSetState($gj, 32)
Switch $gf
Case 0, 1, 5
GUICtrlSetState($gh, 512)
Case 2, 4, 6
GUICtrlSetState($gi, 512)
Case 3
GUICtrlSetState($gj, 512)
Case Else
GUICtrlSetState($gh, 512)
EndSwitch
GUISetAccelerators($gx, $gr)
GUISetState(@SW_SHOW)
If $gg <> 0 Then
$bk = $gg
AdlibRegister("_1go", 1000)
EndIf
If $br Then Opt("GUIOnEventMode", 0)
While 1
If $gg <> 0 Then
If $bk <= 0 Then
AdlibUnRegister("_1go")
_1fc($gr)
If $br Then Opt("GUIOnEventMode", 1)
Return SetError(1)
EndIf
EndIf
Local $gy = GUIGetMsg()
Switch $gy
Case -3, $gh
_1fc($gr)
If $br Then Opt("GUIOnEventMode", 1)
Return $gk
Case $gi
_1fc($gr)
If $br Then Opt("GUIOnEventMode", 1)
Return $gl
Case $gj
_1fc($gr)
If $br Then Opt("GUIOnEventMode", 1)
Return $gm
Case $gw
_1fc($gr)
Local $gz
Switch $gf
Case 0, 1, 5
$gz = $gk
Case 2, 4, 6
$gz = $gl
Case 3
$gz = $gm
Case Else
$gz = $gk
EndSwitch
If $br Then Opt("GUIOnEventMode", 1)
Return $gz
EndSwitch
WEnd
EndFunc
Func _1gg($h0)
Local $h1
For $59 = 0 To UBound($bi) - 1 Step +1
If $bi[$59][0] = "" Then
$h1 = $59
ExitLoop
EndIf
Next
If $h1 == "" Then
$h1 = UBound($bi)
ReDim $bi[$h1 + 1][16]
EndIf
For $59 = 0 To 15
$bi[$h1][$59] = $h0[$59]
Next
Return $h1
EndFunc
Func _1gh($h2, $h3, $h4 = 0, $h5 = 4, $h6 = 0)
Local $h7[2]
$h7[1] = _15p($h2, $h3, $8w)
$h7[0] = _193($h7[1])
_18l($h7[0], $h5)
_18m($h7[0], $h6)
If $h4 <> 0 Then _175($h7[0], $h4)
Return $h7
EndFunc
Func _1gi($h8, $h7, $h9 = True)
Local $ha = _15r($h7[1])
If $h9 Then _4q(GUICtrlSendMsg($h8, 0x0172, 0, $ha))
_178($h7[0])
_15s($h7[1])
Return $ha
EndFunc
Func _1gj()
Local $hb = GUICtrlCreateLabel("", 0, 0, 0, 0)
Local $hc = _5c(GUICtrlGetHandle($hb))
GUICtrlDelete($hb)
Return $hc
EndFunc
Func _1gk()
If $bp Then
Return $bh
Else
Return 1
EndIf
EndFunc
Func _1gl($hd, $he, $hf, $hg)
Local $hh[2]
$hh[0] = $hd +($hg * Sin($hf / 180 * 3.14159265358979))
$hh[1] = $he +($hg * Cos($hf / 180 * 3.14159265358979))
Return $hh
EndFunc
Func _1gm($hi, $3p, $89 = 400, $hj = 0, $hk = "", $hl = 5)
If $bp Then
GUICtrlSetFont($hi, $3p, $89, $hj, $hk, $hl)
Else
GUICtrlSetFont($hi, $3p / $bg, $89, $hj, $hk, $hl)
EndIf
EndFunc
Func _1gn()
Local $hm[3]
Local $hn, $ho, $hp = 90, $1v = 0
Local $57 = DllCall("user32.dll", "long", "GetDC", "long", $1v)
Local $4m = DllCall("gdi32.dll", "long", "GetDeviceCaps", "long", $57[0], "long", $hp)
$57 = DllCall("user32.dll", "long", "ReleaseDC", "long", $1v, "long", $57)
$hn = $4m[0]
Select
Case $hn = 0
$hn = 96
$ho = 94
Case $hn < 84
$ho = $hn / 105
Case $hn < 121
$ho = $hn / 96
Case $hn < 145
$ho = $hn / 95
Case Else
$ho = $hn / 94
EndSelect
$hm[0] = 2
$hm[1] = $hn
$hm[2] = $ho
Return $hm
EndFunc
Func _1go()
$bk -= 1
EndFunc
Func _1gq($hq, $hr, $hs = 7)
Local $ht = $hr *(BitAND(1, $hs) <> 0) + BitAND($hq, 0xff0000) / 0x10000
Local $hu = $hr *(BitAND(2, $hs) <> 0) + BitAND($hq, 0x00ff00) / 0x100
Local $hv = $hr *(BitAND(4, $hs) <> 0) + BitAND($hq, 0x0000FF)
Return "0x" & Hex(String(_1gr($ht) * 0x10000 + _1gr($hu) * 0x100 + _1gr($hv)), 6)
EndFunc
Func _1gr($hw)
If $hw > 255 Then Return 255
If $hw < 0 Then Return 0
Return $hw
EndFunc
Func _1gs($c3, $hx, $hy, $hz = 0xFFFFFF)
Local $i0, $i1, $i2, $i3
Local $c0 = _1gz($c3)
$i2 = GUICtrlCreateLabel("", 0, 0, $hx, 1)
GUICtrlSetColor(-1, $hz)
GUICtrlSetBkColor(-1, $hz)
GUICtrlSetResizing(-1, 544)
GUICtrlSetState(-1, 128)
$i3 = GUICtrlCreateLabel("", 0, $hy - 1, $hx, 1)
GUICtrlSetColor(-1, $hz)
GUICtrlSetBkColor(-1, $hz)
GUICtrlSetResizing(-1, 576)
GUICtrlSetState(-1, 128)
$i0 = GUICtrlCreateLabel("", 0, 1, 1, $hy - 1)
GUICtrlSetColor(-1, $hz)
GUICtrlSetBkColor(-1, $hz)
GUICtrlSetResizing(-1, 256 + 2)
GUICtrlSetState(-1, 128)
$i1 = GUICtrlCreateLabel("", $hx - 1, 1, 1, $hy - 1)
GUICtrlSetColor(-1, $hz)
GUICtrlSetBkColor(-1, $hz)
GUICtrlSetResizing(-1, 256 + 4)
GUICtrlSetState(-1, 128)
If $c0 <> "" Then
$bj[$c0][12] = $i2
$bj[$c0][13] = $i3
$bj[$c0][14] = $i0
$bj[$c0][15] = $i1
EndIf
EndFunc
Func _1gt($i4, $i5, $i6)
Local $i7[2]
$i7[0] = "-1"
$i7[1] = "-1"
Local $ea = WinGetPos($i4)
If Not @error Then
$i7[0] =($ea[0] +(($ea[2] - $i5) / 2))
$i7[1] =($ea[1] +(($ea[3] - $i6) / 2))
EndIf
Return $i7
EndFunc
Func _1gu($i8 = 96)
_1dl()
Local $i9 = _177(0)
If @error Then Return SetError(1, @extended, 0)
Local $2l
#forcedef $90, $ia
$2l = DllCall($90, "int", "GdipGetDpiX", "handle", $i9, "float*", 0)
If @error Then Return SetError(2, @extended, 0)
Local $hn = $2l[2]
_178($i9)
_1dk()
Return $hn / $i8
EndFunc
Func _iHoverOn($ah, $ib)
Switch $bi[$ib][3]
Case 5, 7
If $bi[$ib][2] Then
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][8]))
Else
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][6]))
EndIf
Case "6"
If $bi[$ib][2] Then
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][14]))
Else
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][13]))
EndIf
Case Else
_4q(GUICtrlSendMsg($ah, 0x0172, 0, $bi[$ib][6]))
EndSwitch
EndFunc
Func _iHoverOff($ah, $ib)
Switch $bi[$ib][3]
Case 0, 3, 4, 8, 9, 10
If WinActive($bi[$ib][15]) Then
_4q(GUICtrlSendMsg($ah, 0x0172, 0, $bi[$ib][5]))
Else
_4q(GUICtrlSendMsg($ah, 0x0172, 0, $bi[$ib][7]))
EndIf
Case 5, 7
If $bi[$ib][2] Then
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][7]))
Else
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][5]))
EndIf
Case "6"
If $bi[$ib][2] Then
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][12]))
Else
_4q(GUICtrlSendMsg($bi[$ib][0], 0x0172, 0, $bi[$ib][5]))
EndIf
Case Else
_4q(GUICtrlSendMsg($ah, 0x0172, 0, $bi[$ib][5]))
EndSwitch
EndFunc
Func _1gv($ic, $1v)
For $59 = 0 To UBound($bi) - 1
If($ic = $bi[$59][3]) And($1v = $bi[$59][15]) Then Return $bi[$59][0]
Next
Return False
EndFunc
Func _1gw($1v, $45, $46, $47, $id, $c0)
Switch $45
Case 0x00AF, 0x0085, 0x00AE, 0x0083, 0x0086
Return -1
Case 0x031A
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(2, 4))
_5v($1v, 0, 0, 0, 0, 0, $1n + $1l + $1k + $1m)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Return 0
Case 0x0005
If Not $bj[$c0][11] Then
Switch $46
Case 2
Local $ie = _1gy($1v)
Local $if = WinGetPos($1v)
WinMove($1v, "", $if[0] - 1, $if[1] - 1, $ie[2], $ie[3])
For $ig = 0 To UBound($bi) - 1
If $1v = $bi[$ig][15] Then
Switch $bi[$ig][3]
Case 3
GUICtrlSetState($bi[$ig][0], 32)
$bi[$ig][8] = False
Case 4
GUICtrlSetState($bi[$ig][0], 16)
$bi[$ig][8] = True
EndSwitch
EndIf
Next
Case 0
For $ig = 0 To UBound($bi) - 1
If $1v = $bi[$ig][15] Then
Switch $bi[$ig][3]
Case 3
If Not $bi[$ig][8] Then
GUICtrlSetState($bi[$ig][0], 16)
$bi[$ig][8] = True
EndIf
Case 4
If $bi[$ig][8] Then
GUICtrlSetState($bi[$ig][0], 32)
$bi[$ig][8] = False
EndIf
EndSwitch
EndIf
Next
EndSwitch
EndIf
Case 0x0024
Local $ih = DllStructCreate("int;int;int;int;int;int;int;int;int;dword", $47)
Local $ii = _1gy($1v)
DllStructSetData($ih, 3, $ii[2])
DllStructSetData($ih, 4, $ii[3])
DllStructSetData($ih, 5, $ii[0] + 1)
DllStructSetData($ih, 6, $ii[1] + 1)
DllStructSetData($ih, 7, $bj[$c0][3])
DllStructSetData($ih, 8, $bj[$c0][4])
Case 0x0084
If $bj[$c0][2] And Not $bj[$c0][11] Then
Local $ij = 0, $ik = 0, $il
Local $if = WinGetPos($1v)
Local $im = GUIGetCursorInfo($1v)
If Not @error Then
If $im[0] < $bo Then $ij = 1
If $im[0] > $if[2] - $bo Then $ij = 2
If $im[1] < $bo Then $ik = 3
If $im[1] > $if[3] - $bo Then $ik = 6
$il = $ij + $ik
Else
$il = 0
EndIf
If WinGetState($1v) <> 47 Then
Local $in = 2, $io = 2
Switch $il
Case 1
$io = 13
$in = 10
Case 2
$io = 13
$in = 11
Case 3
$io = 11
$in = 12
Case 4
$io = 12
$in = 13
Case 5
$io = 10
$in = 14
Case 6
$io = 11
$in = 15
Case 7
$io = 10
$in = 16
Case 8
$io = 12
$in = 17
EndSwitch
GUISetCursor($io, 1)
If $in <> 2 Then Return $in
EndIf
If Abs(BitAND(BitShift($47, 16), 0xFFFF) - $if[1]) <(28 * $bh) Then Return $6o
EndIf
Case 0x0201
If $bj[$c0][1] And Not $bj[$c0][11] And Not(WinGetState($1v) = 47) Then
Local $ip = GUIGetCursorInfo($1v)
If($ip[4] = 0) Then
DllCall("user32.dll", "int", "ReleaseCapture")
DllCall("user32.dll", "long", "SendMessageA", "hwnd", $1v, "int", 0x00A1, "int", 2, "int", 0)
Return 0
EndIf
EndIf
Case 0x001C
For $ig = 0 To UBound($bi) - 1
Switch $bi[$ig][3]
Case 0, 3, 4, 8, 9, 10
If $46 Then
_4q(GUICtrlSendMsg($bi[$ig][0], 0x0172, 0, $bi[$ig][5]))
Else
_4q(GUICtrlSendMsg($bi[$ig][0], 0x0172, 0, $bi[$ig][7]))
EndIf
EndSwitch
Next
Case 0x0020
If MouseGetCursor() <> 2 Then
Local $im = GUIGetCursorInfo($1v)
If Not @error And $im[4] <> 0 Then
Local $ij = 0, $ik = 0, $il = 0
Local $if = WinGetPos($1v)
If $im[0] < $bo Then $ij = 1
If $im[0] > $if[2] - $bo Then $ij = 2
If $im[1] < $bo Then $ik = 3
If $im[1] > $if[3] - $bo Then $ik = 6
$il = $ij + $ik
If $il = 0 Then
If $im[4] <> $bj[$c0][12] And $im[4] <> $bj[$c0][13] And $im[4] <> $bj[$c0][14] And $im[4] <> $bj[$c0][15] Then
GUISetCursor(2, 0, $1v)
EndIf
EndIf
EndIf
EndIf
EndSwitch
Return DllCall("comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $1v, "uint", $45, "wparam", $46, "lparam", $47)[0]
EndFunc
Func _1gx()
For $cb = 0 To UBound($bj) - 1 Step +1
_1fc($bj[$cb][0])
Next
DllCallbackFree($bm)
_1dk()
EndFunc
Func _1gy($1v, $iq = False)
Local $ir[4], $is = 1
$ir[0] = 0
$ir[1] = 0
$ir[2] = @DesktopWidth
$ir[3] = @DesktopHeight
Local $56, $it = _ck()
If @error Then Return $ir
ReDim $it[$it[0][0] + 1][5]
For $59 = 1 To $it[0][0]
$56 = _dt($it[$59][1])
For $8s = 0 To 3
$it[$59][$8s + 1] = $56[$8s]
Next
Next
Local $iu = _es($1v)
Local $iv = _es(WinGetHandle("[CLASS:Shell_TrayWnd]"))
For $iw = 1 To $it[0][0] Step +1
If $it[$iw][0] = $iu Then
If $iq Then
$ir[0] = $it[$iw][1]
$ir[1] = $it[$iw][2]
Else
$ir[0] = 0
$ir[1] = 0
EndIf
$ir[2] = $it[$iw][3]
$ir[3] = $it[$iw][4]
$is = $iw
EndIf
Next
Local $ix = DllCall("shell32.dll", "int", "SHAppBarMessage", "int", 0x00000004, "ptr*", 0)
If Not @error Then
$ix = $ix[0]
Else
$ix = 0
EndIf
If $iv = $iu Then
Local $iy = WinGetPos("[CLASS:Shell_TrayWnd]")
If @error Then Return $ir
If $iq Then Return $ir
If($iy[0] = $it[$is][1] - 2) Or($iy[1] = $it[$is][2] - 2) Then
$iy[0] += 2
$iy[1] += 2
$iy[2] -= 4
$iy[3] -= 4
EndIf
If $iy[2] = $ir[2] Then
If $ix = 1 Then
If($iy[1] > 0) Then
$ir[3] -= 1
Else
$ir[1] += 1
$ir[3] -= 1
EndIf
Return $ir
EndIf
$ir[3] = $ir[3] - $iy[3]
If($iy[0] = $it[$is][1]) And($iy[1] = $it[$is][2]) Then $ir[1] = $iy[3]
Else
If $ix = 1 Then
If($iy[0] > 0) Then
$ir[2] -= 1
Else
$ir[0] += 1
$ir[2] -= 1
EndIf
Return $ir
EndIf
$ir[2] = $ir[2] - $iy[2]
If($iy[0] = $it[$is][1]) And($iy[1] = $it[$is][2]) Then $ir[0] = $iy[2]
EndIf
EndIf
Return $ir
EndFunc
Func _1gz($c3)
For $iz = 0 To UBound($bj) - 1
If $bj[$iz][0] = $c3 Then
Return $iz
EndIf
Next
Return SetError(1, 0, "")
EndFunc
Func _iFullscreenToggleBtn($ah, $1v)
If $bq Then _1fg($1v)
EndFunc
Global Enum $j0 = 0, $j1, $j2
Func _1h6($2v = @ScriptName, $j3 = False, $j4 = $j0)
Local $j5 = Default
_1h9($2v, $j5)
RegRead(_1hc($j3, $j4) & '\', $2v)
Return @error = 0
EndFunc
Func _1h7($2v = @ScriptName, $j5 = @ScriptFullPath, $j6 = '', $j3 = False, $j4 = $j0)
Return _1hd(True, $2v, $j5, $j6, $j3, $j4)
EndFunc
Func _1h8($2v = @ScriptName, $j5 = @ScriptFullPath, $j3 = False, $j4 = $j0)
Return _1hd(False, $2v, $j5, Default, $j3, $j4)
EndFunc
Func _1h9(ByRef $2v, ByRef $j5)
If $j5 = Default Then
$j5 = @ScriptFullPath
EndIf
If $2v = Default Then
$2v = @ScriptName
EndIf
$2v = StringRegExpReplace($2v, '\.[^.\\/]*$', '')
Return Not(StringStripWS($2v, $1p) == '') And FileExists($j5)
EndFunc
Func _1hc($j3, $j4)
If $j4 = Default Then
$j4 = $j0
EndIf
Local $j7 = ''
Switch $j4
Case $j1
$j7 = 'Once'
Case $j2
$j7 = 'OnceEx'
Case Else
$j7 = ''
EndSwitch
Return($j3 ? 'HKEY_LOCAL_MACHINE' : 'HKEY_CURRENT_USER') &((@OSArch = 'X64') ? '64' : '') & '\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' & $j7
EndFunc
Func _1hd($j8, $2v, $j5, $j6, $j3, $j4)
If Not _1h9($2v, $j5) Then
Return SetError(1, 0, False)
EndIf
If $j3 = Default Then
$j3 = False
EndIf
If $j6 = Default Then
$j6 = ''
EndIf
Local Const $j9 = _1hc($j3, $j4)
Local $ja = 1, $jb = '', $jc = 0
While 1
$jb = RegEnumVal($j9 & '\', $ja)
If @error Then
ExitLoop
EndIf
If($jb = $2v) And StringInStr(RegRead($j9 & '\', $jb), $j5, $1o) Then
$jc += RegDelete($j9 & '\', $2v)
EndIf
$ja += 1
WEnd
If $j8 Then
$jc = RegWrite($j9 & '\', $2v, 'REG_SZ', $j5 & ' ' & $j6) > 0
Else
$jc = $jc > 0
EndIf
Return $jc
EndFunc
_154("DarkTeal")
_1hq()
Global $jd[10] = ['[GUI]Tera Proxy'], $je[17], $jf[8], $jg[8], $jh[7]
Global $40 = 0, $ji = 0, $jj = 0, $jk = '', $jl = False, $jm
Global Const $jn = @TempDir & '\[GUI]Tera_Proxy'
Global Const $jo = @ScriptDir & '\bin\Proxy_GUI.ini'
Global Const $jp = @ScriptDir & '\bin\config.json'
Global Const $jq = @ScriptDir & '\bin\node_modules'
If _1hk(True) Then
If _1ga(4, $jd[0], 'Another ' & $jd[0] & ' has now running...' & @CRLF & 'Do you want to run new ' & $jd[0] & '?', 400, 11) <> 'Yes' Then Exit
_1hl(True)
EndIf
$jr = FileOpen($jo, 0)
If $jr < 0 Then _1ib()
FileClose($jr)
_1he()
_1hf()
_1ho()
Func _1he()
$jh[1] = TrayCreateItem("Start Proxy")
$jh[2] = TrayCreateItem("Module")
$jh[3] = TrayCreateItem("Setting")
$jh[4] = TrayCreateItem("Fix GUI")
$jh[5] = TrayCreateItem("About")
$jh[6] = TrayCreateItem("Exit")
TrayItemSetOnEvent($jh[1], "_1hh")
TrayItemSetOnEvent($jh[2], "_1id")
TrayItemSetOnEvent($jh[3], "_1i2")
TrayItemSetOnEvent($jh[4], "_1hg")
TrayItemSetOnEvent($jh[5], "_1iq")
TrayItemSetOnEvent($jh[6], "_1ir")
TraySetOnEvent($6p, "_1i3")
EndFunc
Func _1hf()
$jd[1] = _1fa($jd[0], 1015, 668, -1, -1, False)
$jd[2] = _1fd(True, False, True, False, True)
$jd[3] = GUICtrlCreateListView("", 8, 62, 998, 596, $f)
$jd[4] = _1fm("Print", 8, 38, 101, 21)
$jd[5] = _1fm("Clear", 116, 38, 101, 21)
$jd[6] = _1fm("Hosts", 224, 38, 101, 21)
$jd[7] = _1fm('Start Proxy', 805, 38, 201, 21)
$jd[8] = _1fm("Close Proxy", 597, 38, 201, 21)
$jd[9] = GUICtrlGetHandle($jd[3])
_m2($jd[9], BitOR($h, $i, $j))
_i8($jd[9], 'Console', 698, 0)
_m1($jd[9], 0, $1f)
ControlDisable($jd[1], "", HWnd(_jn($jd[3])))
_1fb($jd[1], True, False)
_1hz($jd[2])
_1fp($jd[8])
GUICtrlSetOnEvent($jd[4], "_1hw")
GUICtrlSetOnEvent($jd[5], "_1hx")
GUICtrlSetOnEvent($jd[6], "_1ii")
GUICtrlSetOnEvent($jd[7], "_1hh")
GUICtrlSetOnEvent($jd[8], "_1hh")
GUISetOnEvent($1g, "_1ir", $jd[1])
$je[1] = _1fa($jd[0], 404, 323, -1, -1, False)
$je[2] = _1fs("Auto start when windows startup", 8, 8, 300, 30)
$je[3] = _1fs("Auto start Tera Proxy when program up", 8, 40, 343, 30)
$je[4] = _1fs("Tray icon when minimize", 8, 72, 248, 30)
$je[5] = _1hy("Run:", 8, 112, 38, 17)
$je[6] = GUICtrlCreateInput(IniRead($jo, 'Config', 'Run', 'node bin/lib/proxy.js'), 50, 104, 345, 21)
$je[7] = _1fs("Use custom application to run Tera Proxy", 8, 136, 353, 30)
$je[8] = _1hy("Name:", 8, 176, 38, 17)
$je[9] = GUICtrlCreateInput(IniRead($jo, 'Config', 'Custom_Application_Name', 'electron.exe'), 50, 168, 345, 21)
$je[10] = _1hy("Regeion:", 8, 208, 55, 17)
$je[11] = GUICtrlCreateInput(_1i4(), 70, 200, 105, 21, 0x0001)
$je[12] = _1fs("Auto clear console", 8, 232, 212, 30)
$je[13] = _1hy("When:", 8, 272, 40, 17)
$je[14] = GUICtrlCreateInput(IniRead($jo, 'Config', 'Auto_Clear_When', 1000), 70, 264, 105, 21, 0x0001)
$je[15] = _1fm("Save", 56, 296, 145, 21)
$je[16] = _1fm("Close", 208, 296, 145, 21)
If _1h6() Then _1fy($je[2])
If IniRead($jo, 'Config', 'Auto_Run', 0) > 0 Then _1fy($je[3])
If IniRead($jo, 'Config', 'Minimize_Tray_Icon', 0) > 0 Then _1fy($je[4])
If IniRead($jo, 'Config', 'Custom_Application_Use', 0) > 0 Then _1fy($je[7])
If IniRead($jo, 'Config', 'Auto_Clear_Console', 0) > 0 Then _1fy($je[12])
GUICtrlSetOnEvent($je[2], "_1i6")
GUICtrlSetOnEvent($je[3], "_1i7")
GUICtrlSetOnEvent($je[4], "_1i8")
GUICtrlSetOnEvent($je[7], "_1i9")
GUICtrlSetOnEvent($je[12], "_1ia")
GUICtrlSetOnEvent($je[15], "_1ic")
GUICtrlSetOnEvent($je[16], "_1i5")
_1fb($je[1], True, False)
$jf[1] = _1fa($jd[0], 615, 438, -1, -1, False)
$jf[2] = GUICtrlCreateListView("", 8, 8, 601, 393)
$jf[3] = _1fm("All Enable", 8, 408, 129, 21)
$jf[4] = _1fm("All Disable", 144, 408, 129, 21)
$jf[5] = _1fm("Refresh", 280, 408, 129, 21)
$jf[6] = _1fm("Close", 472, 408, 129, 21)
$jf[7] = GUICtrlGetHandle($jf[2])
_m2($jf[7], BitOR($h, $i, $j, $g))
_i8($jf[7], 'Modules', 601, 0)
_m1($jf[7], 0, $1f)
ControlDisable($jf[1], "", HWnd(_jn($jf[2])))
GUICtrlSetOnEvent($jf[3], "_1ig")
GUICtrlSetOnEvent($jf[4], "_1if")
GUICtrlSetOnEvent($jf[5], "_1ih")
GUICtrlSetOnEvent($jf[6], "_1ie")
_1fb($jf[1], True, False)
$jg[1] = _1fa($jd[0], 1015, 668, -1, -1, False)
$jg[2] = GUICtrlCreateEdit("", 8, 62, 998, 596)
$jg[3] = _1fm('Close', 597, 38, 201, 21)
$jg[4] = _1fm('Save', 805, 38, 201, 21)
GUICtrlSetOnEvent($jg[3], "_1ij")
GUICtrlSetOnEvent($jg[4], "_1ik")
_1fb($jg[1], True, False)
GUIRegisterMsg(0x11, "_1ip")
GUIRegisterMsg($6k, "_1hu")
OnAutoItExitRegister('_1ir')
GUISetState(@SW_SHOW, $jd[1])
_1in($jd[1])
EndFunc
Func _1hg()
_1fc($jd[1])
_1fc($je[1])
_1fc($jf[1])
_1fc($jg[1])
_1hf()
If $jl Then
_1fp($jd[7])
_1fq($jd[8])
TrayItemSetText($jh[1], 'Close Proxy')
EndIf
EndFunc
Func _1hh()
If $jl Then
If _1ga(4, $jd[0], "Tera Proxy is now running..." & @CRLF & "Do you sure to close it now?", 400, 11, $jd[1]) = 'Yes' Then
$jl = False
_1hl()
_1fp($jd[8])
_1fq($jd[7])
TrayItemSetText($jh[1], 'Start Proxy')
_1hp('Closed...')
$jj = 0
EndIf
Else
If _1hk() Or _1il() Then
If _1ga(4, $jd[0], "Another Tera Proxy is now running..." & @CRLF & "Do you want to run new Tera Proxy?", 400, 11, $jd[1]) <> 'Yes' Then Return
_1hl()
_1im()
EndIf
$jl = True
$jj = 0
_1fp($jd[7])
_1fq($jd[8])
TrayItemSetText($jh[1], 'Close Proxy')
_in($jd[9])
AdlibRegister('_1hi', 0)
EndIf
EndFunc
Func _1hi()
AdlibUnRegister('_1hi')
$40 = Run('cmd.exe /k "' & IniRead($jo, 'Config', 'Run', 'node bin/lib/proxy.js') & '"', @ScriptDir, @SW_HIDE, 2 + 4)
ProcessWait(_1hm())
$ji = ProcessList(_1hm())
_1hj()
EndFunc
Func _1hj()
Local Const $js = $jn & '\TempPID.dat'
Local $jr = FileOpen($js, 10)
Local $jt = @ScriptName & @TAB & @AutoItPID & @CR & 'cmd.exe' & @TAB & $40
Local $ju = _1hm()
For $jv = 1 To $ji[0][0]
$jt &= @CR & $ju & @TAB & $ji[$jv][1]
Next
FileWrite($jr, $jt)
FileClose($jr)
EndFunc
Func _1hk($jw = False)
Local Const $js = $jn & '\TempPID.dat'
Local $jr = FileOpen($js, 0)
If $jr <= 0 Then Return False
Local $jx = _1hs(FileRead($jr)), $jy
FileClose($jr)
$jw = $jw ? 1 : 2
For $jv = $jw To $jx[0]
$jy = StringSplit($jx[$jv], @TAB)
If ProcessExists($jy[2]) Then
If StringInStr($jy[1], _1hn($jy[2])) Then Return True
EndIf
Next
FileDelete($js)
Return False
EndFunc
Func _1hl($jw = False)
Local Const $js = $jn & '\TempPID.dat'
Local $jr = FileOpen($js, 0)
If $jr <= 0 Then Return False
Local $jx = _1hs(FileRead($jr)), $jy
FileClose($jr)
FileDelete($js)
For $jv = 2 To $jx[0]
$jy = StringSplit($jx[$jv], @TAB)
If ProcessExists($jy[2]) Then
If StringInStr($jy[1], _1hn($jy[2])) Then ProcessClose($jy[2])
EndIf
Next
If $jw Then
$jy = StringSplit($jx[1], @TAB)
If ProcessExists($jy[2]) Then
If StringInStr($jy[1], _1hn($jy[2])) Then ProcessClose($jy[2])
EndIf
EndIf
Return True
EndFunc
Func _1hm()
Return IniRead($jo, 'Config', 'Custom_Application_Use', 0) > 0 ? IniRead($jo, 'Config', 'Custom_Application_Name', 'electron.exe') : 'node.exe'
EndFunc
Func _1hn($jz)
Local $k0 = ProcessList()
For $59 = 1 To UBound($k0) - 1
If $k0[$59][1] = $jz Then
Return $k0[$59][0]
EndIf
Next
Return SetError(1, 0, "")
EndFunc
Func _1ho()
If IniRead($jo, 'Config', 'Auto_Run', 0) > 0 Then _1hh()
EndFunc
Func _1hp($k1)
Local $5r = _jy($jd[9])
Local $k2 = StringLen($k1)
_1hr($jd[3], $k1)
_ix($jd[9], $5r)
If $k2 > $jj Then
_m1($jd[9], 0, $1f)
$jj = $k2
EndIf
If IniRead($jo, 'Config', 'Auto_Clear_Console', 0) > 0 Then
If IniRead($jo, 'Config', 'Auto_Clear_When', 0) <= $5r Then _in($jd[9])
EndIf
EndFunc
Func _1hq()
Global $22, $21, $24, $23
$23 = DllStructCreate($3e)
$24 = DllStructGetPtr($23)
$21 = DllStructCreate("char Text[2048]")
$22 = DllStructGetPtr($21)
DllStructSetData($23, "Text", $22)
DllStructSetData($23, "TextMax", 2048)
DllStructSetData($23, "Mask", BitOR($d, $b))
DllStructSetData($23, "Item", 999999999)
DllStructSetData($23, "Image", -1)
EndFunc
Func _1hr($1v, $5h)
DllStructSetData($21, "Text", $5h)
Return GUICtrlSendMsg($1v, $0z, 0, $24)
EndFunc
Func _1hs($k1)
Local $be = StringRegExp(@CRLF & $k1, "([^\r\n]*)(?:\r\n|\n|\r|$)", 3)
$be[0] = UBound($be) - 2
ReDim $be[UBound($be) - 1]
Return $be
EndFunc
Func _1ht($k3, $k4 = "*", $5a = 0)
Local $k5, $k6, $k7, $50 = StringReplace(BitAND($5a, 1) + BitAND($5a, 2), "3", "0"), $k8 = BitAND($5a, 4), $k9 = ""
$k3 = StringRegExpReplace($k3, "[\\/]+\z", "") & "\"
If Not FileExists($k3) Then Return SetError(1, 1, "")
If StringRegExp($k4, "[\\/:><]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
If BitAND($5a, 8) Then $k9 = $k3
If Not($50 = 0 Or $50 = 1 Or $50 = 2 Or $k8 = 4 Or $k9 <> "") Then Return SetError(3, 3, "")
$k5 = FileFindFirstFile($k3 & "*")
If @error Then Return SetError(4, 4, "")
Local $ka = $k5, $kb = $k5, $kc, $kd, $ke = "|", $kf = StringReplace($k4, "*", "")
$k4 = StringRegExpReplace(BitAND($5a, 16) & "(?i)", "16\(\?\i\)|\d+", "") & "(" & StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace("|" & $k4 & "|", '\|\h*\|[\|\h]*', "\|"), '[\^\$\(\)\+\[\]\{\}\,\.\]', "\\$0"), "\|([^\*])", "\|^$1"), "([^\*])\|", "$1\$\|"), '\*', ".*"), '^\||\|$', "") & ")"
While 1
$k6 = FileFindNextFile($ka)
If @error Then
If $ka = $k5 Then ExitLoop
FileClose($ka)
$ka -= 1
$kc = StringLeft($kc, StringInStr(StringTrimRight($kc, 1), "\", 1, -1))
ElseIf $k8 Then
$kd = @extended
If($50 + $kd <> 2) Then
If $kf Then
If StringRegExp($k6, $k4) Then $k7 &= $ke & $k9 & $kc & $k6
Else
$k7 &= $ke & $k9 & $kc & $k6
EndIf
EndIf
If Not $kd Then ContinueLoop
$kb = FileFindFirstFile($k3 & $kc & $k6 & "\*")
If $kb = -1 Then ContinueLoop
$ka = $kb
$kc &= $k6 & "\"
Else
If($50 + @extended = 2) Or StringRegExp($k6, $k4) = 0 Then ContinueLoop
$k7 &= $ke & $k9 & $k6
EndIf
WEnd
FileClose($k5)
If Not $k7 Then Return SetError(4, 4, "")
Return StringSplit(StringTrimLeft($k7, 1), "|", StringReplace(BitAND($5a, 32), "32", 2))
EndFunc
Func _1hu($1v, $45, $kg, $kh)
Local $ki, $kj, $kk, $kl, $7u, $km
$kl = DllStructCreate($3b, $kh)
$ki = HWnd(DllStructGetData($kl, "hWndFrom"))
$kj = DllStructGetData($kl, "IDFrom")
$kk = DllStructGetData($kl, "Code")
Switch $ki
Case $jd[9]
Switch $kk
Case $6n
$7u = DllStructCreate($3f, $kh)
$km = _kt($jd[9])
If $km <= 0 Then Return
Local $7o = _135(), $kn
$km = _kv($jd[9])
_12z($7o, "Copy", $kn)
Switch _153($7o, $jd[9], -1, -1, 1, 1, 2)
Case $kn
$kn = ''
$km = StringSplit($km, '|')
For $5w = 1 To $km[0]
$kn &= _kj($jd[9], $km[$5w]) & @CRLF
Next
ClipPut($kn)
EndSwitch
_137($7o)
EndSwitch
Case $jf[7]
Switch $kk
Case $6m, $6n
$7u = DllStructCreate($3f, $kh)
$km = DllStructGetData($7u, "Index")
If $km < 0 Then Return
If _jx($jf[7], $km) Then
_md($jf[7], $km, False)
Local $ko = _1hv($jm[$km + 1], 1) & '_' & _1hv($jm[$km + 1])
If StringInStr(FileGetAttrib($jm[$km + 1]), 'D') Then
DirMove($jm[$km + 1], $ko)
Else
FileMove($jm[$km + 1], $ko)
EndIf
$jm[$km + 1] = $ko
Else
_md($jf[7], $km)
Local $ko = _1hv($jm[$km + 1], 1) & StringReplace(_1hv($jm[$km + 1]), '_', '')
If StringInStr(FileGetAttrib($jm[$km + 1]), 'D') Then
DirMove($jm[$km + 1], $ko)
Else
FileMove($jm[$km + 1], $ko)
EndIf
$jm[$km + 1] = $ko
EndIf
EndSwitch
EndSwitch
Return $1h
EndFunc
Func _1hv($k1, $55 = 0)
For $5w = StringLen($k1) To 0 Step -1
If StringMid($k1, $5w, 1) = '\' Then Return $55 = 0 ? StringMid($k1, $5w + 1, StringLen($k1) - $5w) : StringLeft($k1, $5w)
Next
Return ''
EndFunc
Func _1hw()
If _jy($jd[9]) = 0 Then
_1ga(0, $jd[0], "No any data in console for print now :/", 400, 11, $jd[1])
Return False
EndIf
Local $kp = FileSaveDialog("Save to ...", @ScriptDir, "Text Documents (*.ini;*.txt;*log)|All Files (*.*)", 18, 'Console_' & @MDAY & '-' & @MON & '-' & @YEAR & '.log'), $kq
If Not @error And $kp <> '' Then
$kq = StringRegExpReplace($kp, "^(?:.*\\[^\\]*?)(\.[^.]+)?$", '\1')
If @error Or $kq = '' Then $kp = $kp & '.log'
$jr = FileOpen($kp, 10)
For $59 = 0 To _jy($jd[9]) - 1
FileWrite($jr, _kl($jd[9], $59) & @CRLF)
Next
FileClose($jr)
Return True
EndIf
Return False
EndFunc
Func _1hx()
If _jy($jd[9]) > 0 Then
If _1ga(4, $jd[0], "Do you sure to clear this console?", 400, 11, $jd[1]) = 'Yes' Then _in($jd[9])
Else
_1ga(0, $jd[0], "No any data in console for clear now :x", 400, 11, $jd[1])
EndIf
EndFunc
Func _1hy($5h, $bv, $bw, $bt, $bu)
Local $kr = GUICtrlCreateLabel($5h, $bv, $bw, $bt, $bu, -1, 0x00100000)
GUICtrlSetBkColor($kr, $7z)
GUICtrlSetColor($kr, $80)
GUICtrlSetFont($kr, 11, 400, 0, "Arial", 5)
Return $kr
EndFunc
Func _1hz($ks)
GUICtrlSetOnEvent($ks[0], "_1ir")
GUICtrlSetOnEvent($ks[3], "_1i1")
GUICtrlSetOnEvent($ks[6], "_1i0")
EndFunc
Func _1i0()
Local $kt[5] = [$jl ? 'Close Proxy' : 'Start Proxy', "Module", "Settings", "About", "Exit"]
Local $ku = _1fi($jd[1], 150, $kt)
Switch $ku
Case "0"
_1hh()
Case "1"
_1id()
Case "2"
GUISetState(@SW_SHOW, $je[1])
Case "3"
_1iq()
Case "4"
_1ir()
EndSwitch
EndFunc
Func _1i1()
If IniRead($jo, 'Config', 'Minimize_Tray_Icon', 0) > 0 Then
GUISetState(@SW_HIDE, $jd[1])
Else
GUISetState(@SW_MINIMIZE, $jd[1])
EndIf
EndFunc
Func _1i2()
GUISetState(@SW_SHOW, $je[1])
_1in($je[1])
EndFunc
Func _1i3()
GUISetState(@SW_SHOW, $jd[1])
_1in($jd[1])
EndFunc
Func _1i4()
Local $jr = FileOpen($jp)
Local $kv = FileRead($jr)
FileClose($jr)
Local $kw = StringRegExp($kv, '"region".*?:.*?"(.*?)"', 3)
If Not @error Then Return StringUpper($kw[0])
Return ''
EndFunc
Func _1i5()
GUISetState(@SW_HIDE, $je[1])
EndFunc
Func _1i6()
If _1fv($je[2]) Then
_1fx($je[2])
Else
_1fy($je[2])
EndIf
EndFunc
Func _1i7()
If _1fv($je[3]) Then
_1fx($je[3])
Else
_1fy($je[3])
EndIf
EndFunc
Func _1i8()
If _1fv($je[4]) Then
_1fx($je[4])
Else
_1fy($je[4])
EndIf
EndFunc
Func _1i9()
If _1fv($je[7]) Then
_1fx($je[7])
Else
_1fy($je[7])
EndIf
EndFunc
Func _1ia()
If _1fv($je[12]) Then
_1fx($je[12])
Else
_1fy($je[12])
EndIf
EndFunc
Func _1ib()
IniWrite($jo, 'Config', 'Run', 'node bin/lib/proxy.js')
IniWrite($jo, 'Config', 'Auto_Run', 0)
IniWrite($jo, 'Config', 'Minimize_Tray_Icon', 0)
IniWrite($jo, 'Config', 'Custom_Application_Use', 0)
IniWrite($jo, 'Config', 'Custom_Application_Name', 'electron.exe')
IniWrite($jo, 'Config', 'Auto_Clear_Console', 0)
IniWrite($jo, 'Config', 'Auto_Clear_When', 1000)
EndFunc
Func _1ic()
IniWrite($jo, 'Config', 'Run', GUICtrlRead($je[6]))
IniWrite($jo, 'Config', 'Auto_Run', _1fv($je[3]) ? 1 : 0)
IniWrite($jo, 'Config', 'Minimize_Tray_Icon', _1fv($je[4]) ? 1 : 0)
IniWrite($jo, 'Config', 'Custom_Application_Use', _1fv($je[7]) ? 1 : 0)
IniWrite($jo, 'Config', 'Custom_Application_Name', GUICtrlRead($je[9]))
IniWrite($jo, 'Config', 'Auto_Clear_Console', _1fv($je[12]) ? 1 : 0)
IniWrite($jo, 'Config', 'Auto_Clear_When', GUICtrlRead($je[14]))
If _1fv($je[2]) Then
If Not _1h6() Then _1h7()
Else
If _1h6() Then _1h8()
EndIf
If GUICtrlRead($je[11]) <> _1i4() Then
Local $jr = FileOpen($jp, 0)
Local $kv = FileRead($jr)
FileClose($jr)
$kv = StringRegExpReplace($kv, '"region".*?:.*?"(.*?)"', '"region": "' & StringUpper(GUICtrlRead($je[11])) & '"')
$jr = FileOpen($jp, 10)
FileWrite($jr, $kv)
FileClose($jr)
GUICtrlSetData($je[11], StringUpper(GUICtrlRead($je[11])))
EndIf
GUISetState(@SW_HIDE, $je[1])
EndFunc
Func _1id()
_1ih()
GUISetState(@SW_SHOW, $jf[1])
_1in($jf[1])
EndFunc
Func _1ie()
$jm = ''
_in($jf[7])
GUISetState(@SW_HIDE, $jf[1])
EndFunc
Func _1if()
Local $ko
For $kx = 1 To $jm[0]
$ko = _1hv($jm[$kx])
If StringLeft($ko, 1) <> '_' Then
$ko = _1hv($jm[$kx], 1) & '_' & $ko
If StringInStr(FileGetAttrib($jm[$kx]), 'D') Then
DirMove($jm[$kx], $ko)
Else
FileMove($jm[$kx], $ko)
EndIf
$jm[$kx] = $ko
_md($jf[7], $kx - 1, False)
EndIf
Next
EndFunc
Func _1ig()
Local $ko
For $kx = 1 To $jm[0]
$ko = _1hv($jm[$kx])
If StringLeft($ko, 1) = '_' Then
$ko = _1hv($jm[$kx], 1) & StringReplace(_1hv($jm[$kx]), '_', '')
If StringInStr(FileGetAttrib($jm[$kx]), 'D') Then
DirMove($jm[$kx], $ko)
Else
FileMove($jm[$kx], $ko)
EndIf
$jm[$kx] = $ko
_md($jf[7], $kx - 1)
EndIf
Next
EndFunc
Func _1ih()
If Not FileExists($jq) Then Return
_in($jf[7])
$jm = _1ht($jq, '*', 8)
Local $k2 = 0, $ky = 0, $ko
For $kx = 1 To $jm[0]
$ko = _1hv($jm[$kx])
_1hr($jf[2], StringLeft($ko, 1) = '_' ? StringReplace($ko, '_', '') : $ko)
If StringLeft($ko, 1) = '_' Then
_md($jf[7], $kx - 1, False)
Else
_md($jf[7], $kx - 1)
EndIf
_ix($jf[7], _jy($jf[7]) - 1)
$k2 = StringLen($ko)
If $k2 > $ky Then
_m1($jf[7], 0, $1f)
$ky = $k2
EndIf
Next
EndFunc
Func _1ii()
Local $ko = @SystemDir & '\Drivers\Etc\hosts'
Local $jr = FileOpen($ko, 0 + FileGetEncoding($ko))
GUICtrlSetData($jg[2], FileRead($jr, FileGetSize($ko)))
FileClose($jr)
GUISetState(@SW_SHOW, $jg[1])
EndFunc
Func _1ij()
GUICtrlSetData($jg[2], '')
GUISetState(@SW_HIDE, $jg[1])
EndFunc
Func _1ik()
Local $ko = @SystemDir & '\Drivers\Etc\hosts'
Local $jr = FileOpen($ko, 10 + FileGetEncoding($ko))
FileWrite($jr, GUICtrlRead($jg[2]))
FileClose($jr)
GUISetState(@SW_HIDE, $jg[1])
EndFunc
Func _1il()
Local $k0 = ProcessList(_1hm())
Return $k0[0][0] > 1
EndFunc
Func _1im()
Local $k0 = ProcessList(_1hm())
For $59 = 1 To $k0[0][0]
ProcessClose($k0[$59][1])
Next
EndFunc
Func _1in($kz)
If Not WinActive($kz) Then WinActivate($kz)
EndFunc
Func _1io()
_1fc($jd[1])
_1fc($je[1])
_1fc($jf[1])
_1fc($jg[1])
ProcessClose(@AutoItPID)
Exit
EndFunc
Func _1ip($l0, $l1, $46, $47)
_1hl()
_1io()
Return True
EndFunc
Func _1iq()
_1ga(0, $jd[0], "Kappa :v" & @CRLF & @CRLF & "Version: 2.3" & @CRLF & 'Create by: Fukki' & @CRLF & 'Github: https://github.com/Fukki/Tera-Proxy-Gui/', 400, 11, $jd[1])
EndFunc
Func _1ir()
If $jl Then
If _1ga(4, $jd[0], "Tera Proxy is now running..." & @CRLF & "Do you sure to exit now?", 400, 11, $jd[1]) <> 'Yes' Then Return
_1hl()
EndIf
_1io()
EndFunc
While Sleep(250)
If $jl And $40 > 0 Then
$jk = StdoutRead($40)
If $jk <> '' Then
$jk = _1hs($jk)
For $59 = 1 To $jk[0]
If $jk[$59] <> '' Then
_1hp($jk[$59])
Sleep(1)
EndIf
Next
$jk = ''
EndIf
EndIf
WEnd
