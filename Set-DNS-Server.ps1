# Get the ID and security principal of the current user account

$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()

$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

 

# Get the security principal for the Administrator role

$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

 

# Check to see if we are currently running "as Administrator"

if ($myWindowsPrincipal.IsInRole($adminRole))

   {

   # We are running "as Administrator" - so change the title and background color to indicate this

   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"

   $Host.UI.RawUI.BackgroundColor = "DarkBlue"

   clear-host

   }

else

   {

   # We are not running "as Administrator" - so relaunch as administrator

   

   # Create a new process object that starts PowerShell

   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

   

   # Specify the current script path and name as a parameter

   $newProcess.Arguments = $myInvocation.MyCommand.Definition;

   

   # Indicate that the process should be elevated

   $newProcess.Verb = "runas";

   

   # Start the new process

   [System.Diagnostics.Process]::Start($newProcess);

   

   # Exit from the current, unelevated, process

   exit

   }

Get-NetAdapter | Sort-Object InterfaceIndex


$NIC = Read-Host "IfIndex der zu ändernden Netzwerkkarte eingeben:"



Write-Host "Drücke 1 um den DNS-Server auf DHCP zu stellen"
Write-Host "Drücke 2 um den DNS-Server auf Google DNS zu stellen"
Write-Host "Drücke 3 um den DNS-Server auf SmartDNS zu stellen"
Write-Host "Drücke 4 um den DNS-Server auf Cloudflare DNS zu stellen"

$choice = Read-Host "Welchen DNS möchtest Du haben?"

If ($choice -eq "1")
    {
    Set-DnsClientServerAddress -InterfaceIndex $NIC -ResetServerAddresses
    }

If ($choice -eq "2")
    {
    Set-DnsClientServerAddress -InterfaceIndex $NIC -ServerAddresses ("8.8.8.8","8.8.4.4")

    }

If ($choice -eq "3")
    {
    Set-DnsClientServerAddress -InterfaceIndex $NIC -ServerAddresses ("54.93.173.153","46.166.189.68")
    }

    If ($choice -eq "4")
    {
    Set-DnsClientServerAddress -InterfaceIndex $NIC -ServerAddresses ("1.1.1.1")
    }