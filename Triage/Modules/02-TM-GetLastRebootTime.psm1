function Get-TName()
{
    return "Checking Application Specific Processes"
}

function Get-TData()
{
	$rebootTime = Get-CimInstance -ClassName win32_operatingsystem | Select-Object lastbootuptime
	$returnObject =[pscustomobject]@{
		data = $rebootTime
	}
	return $returnObject
}

function Get-TReportData($object)
{
	$report = "Last Reboot: "
	$report += $object.data.lastbootuptime
	return $report
}

function Get-THTMLData($object)
{
	$report = "<b>Last Reboot: </b>"
	$report += $object.data.lastbootuptime
	$report += "</br>"
	return $report
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData