function Get-TName()
{
    return "Getting Application Events"
}

function Get-TData()
{
	$data = (Get-EventLog -LogName Application -EntryType Error -Newest 5)
	$returnObject =[pscustomobject]@{
		data = $data
	}
	return $returnObject
}

function Get-TReportData($objects)
{
	$report = "Events: "
	foreach($object in $objects.data)
	{
		$report += "`n"
		$report += " Event: " 
		$report += "`n"
		$report += ($object.Message).ToString().substring(0,100)
		$report += "..."
	}
	return $report	
}

function Get-THTMLData($objects)
{
	$report = "<b>Windows Application Events: </b>"
	foreach($object in $objects.data)
	{
		$report += "`n"
		$report += " </br><b>Event: </b>" 
		$report += "`n"
		$report += ($object.Message).ToString()
	}
	$report += "</br>"
	return $report	
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -Function Get-THTMLData