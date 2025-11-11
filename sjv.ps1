<#
脚本名称：sjv.ps1
功能：切换 Windows 系统中的 Java 版本
使用方法：.\_sjv.ps1 8（需管理员权限）
参数说明：
    脚本后直接跟版本：指定要切换的 Java 版本， 8、11、17、21 中的一个
#>

param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("8", "11", "17","21")]
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

#环境变量中需要添加JAVA_HOME、JAVA_HOME_8、JAVA_HOME_11、JAVA_HOME_17、JAVA_HOME_21。
