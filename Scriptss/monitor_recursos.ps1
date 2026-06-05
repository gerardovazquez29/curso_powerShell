
# Monitoreo de Disco y RAM
# Autor: Santiago
# Fecha: Junio 2026
# Descripcion: Verifica espacio en disco C: y memoria RAM disponible

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "   MONITOR DE RECURSOS DEL SISTEMA   " -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# -------- DISCO C:--------
$discoinfo = Get-PSDrive -Name C
$libre = [Math]::Round($discoinfo.Free / 1GB,2)
$usado = [Math]::Round($discoinfo.Used / 1GB,2)
$total = [Math]::Round(($discoinfo.Free + $discoinfo.Used) / 1GB,2)

Write-Host "DISCO C:" -ForegroundColor White 
Write-Host "  Total : $total GB"
Write-Host "  Usado : $usado GB"
Write-Host "  Libre : $libre GB"

if ($libre -lt 10) {
    Write-Host "Estado: ALERTA - Poco espacio ($libre GB libres)" -ForegroundColor Red
}elseif ($libre -lt 30) {
    Write-Host "Estado: AVISO - Espacio moderado ($libre GB libres)" -ForegroundColor Yellow
}else {
    Write-Host "Estado: OK - Espacio suficiente ($libre GB libres)" -ForegroundColor Green
}

Write-Host ""

# ----- MEMORIA RAM  -----
$ram = Get-CimInstance -ClassName Win32_OperatingSystem
$ramtotal = [Math]::Round($ram.TotalVisibleMemorySize / 1MB, 2)
$ramlibre = [Math]::Round($ram.FreePhysicalMemory    / 1MB, 2)
$ramusada = [Math]::Round($ramtotal - $ramlibre, 2)

Write-Host "MEMORIA RAM:" -ForegroundColor White
Write-Host "  Total : $ramtotal GB"
Write-Host "  Usada : $ramusada GB"
Write-Host "  Libre : $ramlibre GB"

if ($ramlibre -lt 1) {
    Write-Host "  Estado: ALERTA - RAM critica ($ramlibre GB libres)" -ForegroundColor Red
} elseif ($ramlibre -lt 4) {
    Write-Host "  Estado: AVISO  - RAM moderada ($ramlibre GB libres)" -ForegroundColor Yellow
} else {
    Write-Host "  Estado: OK     - RAM suficiente ($ramlibre GB libres)" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Revision completada: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

