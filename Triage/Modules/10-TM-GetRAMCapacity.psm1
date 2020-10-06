function Get-TName()
{
    return "Getting Total RAM"
}

function Get-TData()
{
	$RAM = Get-WMIObject -class Win32_PhysicalMemory | Measure-Object -Property capacity -Sum 
	$returnObject =[pscustomobject]@{
		data = $RAM.Sum / 1GB
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