function Get-TName()
{
    return "Getting OS Version"
}

function Get-TData()
{
	$returnObject =[pscustomobject]@{
		data = [environment]::OSVersion.Version 
	}
	return $returnObject
}

function Get-TReportData($object)
{
	$report = "OS Version: "
	$report += $object.data
	return $report
}

function Get-THTMLData($object)
{
	$report = "<b>OS Version: </b>"
	$report += $object.data
	$report += "</br>"
	return $report
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData