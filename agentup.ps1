param(
    [Parameter(Position=0)][ValidateSet('setup','voice','preview','render','login','check')][string]$Action = 'preview',
    [Parameter(Position=1)][ValidateSet('douyin','bilibili','tencent','youtube')][string]$Platform,
    [string]$Account = 'main'
)
$ErrorActionPreference = 'Stop'
$env:PYTHONUTF8 = '1'
$root = $PSScriptRoot
$publisher = Join-Path $root 'publisher'
$env:SAU_BILIUP_RUNTIME_ROOT = Join-Path $publisher '.runtime/biliup'
function Run-Checked([string]$Program, [string[]]$Arguments) {
    & $Program @Arguments
    if ($LASTEXITCODE -ne 0) { throw "$Program failed (exit $LASTEXITCODE)" }
}
Push-Location $root
try {
    switch ($Action) {
        'setup' {
            Run-Checked 'uv' @('sync')
            Push-Location $publisher
            try {
                if (-not (Test-Path 'conf.py')) { Copy-Item 'conf.example.py' 'conf.py' }
                Run-Checked 'uv' @('sync')
            } finally { Pop-Location }
            Push-Location (Join-Path $root 'remotion')
            try { Run-Checked 'npm.cmd' @('ci') } finally { Pop-Location }
        }
        'voice' { Run-Checked 'uv' @('run','scripts/voice.py') }
        'preview' {
            Push-Location (Join-Path $root 'remotion')
            try { Run-Checked 'npm.cmd' @('run','studio') } finally { Pop-Location }
        }
        'render' {
            Push-Location (Join-Path $root 'remotion')
            try { Run-Checked 'npm.cmd' @('run','render') } finally { Pop-Location }
        }
        default {
            Push-Location $publisher
            try {
                if (-not $Platform) { throw 'Please supply a platform: douyin/bilibili/tencent/youtube' }
                $cli = @('run','sau',$Platform,$Action,'--account',$Account)
                if ($Action -eq 'login' -and $Platform -ne 'bilibili') { $cli += '--headed' }
                Run-Checked 'uv' $cli
            } finally { Pop-Location }
        }
    }
} finally { Pop-Location }
