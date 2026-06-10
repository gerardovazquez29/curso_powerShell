
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
        [validaset("info","Warning","Error")]
        [string]$tipo = "info"
    )
    $ruta = "C:\Users\T-City\OneDrive\Documentos\PowerShellScripts\Auditoria.log"
    $fecha = Get-Date -Format "dd/mm/yyyy HH:mm:ss"
    Add-Content -Path $ruta -Value "[$fecha] [$tipo] $mensaje"
    Write-Host "[$tipo] $mensaje" -ForegroundColor 
}



Write-Host "================================================================"

<#
Ejercicio 3 — Diagnóstico con Registro Completo:
Toma la función VerificadorServicios del Módulo 5 y modifícala para que:

Intente obtener el servicio con Try.
Si el servicio no existe (Catch), use su función Registrar-Actividad para guardar el error en el log.
Si el servicio existe, guarde un log de tipo Info.
#>