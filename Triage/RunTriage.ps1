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
    #Write-Host $data.data
    $result = Get-TReportData $data
    Write-Host $result
    return $data
}


$modules = Get-Content -Path '.\Modules.txt'
$moduleFolder = '.\Modules'

$htmlData = ""
foreach($module in $modules)
{
    #Write-Host $module
    $moduleLocation = $moduleFolder + '\'  + $module
    #Write-Host $moduleLocation
    Import-Module -Name $moduleLocation #-Verbose
    $data = RunCheck
    $htmlData += Get-THTMLData $data
    $htmlData += "</br>"
    Remove-Module $module.Replace('.psm1','')
}


$htmlData = GenerateHTMLHeader $htmlData
Write-Host $htmlData
Set-Content -Path .\Report\Report.html $htmlData

