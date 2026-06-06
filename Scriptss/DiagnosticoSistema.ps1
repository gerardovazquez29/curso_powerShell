
#==========================================
# Scripts: DiagnosticoSistema.ps1
# Autor: Santiago
# Descripcion: Diagnostico basico del Sistema
#===========================================

function VerEspacio {
    $libre = [Math]::Round((Get-PSDrive C).Free / 1GB, 2)
    Write-Host "Espacio Libre C: $libre GB" -ForegroundColor Cyan
}

function VerServicios {
    param ([string[]]$lista)
    foreach ($s in $lista) {
        $estado = (Get-Service -Name $s).Status
        Write-Host " $s --> $estado"
    }
}

function PingHost {
    param ([string]$ip)
    $resultado = Test-Connection -ComputerName $ip -Count 1 -Quiet
    if ($resultado) {
        Write-Host "$ip responde" -ForegroundColor Green
    } else {
        Write-Host "$ip no responde" -ForegroundColor Red
    }
}

# ------- EJECUCION -------
Write-Host "=== DIAGNOSTICO DEL SISTEMA ===" -ForegroundColor Yellow
VerEspacio
VerServicios -lista @("WinRM", "Spooler", "WinDefend")
PingHost -ip "192.168.241.1"

<#
=== DIAGNOSTICO DEL SISTEMA ===
Espacio Libre C: 57.89 GB
 WinRM --> Stopped
 Spooler --> Running
 WinDefend --> Running
192.168.241.1 responde
#>