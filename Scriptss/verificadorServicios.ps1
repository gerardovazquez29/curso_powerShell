
function RegistrarActividad {
    param (
        [string]$mensaje,
        [validateSet("info","Warning","Error")]
        [string]$tipo = 'info'
    )
    $ruta = "C:\Users\T-City\OneDrive\Documentos\PowerShellScripts\auditoria.log"
    $fecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    Add-Content -Path $ruta -Value "[$fecha] [$tipo] $mensaje"
    Write-Host "[$tipo] $mensaje" -ForegroundColor $(if ($tipo -eq "Error") {"Red"} elseif ($tipo -eq "Warning") {"Yellow"} else {"Cyan"})
}

function VerificadorServicios {
    param ([string[]]$servicios)
    
    foreach ($servicio in $servicios) {
        try {
            #si el servicio no existe, esto lanza un error
            $estado = (Get-Service -Name $servicio -ErrorAction Stop).Status
            RegistrarActividad -mensaje "Servicio '$servicio' encontrado --> $estado" -tipo "info"
        }
        catch {
            #si falla, reguistramos el error en el log
            RegistrarActividad -mensaje "Servicio '$servicio' No encontrado: $($_.Exception.Message)" -tipo "Error"
        }
    }
}
# Probamos con servicios reales y uno fallo
VerificadorServicios -servicios @("WinDefend", "Spooler", "ServicioFalso", "WinRM")

<#
[info] Servicio 'WinDefend' encontrado --> Running
[info] Servicio 'Spooler' encontrado --> Running
[Error] Servicio 'ServicioFalso' No encontrado: No se encuentra ningún servicio con el nombre 'ServicioFalso'.
[info] Servicio 'WinRM' encontrado --> Stopped
#>
