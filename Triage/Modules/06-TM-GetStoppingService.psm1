function Get-TName()
{
    return "Getting Any Stopping Services"
}

function Get-TData()
{
	if(-not $services -eq $null)
	{
		Clear-Variable $services
	}
	$services = Get-Service | Where-Object {$_.Status -eq "Stopping"}
	$returnObject =[pscustomobject]@{
		data = $services 
	}
	return $returnObject
}

function Get-TReportData($object)
{
	$report = "Stopping Services List: `n"
	if($services -eq $null)
	{
		$report += "No Stopping Services Found"
	}else
	{
		foreach($service in $services)
		{
			$report += "Service: "
			$report += $service.Name
			$report += "`n"
		}
	}
	return $report
}

function Get-THTMLData($object)
{
	$report = "<b>Stopping Services List: </b>`n"
	if($services -eq $null)
	{
		$report += "</br>No Stopping Services Found"
	}else
	{
		foreach($service in $services)
		{
			$report += "</br><b>Service: </b>"
			$report += $service.Name
			$report += "`n"
		}
	}
	$report += "</br>"
	return $report
}


Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -Function Get-TReportData
Export-ModuleMember -Function Get-THTMLData