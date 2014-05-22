Set-StrictMode -version Latest

$moduleName= "posh-git"

$ScriptDir = split-path -parent $MyInvocation.MyCommand.Path

Push-Location ($ScriptDir)

$files = ".\$moduleName.psm1", ".\CheckVersion.ps1", ".\Utils.ps1", ".\GitUtils.ps1",".\GitPrompt.ps1",".\GitTabExpansion.ps1",".\TortoiseGit.ps1"

foreach ($file in $files)
{ 
    if ((Test-Path $file) -eq $false)
    { 
        $err = "{0} is missing" -f $file
        Write-Warning $err
        return 
    }
}

$modPath = ($ENV:PSModulePath -split ';')[0]
$fullPath = $modPath + "\$moduleName"

if (! (Test-Path $fullPath) )
{
    New-Item -type directory -Path $fullPath > $null
}

Copy-Item $files -Destination $fullPath -Force 

Pop-Location

"Execute 'import-module $moduleName' to use"
