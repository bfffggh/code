#Calling user32.dll methods for Windows and Menus
$MethodsCall = '
[DllImport("user32.dll")] public static extern long GetSystemMenu(IntPtr hWnd, bool bRevert);
[DllImport("user32.dll")] public static extern bool EnableMenuItem(long hMenuItem, long wIDEnableItem, long wEnable);
[DllImport("user32.dll")] public static extern long SetWindowLongPtr(long hWnd, long nIndex, long dwNewLong);
[DllImport("user32.dll")] public static extern bool EnableWindow(long hWnd, int bEnable);
'
 
#Create a new namespace for the Methods to be able to call them
Add-Type -MemberDefinition $MethodsCall -name NativeMethods -namespace Win32
 
#WM_SYSCOMMAND Message
$MF_GRAYED = 0x00000001L    #Indicates that the menu item is disabled and grayed so that it cannot be selected.
$MF_BYCOMMAND = 0x0               #Gives the identifier of the menu item. If neither the MF_BYCOMMAND nor MF_BYPOSITION flag is specified, the MF_BYCOMMAND flag is the default flag.            
$MF_DISABLED = 0x00000002L #Indicates that the menu item is disabled, but not grayed, so it cannot be selected.
$MF_ENABLED = 0x00000000L #Indicates that the menu item is enabled and restored from a grayed state so that it can be selected.
#... http://msdn.microsoft.com/en-us/library/windows/desktop/ms647636(v=vs.85).aspx
 
$SC_CLOSE = 0xF060
$SC_CONTEXTHELP = 0xF180
$SC_MAXIMIZE = 0xF030 
$SC_MINIMIZE = 0xF020 
$SC_TASKLIST = 0xF130
$SC_MOUSEMENU = 0xF090
$SC_KEYMENU = 0xF100
#... http://msdn.microsoft.com/en-us/library/windows/desktop/ms646360(v=vs.85).aspx
 
$GWL_EXSTYLE = -20
$GWL_STYLE = -16
#... http://msdn.microsoft.com/en-us/library/windows/desktop/ms644898(v=vs.85).aspx
 
#WM_SETICON Message  -  http://msdn.microsoft.com/en-us/library/ms632643%28VS.85%29.aspx
$WM_SETICON = 0x0080;
$ICON_SMALL = 0;
$ICON_BIG = 1;
 
#Extended Window Styles
$WS_EX_DLGMODALFRAME = 0x00000001L
$WS_EX_NOACTIVATE = 0x08000000L
$WS_EX_TOOLWINDOW = 0x00000080L
$WS_EX_STATICEDGE = 0x00020000L
$WS_EX_WINDOWEDGE = 0x00000100L
$WS_EX_TRANSPARENT = 0x00000020L
$WS_EX_CLIENTEDGE = 0x00000200L
$WS_EX_LAYERED = 0x00080000
$WS_EX_TOPMOST = 0x00000008L
#... http://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
 
#Get window handle of Powershell process (Ensure there is only one Powershell window opened)
$PSWindow = (Get-Process Powershell) | where {$_.MainWindowTitle -like "*Powershell*"}
$hwnd = $PSWindow.MainWindowHandle
 
#Get System menu of windows handled
$hMenu = [Win32.NativeMethods]::GetSystemMenu($hwnd, 0)
 
#Window Style : TOOLWINDOW
[Win32.NativeMethods]::SetWindowLongPtr($hwnd, $GWL_EXSTYLE, $WS_EX_TOOLWINDOW) | Out-Null
 
#Disable X Button and window itself
[Win32.NativeMethods]::EnableMenuItem($hMenu, $SC_CLOSE, $MF_DISABLED) | Out-Null
[Win32.NativeMethods]::EnableWindow($hwnd, 0) | Out-Null
 
Write-Host "Disabled!" -ForegroundColor Red 
sleep 5
 
#Enable X Button
[Win32.NativeMethods]::EnableMenuItem($hMenu, $SC_CLOSE, $MF_ENABLED) | Out-Null
[Win32.NativeMethods]::EnableWindow($hwnd, 1) | Out-Null
 
Write-Host "Enabled!" -ForegroundColor Green
sleep 2