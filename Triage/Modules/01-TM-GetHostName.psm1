function Get-TName()
{
    return "Getting HostName"
}

function Get-TData()
{
	$returnObject =[pscustomobject]@{
		data = $env:computername
	}
	return $returnObject
}

function Get-TReportData($object)
{
	$report = "Total RAM: "
	$report += $object.data
	return $report	
}

function Get-THTMLData($object)
{
	$report = "<b>Total RAM: </b>"
	$report += $object.data
	$report += "</br>"
	return $report
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData