function Get-TName()
{
    return "Checking Application Specific Processes"
}

function Get-TData()
{
	$processesToCheck = @()
	$processesToCheck += "Notepad"
	$processesToCheck += "OneDrive"
	
	$processList = @()
	$processes = Get-Process
	
	foreach($processName in $processesToCheck)
	{
		if(($processes | Where-Object {$_.Name -contains $processName}))
		{
			$foundProcess = ($processes | Where-Object {$_.Name -contains $processName})
			$foundProcessItem =[pscustomobject]@{
				name = $processName
				data = $foundProcess
				isFound = $true
			}
			$processList += $foundProcessItem
		}else {
			$foundProcessItem =[pscustomobject]@{
				name = $processName
				data = ""
				isFound = $false
			}
			$processList += $foundProcessItem
		}
	}

	$returnObject =[pscustomobject]@{
		data = $processList
	}
	return $returnObject
}

function Get-TReportData($objects)
{
	$report = "Process List: "
	foreach($object in $objects.data)
	{
		$report += "`n Process Name: "
		$report += $object.Name
		if ($object.isFound) {
			$report += "`n Process Status: Running"
			$report += "`n Process ID: "
			$report += $object.data.Id
		}else{
			$report += "`n Process Status: Not Found"
			$report += "`n Process ID: -"
		}
	}
	$report += "</br>"
	return $report
}

function Get-THTMLData($objects)
{
	$report = "<b>Status of Application Processes: </b>"
	foreach($object in $objects.data)
	{
		$report += "</br><b>Process Name: </b>"
		$report += $object.Name
		if ($object.isFound) {
			$report += "</br><b>Process Status: </b>Running"
			$report += "</br><b>Process ID: </b>"
			$report += $object.data.Id
		}else{
			$report += "</br><b>Process Status: </b>Not Found "
			$report += "</br><b>Process ID: </b>-"
		}
	}
	return $report
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData