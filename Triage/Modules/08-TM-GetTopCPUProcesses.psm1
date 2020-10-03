function Get-TName()
{
    return "Getting Top CPU Processes"
}

function Get-TData()
{
	$processes = (Get-Counter '\Process(*)\% Processor Time' -ErrorAction SilentlyContinue ).CounterSamples | Where-Object {$_.CookedValue -gt 5}
	$returnObject =[pscustomobject]@{
		data = $processes
	}
	return $returnObject
}

function Get-TReportData($objects)
{
	$report = "Top CPU Users (over 5%): "
	foreach($object in $objects.data)
	{
		$report += "`n Process Name: "
		$report += $object.InstanceName
		$report += "`n CPU Usage: "
		$report += [math]::Round($object.CookedValue, 2)
        $report += "%"
	}
	return $report	
}

function Get-THTMLData($objects)
{
	$report = "<b>Top CPU Users (over 5%): </b>"
	foreach($object in $objects.data)
	{
		$report += "`n </br><b>Process Name: </b>"
		$report += $object.InstanceName
		$report += "`n </br><b>CPU Usage: </b>"
		$report += [math]::Round($object.CookedValue, 2)
        $report += "%"
	}
	$report += "</br>"
	return $report		
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -Function Get-THTMLData