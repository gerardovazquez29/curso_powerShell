<#
Ejercicio 1 — Tu Primera Función:
Crea una función llamada MostrarInfo que reciba como parámetro $equipo 
y muestre el nombre del equipo, la versión de PowerShell y la fecha actual.
Pista: Usa $PSVersionTable.PSVersion y Get-Date
#>
function MostrarInfo {
    param (
        [string]$equipo = "localHost")
    $version = $PSVersionTable.PSVersion
    $fecha = Get-Date

    Write-Host "===================="
    Write-Host "Equipo : $equipo"
    Write-Host "PowerShell : $version"
    Write-Host "Fecha : $fecha"
    Write-Host "===================="
}
MostrarInfo -equipo "ThinkPad T470"
 
<#
====================
Equipo : ThinkPad T470
PowerShell : 5.1.19041.7291
Fecha : 06/06/2026 15:17:19
====================
#>

Write-Host "======================================================="
<#
Ejercicio 2 — Función Reutilizable de Red:
Crea una función TestearRed que reciba un array de IPs y 
haga ping a cada una mostrando si responde o no. Pruébala con las IPs de tu lab:

192.168.241.10 → SRV-DC01
10.10.10.1 → tu red VMnet2
8.8.8.8 → Google DNS
#>

function TestearRed {
    param (
        [Parameter(Mandatory, HelpMessage="Escribe las IPs a probar")]
        [string[]]$ips
        )
    foreach ($ip in $ips) {
        $ok = Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue

        [PSCustomObject]@{
            IP        = $ip
            Responde  = [bool]$ok
            Timestamp = (Get-Date)
        }
    }
}
# Mostrar en Tabla
TestearRed -ips @("192.168.1.1", "8.8.8.8","10.10.10.1", "192.168.241.10") | Format-Table -AutoSize
# Solo ips que no responden
TestearRed -ips @("192.168.1.1", "8.8.8.8","10.10.10.1", "192.168.241.10") | Where-Object {-not $_.Responde}

<#
IP             Responde Timestamp
--             -------- ---------
192.168.1.1        True 08/06/2026 09:45:05 a. m.
8.8.8.8            True 08/06/2026 09:45:05 a. m.
10.10.10.1         True 08/06/2026 09:45:05 a. m.
192.168.241.10    False 08/06/2026 09:45:09 a. m.



IP             Responde Timestamp
--             -------- ---------
192.168.241.10    False 08/06/2026 09:45:13 a. m.
#>

Write-Host "======================================================="

<#
Ejercicio 3 — Script de Diagnóstico Personal:
Crea un archivo DiagnosticoSantiago.ps1 que contenga al menos 
3 funciones propias y las ejecute al correr el script. 
Guárdalo en tu carpeta PowerShellScripts.
#>

function ping {
    param (
        [Parameter(Mandatory, HelpMessage="Escribe las IPs a probar")]
        [string[]]$ips
    )
    foreach ($ip in $ips) {
        $OK = Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue

        [PSCustomObject]@{
            IP = $ip
            Responde = [bool]$OK
        }
    }
}


function VerificadorServicios {
    param (
        [Parameter(Mandatory, HelpMessage="Escribe los Servicios a probar")]
        [string[]]$servicios
    )
    foreach ($servicio in $servicios) {
        $estado = (Get-Service -Name $servicios).Status

        [PSCustomObject]@{
            Servicio = $servicio
            Responde = if ($estado) {$estado} else {"No encontrado"}
        }
    }
}


function InfoDiscoC {
    $discoinfo = Get-PSDrive -Name C
    $libre = [Math]::Round($discoinfo.Free / 1GB, 2)

    if ($libre -lt 10) {
        Write-Host "Alerta: Poco espacio en Disco ($libre GB libres)" -ForegroundColor Red
    } elseif ($libre -lt 30) {
        Write-Host "Aviso: Espacio Moderado en Disco ($libre GB libres)" -ForegroundColor Yellow
    }else {
        Write-Host "Espacio OK en Disco ($libre GB libres)" -ForegroundColor Green
    }
}

Write-Host "==== DIAGNOSTICO DE RED ====" -ForegroundColor Cyan
ping -ips @("192.168.1.4", "192.168.1.1", "10.10.10.1", "172.31.112.1") | Format-Table -AutoSize
Write-Host "==== ESTADO DE SERVICIOS ====" -ForegroundColor Cyan
VerificadorServicios -servicios @("Apache2.4", "Appinfo", "AppXSvc", "AudioEndpointBuilder") | Format-Table -AutoSize
Write-Host "==== INFO DISCO C ====" -ForegroundColor Cyan
InfoDiscoC

<#
==== DIAGNOSTICO DE RED ====
IP             Responde Timestamp
--             -------- ---------
192.168.241.10    False 08/06/2026 10:50:33 a. m.


IP           Responde
--           --------
192.168.1.4      True
192.168.1.1      True
10.10.10.1       True
172.31.112.1     True


==== ESTADO DE SERVICIOS ====

Servicio             Responde
--------             --------
Apache2.4            {Running, Running, Stopped, Running}
Appinfo              {Running, Running, Stopped, Running}
AppXSvc              {Running, Running, Stopped, Running}
AudioEndpointBuilder {Running, Running, Stopped, Running}


==== INFO DISCO C ====
Espacio OK en Disco (64.12 GB libres)
#>