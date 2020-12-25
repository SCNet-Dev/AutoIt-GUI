; Instruction for compilation ===================================================================================================

;!Highly recommended for improved overall performance and responsiveness of the GUI effects etc.! (after compiling):
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm /pe

;YOU NEED TO EXCLUDE FOLLOWING FUNCTIONS FROM AU3STRIPPER, OTHERWISE IT WON'T WORK:
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
;Please not that Au3Stripper will show errors. You can ignore them as long as you use the above Au3Stripper_Ignore_Funcs parameters.

;Required if you want High DPI scaling enabled. (Also requries _Metro_EnableHighDPIScaling())
#AutoIt3Wrapper_Res_HiDpi=y
; ===============================================================================================================================

; Example =======================================================================================================================

; Include
#include <StaticConstants.au3>
#include "..\SCNetGUI_UDF.au3"

; Set theme (cf Themes.au3)
_SetTheme("SCNet_Light")

; Create GUI
$Form1 = _SCN_CreateGUI("Exemple", 405, 300, -1, -1)
_SCN_SetGUIOption($Form1, True)
	
; Setting GUI button
$Control_Buttons = _SCN_AddControlButtons(True, False, True, False, False) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

; Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
$GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]
	
; Create title windows
_SCN_CreateLabel("Example | _SCN_CreateComboBox", 12, 1.5, 280, 29, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)

; Create ComboBox (with last setting to true for hover effet with light theme)
$Combo1 = _SCN_CreateComboBox("Item 1", 50, 50, 120, 34, Default, Default, Default, 8, Default, Default, True)

; Show GUI
GUISetState(@SW_SHOW, $Form1)

;~ Free non necessary memory
DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)

While 1
	;_SCN_HoverCheck_Loop($GUI_Client) ; Commande obligatoire pour les effets de survol
	Local $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
			; Delete GUI & Exit
			_SCN_GUIDelete($Form1)
			Exit
		Case $GUI_MINIMIZE_BUTTON
			; Minimize GUI
			GUISetState(@SW_MINIMIZE)
		Case $Combo1
			; Click on combobox, set an array with item then show the menu and return the position of selected item with _SCN_ComboBoxMenu
			Dim $Items[3] = ["Item1", "Item 2", "Item 3"]
			$Combo_Item = _SCN_ComboBoxMenu($Items, $Form1, $Combo1)
			
			;Check the return (if -1 then none selected)
			If $Combo_Item <> -1 Then
				;Hide the old combobox in order to redraw the new one
				GUICtrlSetState($Combo1, $GUI_HIDE)
				; Redraw the new combobox with item selected
				$Combo1 = _SCN_CreateComboBox($Items[$Combo_Item], 50, 50, 120, 34, Default, Default, Default, Default, Default, Default, True)
			EndIf	
	EndSwitch
Wend