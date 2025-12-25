Write-Host "--- Chaos Test: DNS Spoofing ---" -ForegroundColor Cyan
kubectl apply -f ../Experiments/dns-failure.yaml
Write-Host "Test uygulandi. Sorgu yapiliyor..." -ForegroundColor Yellow
$pod = (kubectl get pods -l app=backend -o jsonpath="{.items[0].metadata.name}"); kubectl exec $pod -- nslookup example.com