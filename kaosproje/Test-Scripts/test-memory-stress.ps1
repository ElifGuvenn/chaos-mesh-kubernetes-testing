$yamlFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Experiments\memory-stress.yaml"

Write-Host "--- Chaos Test: Memory Stress ---" -ForegroundColor Cyan

if (-not (Test-Path $yamlFile)) {
    Write-Host "HATA: Dosya bulunamadi!" -ForegroundColor Red
    exit
}

kubectl apply --dry-run=client -f $yamlFile
$confirm = Read-Host "Memory Stress baslatilsin mi? (y/n)"
if ($confirm -eq 'y') { 
    kubectl apply -f $yamlFile
    Write-Host "Bellek yukleniyor, 10 saniye bekle..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    $podName = kubectl get pods -l app=backend -o jsonpath="{.items[0].metadata.name}"
    # Pod icindeki bellek kullanimini gosterir
    kubectl exec $podName -- free -m
}