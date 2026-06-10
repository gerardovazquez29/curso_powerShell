
<#
Ejercicio 1 — El Instalador Seguro:
Crea un script que intente crear una carpeta en una ruta protegida (ejemplo: C:\Windows\Santiago).
Usa Try/Catch.
Si falla, debe mostrar un mensaje: "Acceso denegado, asegúrate de correr como Administrador".
#>

function crearCarpeta {
    try {
        New-Item -Path "C:\windows\Santiago\try" -ItemType Directory -Force -ErrorAction Stop
        Write-Host "Carpeta creada exitosamente" -ForegroundColor Green
    }
    catch {
        Write-Host "Acceso Denegado. Asegurate de correr como Administrador" -ForegroundColor Red
        Write-Host "Detalle: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}
crearCarpeta

<#
Acceso Denegado. Asegurate de correr como Administrador
Detalle: Acceso denegado a la ruta de acceso 'Santiago'.
#>

Write-Host "================================================================"

<#
Ejercicio 2 — Función de Audit Log:
Crea una función llamada Registrar-Actividad.

Debe recibir un $mensaje y un $tipo (Info, Warning, Error).
Debe guardar en un archivo auditoria.log algo como: [08/06/2026] [ERROR] El servicio X falló.
#>

function RegistrarActividad {
    param (
        [string]$mensaje,
        [string]$tipo    # "info","Warning","Error" 
    )
    $fecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $tipo = $tipo.ToUpper()
    $linea = "[$fecha] [$tipo] $mensaje"
    $ruta = "C:\Users\T-City\OneDrive\Documentos\PowerShellScripts\Auditoria.log"
    Add-Content -Path $ruta -Value $linea
    Write-Host $linea 
}
RegistrarActividad -mensaje "El Servicio DNS inicio correctamente" -tipo "info"
RegistrarActividad -mensaje "El disco C: esta al 90% de uso"       -tipo "Warning"
RegistrarActividad -mensaje "El servicio DHCP fallo"               -tipo "Error"

<#
[10/06/2026 16:45:01] [INFO] El Servicio DNS inicio correctamente
[10/06/2026 16:45:01] [WARNING] El disco C: esta al 90% de uso
[10/06/2026 16:45:01] [ERROR] El servicio DHCP fallo
#>

Write-Host "================================================================"

<#
Ejercicio 3 — Diagnóstico con Registro Completo:
Toma la función VerificadorServicios del Módulo 5 y modifícala para que:

Intente obtener el servicio con Try.
Si el servicio no existe (Catch), use su función Registrar-Actividad para guardar el error en el log.
Si el servicio existe, guarde un log de tipo Info.
#>

function VerificadorServicios {
    param (
        [Parameter(Mandatory, HelpMessage = "Escribe los Servicios a probar")]  
        [string[]]$servicios    
        )

        foreach ($servicio in $servicios) {
            try {
                $estado = (Get-Service -Name $servicio -ErrorAction Stop).Status
                RegistrarActividad -mensaje "El servicio $servicio fue consultado correctamente. Estado: $estado" -tipo "info"
                $respuesta = if ($estado) {$estado} else {"No encontrado"} 
                [PSCustomObject]@{
                    servicio = $servicio
                    responde = $respuesta  
                }    
            }
            catch {
                RegistrarActividad -mensaje "Error al consultar el servicio $servicio.No fue encontrado o no pudo obtenerse. Detalle: $_" -tipo "Error"

                [PSCustomObject]@{
                    servicio = $servicio
                    responde = "No encontrado"  #if ($estado) {$estado} else {"No encontrado"}   
                }
            }
            
        }
}
VerificadorServicios -servicios @("Apache2.4", "Appinfo", "AppXSvc", "AudioEndpointBuilder", "servicioFallo") | Format-Table -AutoSize

