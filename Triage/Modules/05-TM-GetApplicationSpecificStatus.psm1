function Get-TName()
{
    return "Getting Application Specific Services"
}

function Get-TData()
{
	if(-not $services -eq $null)
	{
		Clear-Variable $services
	}
	$services = @()
	$services += Get-Service | Where-Object {$_.Name -eq "BFE"}
	$services += Get-Service | Where-Object {$_.Name -eq "WdiServiceHost"}

	$returnObject =[pscustomobject]@{
		data = $services 
	}
	return $returnObject
}

function Get-TReportData($object)
{
	$report = "Application Specific Services List: "
	foreach($service in $object.data)
	{
		$report += "`n"
		$report += "Service: "
		$report += $service.Name
		$report += "`n"
		$report += "Status: "
		$report += $service.Status
	}
	return $report
}

function Get-THTMLData($object)
{
	$report = "<b>Application Specific Services List: </b>"
	foreach($service in $object.data)
	{
		$report += "`n"
		$report += "</br><b>Service: </b>"
		$report += $service.Name
		$report += "`n"
		$report += "</br><b>Status: </b>"
		$report += $service.Status
	}
	$report += "</br>"
	return $report	
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -Function Get-THTMLData