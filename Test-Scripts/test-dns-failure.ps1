# Dosya yolunu otomatik ve hatasiz bulan satir
$yamlFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Experiments\dns-failure.yaml"

Write-Host "--- Chaos Test: DNS Spoofing ---" -ForegroundColor Cyan

# Dosya kontrolü
if (-not (Test-Path $yamlFile)) {
    Write-Host "HATA: Dosya bulunamadi! Aranan yer: $yamlFile" -ForegroundColor Red
    exit
}

# Dry-run (Önizleme)
kubectl apply --dry-run=client -f $yamlFile

$confirm = Read-Host "DNS Spoofing baslatilsin mi? (y/n)"
if ($confirm -eq 'y') { 
    kubectl apply -f $yamlFile
    Write-Host "DNS manipule ediliyor, 5 saniye bekle..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    
    # Pod ismini bul ve icinde sorgu yap
    $pod = (kubectl get pods -l app=backend -o jsonpath="{.items[0].metadata.name}")
    Write-Host "Sorgu sonucu ($pod):" -ForegroundColor Green
    kubectl exec $pod -- nslookup example.com
}