$DME_FILE = "colonialmarines.dme"
$DM_PATH = "C:\Program Files (x86)\BYOND\bin\DreamMaker.exe"

if (-not (Test-Path $DM_PATH)) {
    Write-Host "Error: DreamMaker not found at $DM_PATH" -ForegroundColor Red
    exit 1
}

$maxIter = 50
$iter = 0
$allReverted = @()

while ($iter -lt $maxIter) {
    $iter++
    Write-Host "===== Compile #$iter =====" -ForegroundColor Cyan

    $output = & $DM_PATH $DME_FILE 2>&1 | Out-String

    $errorFiles = @()
    foreach ($line in ($output -split "`n")) {
        if ($line -match "^(.+?\.dm):(\d+):error:") {
            $f = $Matches[1].Trim()
            if ($f -and ($errorFiles -notcontains $f)) {
                $errorFiles += $f
            }
        }
    }

    if ($errorFiles.Count -eq 0) {
        if ($output -match "0 errors") {
            Write-Host "Compile SUCCESS!" -ForegroundColor Green
            Write-Host "Reverted $($allReverted.Count) files total"
            $allReverted | ForEach-Object { Write-Host "  $_" }
            exit 0
        }
        Write-Host "Cannot parse output:" -ForegroundColor Red
        Write-Host $output
        exit 1
    }

    Write-Host "Found $($errorFiles.Count) files with errors" -ForegroundColor Yellow

    foreach ($f in $errorFiles) {
        Write-Host "Reverting: $f" -ForegroundColor Magenta
        git checkout -- $f 2>$null
        if ($allReverted -notcontains $f) { $allReverted += $f }
    }
}

Write-Host "Max iterations reached" -ForegroundColor Red
