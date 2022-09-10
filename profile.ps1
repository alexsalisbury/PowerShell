function prompt {
    $MachinePrefix = Get-Content -Path Env:\MachinePrefix;
	$topline = $MachinePrefix + (Get-Date -Format "|ddMMM_HHmmss|");
	$userLocation = '['+[System.Environment]::MachineName + '] ' + $pwd
	$host.UI.RawUi.WindowTitle = $userLocation
    
	Write-Host($topline) -nonewline -foregroundcolor Green
    Write-Host($pwd) -nonewline -foregroundcolor Green    
	Write-Host('>') -nonewline -foregroundcolor Green	
	return " "
}

function PS_Ctor
{    
    #$RepoLocation = [System.Environment]::RepoLocation
    $RepoLocation = "D:\Source\Repos"
    if (! (test-path -isvalid $RepoLocation)) {
	    $RepoLocation = "C:\Source\Repos"
    } 
   
    Set-Location $RepoLocation

    Set-PSReadLineKeyHandler -Key Enter -ScriptBlock { 
        $line = ""
        $cursor = 0
        $esc = [char]27
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)   
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine() 
        Write-Host "$esc[0G" -NoNewline
        prompt;
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($line)
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine();
    }

}

PS_Ctor

## Clean up
Remove-Item Function:PS_Ctor