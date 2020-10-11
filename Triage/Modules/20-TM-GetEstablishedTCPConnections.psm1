function Get-TName()
{
    return "Checking WebSite Status"
}

function Get-TData()
{
	$siteName = "https://www.google.com"
    $website = Invoke-WebRequest -Uri $siteName -UseBasicParsing
    $returnObject =[pscustomobject]@{
		sitename = $siteName
		data = $website
	}
    return $returnObject
}

function Get-TReportData($object)
{
	$report = "WebSite: "
	$report += $object.siteName
	$report += "`n Site Return Code: " 
	$report += $object.data.StatusCode
	return $report	
}

function Get-THTMLData($object)
{
	$report = "<b>WebSite: </b>"
	$report += $object.siteName
	$report += "</br><b>Site Return Code: </b>" 
	$report += $object.data.StatusCode
	return $report
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData