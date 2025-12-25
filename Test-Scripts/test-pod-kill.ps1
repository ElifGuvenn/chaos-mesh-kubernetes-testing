
$yamlFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Experiments\pod-kill.yaml"

Write-Host "--- Chaos Test: Pod Kill ---" -ForegroundColor Cyan

if (-not (Test-Path $yamlFile)) {
    Write-Error "HATA: YAML dosyasi bulunamadi! Su yolu kontrol et: $yamlFile"
    exit
}

# 1. Dry-Run
kubectl apply --dry-run=client -f $yamlFile

$confirm = Read-Host "Uygulansin mi? (y/n)"
if ($confirm -eq 'y') { 
    kubectl apply -f $yamlFile
    Write-Host "Pod durumu izleniyor (Terminating bekleyin)..." -ForegroundColor Yellow
    # 10 saniye boyunca listeyi yeniler
    kubectl get pods -w
}