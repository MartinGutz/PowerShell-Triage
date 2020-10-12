function Get-TName()
{
    return "Checking Json Status"
}

function Get-TData()
{
	$siteName = "https://api.github.com/repos/PowerShell/PowerShell/issues"
    $jsonResults = Invoke-WebRequest $siteName -UseBasicParsing | ConvertFrom-Json
    $returnObject =[pscustomobject]@{
		sitename = $siteName
		data = $jsonResults
	}
    return $returnObject
}

function Get-TReportData($object)
{
	$report = "WebSite: "
	$report += $object.siteName
	foreach($result in $object.data){
		$report += "`n ID: " + $result.id 
		$report += " Number: " + $result.number
	}
	return $report	
}

function Get-THTMLData($object)
{
	$report = "<b>WebSite:</b> "
	$report += $object.siteName
	foreach($result in $object.data){
		$report += "</br><b>ID: </b>" + $result.id 
		$report += "<b>Number: </b>" + $result.number
	}
	$report += "</br>"
	return $report	
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData