<#
.SYNOPSIS
Execute oci cli commands switching multiple profiles

.DESCRIPTION
Before we use this cmdlet, we need to configure cli config file path, compartment id, profile(optional) to `config.json` file at the same directory with this cmdlet.
And we do not need to specify `oci`, cli config file path, compartment id, profile(optional) when executing oci cli commands.

.PARAMETER Key
key on `config.json`

.PARAMETER Command
OCI CLI command other than `oci`, `--config-file`, `--compartment-id`, `--profile`
#>

Param(
    [Parameter(Mandatory)][String]$Key,
    [String]$Command
)

Set-Variable -Name CONFIG_FILE_NAME -Value "config.json" -Option Constant
Set-Variable -Name PROFILE_KEY -Value "profile" -Option Constant

$ConfigFilePath = (Join-Path -Path $PSScriptRoot $CONFIG_FILE_NAME)

if ( -not (Test-Path -Path $ConfigFilePath) )
{
    Write-Output "configure ``./${CONFIG_FILE_NAME}``"
    exit 1
}

$Contents = (Get-Content -Raw -Path $ConfigFilePath | ConvertFrom-Json)

$ConfigValue = $null

foreach ($Content in $Contents)
{
    if ( $Content.key -eq $Key )
    {
        $ConfigValue = $Content.value
    }
}

if ( $null -eq $ConfigValue )
{
    Write-Output "key: $Key not found"
    exit 1
}

$OciConfigFilePath = $ConfigValue.config_file_path
$OciCompartmentId = $ConfigValue.compartment_id

$OciConfigProfile = ""
if ( $null -ne $ConfigValue.profile )
{
    $OciConfigProfile = $ConfigValue.profile
}

if ( $OciConfigProfile -eq "" )
{
    $OciConfigProfile = "DEFAULT"
}

Write-Host $OciConfigFilePath
Write-Host $OciCompartmentId
Write-Host $OciConfigProfile

