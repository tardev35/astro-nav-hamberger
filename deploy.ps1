param (
    [string]$Domain
)

# 🌟 เปลี่ยนเป็น IP ของ Vultr คุณตรงนี้ 🌟
$VPS_IP = "45.32.122.181"  
$VPS_USER = "root"

if (-not $Domain) {
    Write-Host "Error: Please provide a domain! Example: .\deploy.ps1 pigauto998.info" -ForegroundColor Red
    exit
}

Write-Host "[1/2] Building Astro project..." -ForegroundColor Cyan
npx astro build --force

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Build failed! Please check your code." -ForegroundColor Red
    exit
}

Write-Host "[2/2] Code ready! Uploading to VPS ($Domain)..." -ForegroundColor Yellow

scp -r dist\* "${VPS_USER}@${VPS_IP}:/var/www/${Domain}/dist/"

Write-Host "Success! $Domain is online!" -ForegroundColor Green