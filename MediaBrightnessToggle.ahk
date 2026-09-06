toggleMode := false

Media_Play_Pause::
{
    global toggleMode := !toggleMode
}

#HotIf toggleMode

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