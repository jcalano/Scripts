#***********************************
#*** Hide the PowerShell window  ***
#***********************************
#
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@

$consoleWindow = [System.Diagnostics.Process]::GetCurrentProcess().MainWindowHandle
[Win32]::ShowWindow($consoleWindow, 0)  # 0 = SW_HIDE to hide the window
#***********************************
#*** End Hide PowerShell window  ***
#***********************************

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#***********************************
#*** Create the form container   ***
#***********************************

$form = New-Object System.Windows.Forms.Form
$form.Text = "SQL Server Services Controller"
$form.Size = New-Object System.Drawing.Size(345, 750)
#***********************************
#***    Create the list box      ***
#***********************************

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Size = New-Object System.Drawing.Size(310, 654)
$listBox.Location = New-Object System.Drawing.Point(10, 10)
$listBox.SelectionMode = [System.Windows.Forms.SelectionMode]::MultiExtended
$form.Controls.Add($listBox)
#***********************************
#***  End create the list box    ***
#***********************************
#***********************************
#*** End Create form container   ***
#***********************************
#
#***********************************
#*** Set properties for buttons  ***
#***********************************
$defaultBtnProps = @{
    Width = 100
    Height = 30
}
#***********************************
#*** End properties for buttons  ***
#***********************************
#
#***********************************
#*** Create buttons w/properties ***
#***********************************
#
$startButton = New-Object System.Windows.Forms.Button -Property $defaultBtnProps
$startButton.Text = "Start Service"
$startButton.Location = New-Object System.Drawing.Point(10, 670)
$startButton.Add_Click({
    foreach ($item in $listBox.SelectedItems) {
        $instanceName = $item -replace 'SQL Server \((.*?)\)', '$1'
        Start-Service -Name "SQL Server ($instanceName)"
        Start-Service -Name "SQL Server Agent ($instanceName)"
        # Check the status after starting
        $sqlService = Get-Service -Name "SQL Server ($instanceName)"
        $agentService = Get-Service -Name "SQL Server Agent ($instanceName)"
        [System.Windows.Forms.MessageBox]::Show("SQL Server ($instanceName) is $($sqlService.Status)`nSQL Server Agent ($instanceName) is $($agentService.Status)")
    }
})
$form.Controls.Add($startButton)

$stopButton = New-Object System.Windows.Forms.Button -Property $defaultBtnProps
$stopButton.Text = "Stop Service"
$stopButton.Location = New-Object System.Drawing.Point(115, 670)
$stopButton.Add_Click({
    foreach ($item in $listBox.SelectedItems) {
        $instanceName = $item -replace 'SQL Server \((.*?)\)', '$1'
        Stop-Service -Name "SQL Server Agent ($instanceName)"
        Stop-Service -Name "SQL Server ($instanceName)"
        # Check the status after stopping
        $sqlService = Get-Service -Name "SQL Server ($instanceName)"
        $agentService = Get-Service -Name "SQL Server Agent ($instanceName)"
        [System.Windows.Forms.MessageBox]::Show("SQL Server ($instanceName) is $($sqlService.Status)`nSQL Server Agent ($instanceName) is $($agentService.Status)")
    }
})
$form.Controls.Add($stopButton)

$exitButton = New-Object System.Windows.Forms.Button -Property $defaultBtnProps
$exitButton.Text = "Exit"
$exitButton.Location = New-Object System.Drawing.Point(220, 670)
$exitButton.Add_Click({ $form.Close() })
$form.Controls.Add($exitButton)
#***********************************
#***  End buttons w/properties   ***
#***********************************
#
#***********************************
#*** Find SQL Service Instances  ***
#***********************************
#
Get-Service | Where-Object { $_.DisplayName -like "SQL Server (*" } | ForEach-Object {
    $listBox.Items.Add($_.DisplayName)
}
#***********************************
#*** End Find Service Instances  ***
#***********************************
#
#***********************************
#***       Show the form         ***
#***********************************
#
$form.ShowDialog()
#
#***********************************
#***        End show form        ***
#***********************************
#***********************************
# SQL Server Services Controller   *
# © 2024 by Jim Calano is licensed *
# under CC BY-NC-SA 4.0            *
#***********************************
