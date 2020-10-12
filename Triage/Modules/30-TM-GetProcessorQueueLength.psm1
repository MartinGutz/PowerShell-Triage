function Get-TName()
{
    return "Checking Processor Queue Length"
}

function Get-TData()
{
    $results = Get-Counter -Counter "\System\Processor Queue Length" -SampleInterval 2 -MaxSamples 3
    $returnObject =[pscustomobject]@{
		data = $results
	}
    return $returnObject
}

function Get-TReportData($object)
{
	$report = "Processor Queue Length: "
	foreach($result in $object.data){
		$report += "`n Time: " + $result.TimeStamp
		$report += " Value: " + $result.CounterSamples.CookedValue
	}
	return $report	
}

function Get-THTMLData($object)
{
	$report = "<b>Processor Queue Length: </b></br>"
	foreach($result in $object.data){
		$report += "<b>Time: </b>" + $result.TimeStamp
		$report += "<b> Value: </b>" + $result.CounterSamples.CookedValue
		$report += "</br>"
	}
	return $report
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData