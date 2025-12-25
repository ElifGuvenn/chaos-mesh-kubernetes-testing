$yamlFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Experiments\network-loss.yaml"

Write-Host "--- Chaos Test: Network Loss ---" -ForegroundColor Cyan

if (-not (Test-Path $yamlFile)) {
    Write-Host "HATA: Dosya bulunamadi! Aranan yer: $yamlFile" -ForegroundColor Red
    exit
}

kubectl apply --dry-run=client -f $yamlFile
$confirm = Read-Host "Network Loss baslatilsin mi? (y/n)"
if ($confirm -eq 'y') { 
    kubectl apply -f $yamlFile
    kubectl get networkchaos
}