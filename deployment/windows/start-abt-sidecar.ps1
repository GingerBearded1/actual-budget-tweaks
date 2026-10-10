[CmdletBinding()]
param(
	[string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path,
	[string]$NodePath = "C:\Program Files\nodejs\node.exe",
	[string]$BindHost = "127.0.0.1",
	[int]$Port = 3005,
	[string]$ActualOrigin = "http://127.0.0.1:5006"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
$serverPath = Join-Path $RepoRoot "docker\server.js"
$assetsPath = Join-Path $RepoRoot ".output\chrome-mv3"
$packageJsonPath = Join-Path $RepoRoot "package.json"

foreach ($requiredPath in @($NodePath, $serverPath, $assetsPath, $packageJsonPath)) {
	if (-not (Test-Path -LiteralPath $requiredPath)) {
		throw "Required ABT path does not exist: $requiredPath"
	}
}

$logDirectory = Join-Path $RepoRoot "logs"
$logPath = Join-Path $logDirectory "sidecar.log"
New-Item -ItemType Directory -Path $logDirectory -Force | Out-Null

$env:HOST = $BindHost
$env:PORT = $Port.ToString([Globalization.CultureInfo]::InvariantCulture)
$env:ACTUAL_ORIGIN = $ActualOrigin
$env:ASSETS_DIR = $assetsPath
$env:PACKAGE_JSON_PATH = $packageJsonPath

"[$(Get-Date -Format o)] Starting ABT on ${BindHost}:$Port, proxying $ActualOrigin" |
	Add-Content -LiteralPath $logPath

& $NodePath $serverPath *>> $logPath
$exitCode = $LASTEXITCODE

"[$(Get-Date -Format o)] ABT exited with code $exitCode" |
	Add-Content -LiteralPath $logPath

exit $exitCode
