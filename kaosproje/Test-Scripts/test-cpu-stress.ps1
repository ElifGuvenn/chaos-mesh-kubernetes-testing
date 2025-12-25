
$yamlFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Experiments\cpu-stress.yaml"

Write-Host "--- Chaos Test: CPU Stress ---" -ForegroundColor Cyan

if (-not (Test-Path $yamlFile)) {
    Write-Host "HATA: Dosya bulunamadi! Aranan yer: $yamlFile" -ForegroundColor Red
    exit
}

kubectl apply --dry-run=client -f $yamlFile
$confirm = Read-Host "CPU Stress baslatilsin mi? (y/n)"
if ($confirm -eq 'y') { 
    kubectl apply -f $yamlFile
    Write-Host "Stres yukleniyor, 10 saniye bekle..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    $podName = kubectl get pods -l app=backend -o jsonpath="{.items[0].metadata.name}"
    kubectl exec $podName -- top -n 1
}