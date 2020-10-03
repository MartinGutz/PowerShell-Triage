function Get-TName()
{
    return "Getting Drive Space"
}

function Get-TData()
{
	$diskInfo = Get-WmiObject -Class Win32_logicaldisk
	$returnObject =[pscustomobject]@{
		data = $diskInfo
	}
	return $returnObject
}

function Get-TReportData($objects)
{
	$report = "Drive: "
	foreach($object in $objects.data)
	{
		$report += "`n Drive ID: " 
		$report += $object.DeviceID 
		$report += "`n Free Space: " 
		$report += [math]::Round($object.FreeSpace / 1GB,2)
		$report += "`n Total Size: " 
		$report += [math]::Round($object.Size / 1GB,2)
	}
	return $report	
}

function Get-THTMLData($objects)
{
	$report = "<b>Drive List: </b>"
	foreach($object in $objects.data)
	{
		$report += "`n <br/><b>Drive ID: </b>" 
		$report += $object.DeviceID 
		$report += "`n <br/><b>Free Space: </b>" 
		$report += [math]::Round($object.FreeSpace / 1GB,2)
		$report += "`n <br/><b>Total Size: </b>" 
		$report += [math]::Round($object.Size / 1GB,2)
	}
	$report += "</br>"
	return $report	
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData