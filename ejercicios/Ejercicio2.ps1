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


<#
Ejercicio 3 — Script de Diagnóstico Personal:
Crea un archivo DiagnosticoSantiago.ps1 que contenga al menos 
3 funciones propias y las ejecute al correr el script. 
Guárdalo en tu carpeta PowerShellScripts.
#>

