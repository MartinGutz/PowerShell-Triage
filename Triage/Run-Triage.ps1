<#
.SYNOPSIS
This is a PowerShell script to generate a simple HTML report with computer information and checks for specific errors

.DESCRIPTION
Run the command Run-Triage and then check the Reports folder created

.EXAMPLE
Run-Triage.ps1 -ReportLocation ".\Report\Out.html"

This will run a command that will run the modules and generate a report in the location specified. The report will be named Out.html

.EXAMPLE
Run-Triage.ps1 -ReportLocation ".\Report\-DatedReport.html" -DatedReport

This will run a command that will run the modules and generate a report in the location specified. The report will be named YYYY-MM-DD-hh-mm-ss-Out.html

.NOTES

.LINK
https://github.com/MartinGutz/PowerShell-Triage

#>

param (
    [switch]$DatedReport = $false,
    [switch]$OutputResultsToConsole = $false,
    [Parameter(Mandatory=$true)] [string] $ReportLocation
)

function GenerateHTMLHeader($htmlData)
{
    $htmlReport = "<html><title></title>"
    $htmlReport += $htmlData
    $htmlReport += "</html>"
    return $htmlReport
}

function RunCheck()
{
    $name = Get-TName
    Write-Host "Running Module:" $name -ForegroundColor Green
    $data = Get-TData
    if($OutputResultsToConsole)
    {
        $result = Get-TReportData $data
        Write-Host $result
    }
    return $data
}

function CheckForReportFolder($reportLocation)
{
    if(-Not (Test-Path -Path (Split-Path -Path $reportLocation) -PathType Container))
    {
        New-Item -Path . -Name (Split-Path -Path $reportLocation) -ItemType "directory"
    }
}

$modules = Get-Content -Path '.\Modules.txt'
$moduleFolder = '.\Modules'

$htmlData = ""
foreach($module in $modules)
{
     if($Verbose -eq $true)
    {
        Write-Host "VERBOSE: Found Module" $module -ForegroundColor Yellow
    }
    
    $moduleLocation = $moduleFolder + '\'  + $module
    if($Verbose -eq $true)
    {
        Write-Host "VERBOSE: Module Location:" $moduleLocation -ForegroundColor Yellow
        Import-Module -Name $moduleLocation -Verbose
    }else
    {
        Import-Module -Name $moduleLocation
    }
    $data = RunCheck
    $htmlData += Get-THTMLData $data
    $htmlData += "</br>"
    Remove-Module $module.Replace('.psm1','')
}


$htmlData = GenerateHTMLHeader $htmlData
CheckForReportFolder $ReportLocation
if($DatedReport)
{   
    $datedReportName = (Split-Path -Path $reportLocation) + ("\") + (Get-Date -format yyyy-MM-dd-HH-mm-ss) + (Split-Path $reportLocation -Leaf)
    Set-Content -Path $datedReportName $htmlData    
}else {
    Set-Content -Path $ReportLocation $htmlData    
}



