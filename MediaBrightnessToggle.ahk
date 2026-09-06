toggleMode := false

SetTimer(CheckFortniteRunning, 2000)

CheckFortniteRunning()
{
	global toggleMode
	static warned := false

	if (ProcessExist("FortniteClient-Win64-Shipping_EAC_EOS.exe") || ProcessExist("FortniteClient-Win64-Shipping.exe"))
	{
		if (!warned)
		{
			warned := true
			toggleMode := false
			SoundPlay("*48")
			ShowTogglePopup("ff3b3b", "⚠️", "Fortnite Detected", "Toggle has been disabled. Please turn off AHK for maximum safety.", true)
		}
	}
	else
		warned := false
}

Media_Play_Pause::
{
    global toggleMode := !toggleMode

	if (toggleMode)
		ShowTogglePopup("FFB020", "🔆", "Brightness Mode", "Volume keys adjust brightness", false)
	else
		ShowTogglePopup("3B9EFF", "🔊", "Volume Mode", "Volume keys control volume", false)
}

ShowTogglePopup(accentColor, icon, title, subtitle, hasClose)
{
	popUpWidth := 320
	popUpHeight := 90

	borderWidth := 3
	cornerRadius := 16
	innerRadius := Max(2, cornerRadius - (borderWidth * 2))
	panelWidth := popUpWidth - (borderWidth * 2)
	panelHeight := popUpHeight - (borderWidth * 2)

	togglePopup := Gui("-Caption +AlwaysOnTop +ToolWindow -DPIScale")
	togglePopup.BackColor := accentColor

	panelCtrl := togglePopup.Add("Text", Format("x{} y{} w{} h{} Background202020", borderWidth, borderWidth, panelWidth, panelHeight))

	togglePopup.SetFont("cWhite s11 Bold", "Segoe UI")
	titleCtrl := togglePopup.Add("Text", "x68 y0 w234 Background202020", title)

	togglePopup.SetFont("cAAAAAA s9 Norm", "Segoe UI")
	subtitleCtrl := togglePopup.Add("Text", "x68 y+2 w234 Background202020", subtitle)

	titleCtrl.GetPos(&tx, &ty, &tw, &th)
	subtitleCtrl.GetPos(&sx, &sy, &sw, &sh)

	blockHeight := (sy + sh) - ty
	blockY := (popUpHeight - blockHeight) // 2

	titleCtrl.Move(, blockY)
	subtitleCtrl.Move(, blockY + (sy - ty))

	iconSize := 36
	togglePopup.SetFont("s18", "Segoe UI Emoji")
	togglePopup.Add("Text", Format("x18 y{} w{} h{} Center 0x200 c{} Background202020", (popUpHeight - iconSize) // 2, iconSize, iconSize, accentColor), icon)

	if (hasClose)
	{
		closeSize := 20
		togglePopup.SetFont("cAAAAAA s10 Bold", "Segoe UI")
		closeCtrl := togglePopup.Add("Text", Format("x{} y{} w{} h{} Center 0x200 Background202020", popUpWidth - borderWidth - closeSize - 6, borderWidth + 6, closeSize, closeSize), "×")
		closeCtrl.OnEvent("Click", ClosePopup)
	}

	MonitorGetWorkArea(, &Left, &Top, &Right, &Bottom)

	xPos := Right - popUpWidth - 20
	yPos := Bottom - popUpHeight - 20

	togglePopup.Show(Format("x{} y{} w{} h{} NA", xPos, yPos, popUpWidth, popUpHeight))
	WinSetRegion(Format("0-0 w{} h{} R{}-{}", popUpWidth, popUpHeight, cornerRadius, cornerRadius), togglePopup)
	WinSetRegion(Format("0-0 w{} h{} R{}-{}", panelWidth, panelHeight, innerRadius, innerRadius), "ahk_id " panelCtrl.Hwnd)


	if(!hasClose) 
		SetTimer(ClosePopup, -2000)

	ClosePopup(*)
	{
		SetTimer(ClosePopup, 0)
		togglePopup.Destroy()
	}
}

#HotIf toggleMode && !WinActive("ahk_exe FortniteClient-Win64-Shipping.exe")

Volume_Up::
{
    ChangeBrightness(GetCurrentBrightness() + 10)
}

Volume_Down::
{
    ChangeBrightness(GetCurrentBrightness() - 10)
}

ChangeBrightness( brightness, timeout := 1 )
{
	global CurrentBrightness
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightnessMethods" )
		property.WmiSetBrightness( timeout, &CurrentBrightness := Max(0, Min(brightness, 100)) )

}

GetCurrentBrightNess()
{
	global CurrentBrightness
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
		currentBrightness := property.CurrentBrightness	
	return currentBrightness
}