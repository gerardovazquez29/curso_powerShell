# Ejercicio1
# Usa if/else para revisar el espacio libre de tu disco C: y mostrar un mensaje
# según el espacio disponible. Usa el código del Paso 1 como base

<#$disco = (Get-PSDrive C).Free / 1GB

if ($disco -lt 10) {
    Write-Host " ALERTA: Poco espacio en disco ($([math]::Round($disco,2)) GB libres)" -ForegroundColor Red
} elseif ($disco -lt 30) {
    Write-Host " AVISO: Espacio moderado ($([math]::Round($disco,2)) GB libres)" -ForegroundColor Yellow
} else {
    Write-Host " Espacio OK ($([math]::Round($disco,2)) GB libres)" -ForegroundColor Green
}#>


$discoinfo = Get-PSDrive -Name C
$libre = [Math]::Round($discoinfo.Free / 1GB,2)

if ($libre -lt 10) {
    Write-Host "Alerta: Poco espacio en Disco ($libre GB libres)" -ForegroundColor Red
}elseif ($libre -lt 30) {
    Write-Host "Aviso: Espacio moderado en Disco ($libre GB libres)" -ForegroundColor Yellow
}else {
    Write-Host "Espacio OK en Disco ($libre GB libres)" -ForegroundColor Green
}


# Espacio OK en Disco (56.03 GB libres)

Write-Host "======================================"
<#
Ejercicio 2 — El Verificador de Servicios:
Crea un array con 4 servicios de tu equipo y usa foreach para mostrar el nombre
y estado de cada uno. 
Usa servicios que ya conozcas de ejercicios anteriores.
#>

$verificadores = @("Apache2.4", "Appinfo", "AppXSvc", "AudioEndpointBuilder")

foreach ($verificador in $verificadores) {
    $estado = (Get-Service -Name $verificador).Status
    Write-Host "Servicio: $verificador ==> Estado: $estado"
}
<#
Servicio: Apache2.4 ==> Estado: Running
Servicio: Appinfo ==> Estado: Running
Servicio: AppXSvc ==> Estado: Running
Servicio: AudioEndpointBuilder ==> Estado: Running
#>

Write-Host "======================================"

<#
Ejercicio 3 — El Contador de Archivos:
Usa un bucle foreach para recorrer los archivos de 
C:\Users\T-City\OneDrive\Documentos\CursoPowerShell y 
mostrar el nombre de cada archivo encontrado.
#>

$archivos = Get-ChildItem -Path "C:\Users\T-City\OneDrive\Documentos\PowerShellScripts" -Recurse

foreach ($archivo in $archivos) {
    Write-Host $archivo.Name
}

<#
backups
condicionales_bucles
ejercicios
funciones_scripts
manejo_errores
Scriptss
seguridad_ejecucion
archivo.txt
backup.ps1
backup_solo.ps1
log.txt
originales
respaldos
doc.docx
hola.txt
index.html
doc.docx
hola.txt
index.html
pruebas_for.ps1
pruebas_for1.ps1
pruebas_foreach.ps1
pruebas_foreach1.ps1
pruebas_if.ps1
pruebas_switch.ps1
pruebas_while.ps1
pruebas_while1.ps1
Ejercicio1.ps1
funcion.ps1
error.ps1
logs.ps1
pruebas_error.ps1
monitor_recursos.ps1
seguridad.ps1
#>
