param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("8", "11", "17")]
    [string]$javaVersion
)

# Check if the script is running with administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script requires administrator privileges. Please run PowerShell as Administrator." -ForegroundColor Red
    exit 1
}

# Construct the environment variable name
$javaHomeVar = "JAVA_HOME_$javaVersion"

# Get the value of the corresponding environment variable
$javaHomeValue = [System.Environment]::GetEnvironmentVariable($javaHomeVar, "Machine")

if ($javaHomeValue) {
    # Set the JAVA_HOME environment variable
    [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHomeValue, "Machine")
    Write-Host "JAVA_HOME has been set to the value of ${javaHomeVar}: $javaHomeValue" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Environment variable ${javaHomeVar} not found. Please ensure it is properly configured." -ForegroundColor Red
    exit 1
}
