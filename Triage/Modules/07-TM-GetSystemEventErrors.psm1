function Get-TName()
{
    return "Getting System Events"
}

function Get-TData()
{
    try {
        $data = (Get-EventLog -LogName System -EntryType Error -Newest 5 -ErrorAction Stop)
        $returnObject =[pscustomobject]@{
            data = $data
        }
    }
    catch {
        Write-Host "No matches found"
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
	$report = "<b>Windows System Events: </b>"
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
Export-ModuleMember -function Get-THTMLData