param (
    [switch]$Verbose = $false,
    [switch]$DatedReport = $false,
    [switch]$OutputResultsToConsole = $false
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

function CheckForReportFolder()
{
    $reportFolder = ".\Report"
    if(-Not (Test-Path -Path $reportFolder -PathType Container))
    {
        New-Item -Path . -Name "Report" -ItemType "directory"
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
CheckForReportFolder
if($DatedReport)
{   
    $reportName = ".\Report\" + (Get-Date -format yyyy-MM-dd-HH-mm-ss) + "-TriageReport.html"
    Set-Content -Path $reportName $htmlData    
}else {
    Set-Content -Path .\Report\Report.html $htmlData    
}



