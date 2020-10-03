param (
    [switch]$Verbose = $false
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
    $result = Get-TReportData $data
    return $data
}


$modules = Get-Content -Path '.\Modules.txt'
$moduleFolder = '.\Modules'

$htmlData = ""
foreach($module in $modules)
{
    #
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
#Write-Host $htmlData
Set-Content -Path .\Report\Report.html $htmlData

