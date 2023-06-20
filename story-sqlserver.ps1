<#
Generate a report of all SQL Servers in the domain.

1) What Information does my script need to even start

- Which Domain?
- Additional Computers to scan
- Credential
- Output path for report

2) What steps do I need to take?

- Identify computers to scan
for each:
  - perform scan, generate data
- Write the report

3) What is our outcome?

Exact fields of information, format of report, specifics
#>

[CmdletBinding()]
param (
	[string]
	$Domain = $env:USERDNSDOMAIN,

	[string[]]
	$ComputerName,

	[PSCredential]
	$Credential,

	[string]
	$OutPath
)

$ErrorActionPreference = 'Stop'
trap {
	Write-Warning "Script failed: $_"
	throw $_
}

#region Functions
function Get-DomainComputer {
	[CmdletBinding()]
	param (
		
	)

	#TODO: Implement
}
#endregion Functions

$computers = Get-DomainComputer -Domain $Domain -Credential $Credential -ComputerNames $ComputerName
$instances = foreach ($computer in $computers) {
	Get-SqlServerInstance -ComputerName $computer -Credential $Credential
}
Write-SqlInstanceReport -Data $instances -Path $OutPath

<#
A) Use GUI for Reference

B) The Four Phases

1. Identify Targets to work against
2. Gather data needed to execute
3. Execute
4. Report (Optional)
#>