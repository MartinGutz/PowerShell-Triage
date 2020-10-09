function Get-TName()
{
    return "Checking Network Connections"
}

function Get-TData()
{
	$hosts = @()
	$hosts += "google.com"
	$hosts += "cnn.com"
	$connections = @()
	foreach($computerHost in $hosts)
	{
		$computerIP = [System.Net.Dns]::GetHostAddresses($computerHost)[0]
		try {
			$connection = Get-NetTCPConnection -ErrorAction SilentlyContinue | Where-Object -Property RemoteAddress -eq $computerIP
			if ($connection -eq $null) {
				$notFoundConnection =[pscustomobject]@{
					name = $computerHost
					TCPConnection = ""
					isConnectionFound = $false
				}
				$connections += $notFoundConnection
			}else {
				$foundConnection =[pscustomobject]@{
					name = $computerHost
					TCPConnection = $connection
					isConnectionFound = $true
				}
				$connections += $foundConnection
			}
		}
		 catch [Exception] {
			Write-Host "Exception Encountered:"
			Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
		}
	}

	$returnObject =[pscustomobject]@{
		data = $connections
	}
	return $returnObject
}

function Get-TReportData($data)
{
	$report = "Network Connections:"
	foreach($value in $data.data)
	{
		$report += "`n Connection Name:"
		$report += $value.Name
		if($value.isConnectionFound)
		{
			$report += "`n  Status: Connected"
			$report += "`n  Remote IP: "
			$report += $value.TCPConnection.RemoteAddress
			$report += "`n  Remote Port: "
			$report += $value.TCPConnection.RemotePort
			$report += "`n  TCP State: "
			$report += $value.TCPConnection.State
			$report += "`n  Local Port: "
			$report += $value.TCPConnection.LocalPort
		}else {
			$report += "`n  Status: Disconnected"
		}
	}
	return $report
}

function Get-THTMLData($data)
{
	$report = "<b>Network Connections:</b>"
	foreach($value in $data.data)
	{
		$report += "`n </br><b>Connection Name:</b>"
		$report += $value.Name
		if($value.isConnectionFound)
		{
			$report += "`n  </br><b>Status:</b> Connected</br>"
			$report += "`n  <b>Remote IP</b>: "
			$report += $value.TCPConnection.RemoteAddress
			$report += "`n  </br>"
			$report += "`n  <b>Remote Port</b>: "
			$report += $value.TCPConnection.RemotePort
			$report += "`n  </br>"
			$report += "`n  <b>TCP State</b>: "
			$report += $value.TCPConnection.State
			$report += "`n  </br>"
			$report += "`n  <b>Local Port</b>: "
			$report += $value.TCPConnection.LocalPort
			$report += "`n  </br>"
		}else {
			$report += "`n  </br><b>Status:</b> Disconnected</br>"
		}
	}
	return $report
}

Export-ModuleMember -Function Get-TName
Export-ModuleMember -Function Get-TData
Export-ModuleMember -function Get-TReportData
Export-ModuleMember -function Get-THTMLData