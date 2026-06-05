function Saludar {
    param ($nombre)
    Write-Host "Hola, $nombre. Bienvenido al Sistema. " -ForegroundColor Cyan
}

# LLamar la funcion
Saludar -nombre "Santiago"

# Hola, Santiago. Bienvenido al Sistema.

Write-Host "============================="

# funcion con Return
function ObtenerEspacioLibre {
    param ($unidad)
    $libre = [math]::Round((Get-PSDrive -Name $unidad).Free / 1GB, 2)
    return $libre
}
# llamar y guardar resultado
$espacioC = ObtenerEspacioLibre -unidad "C"
Write-Host "Espacio libre em C: $espacioC GB"

# Espacio libre em C: 56.81 GB

Write-Host "============================="
function VerificarServicio {
    param (
        [string]$nombre,
        [string]$equipo = "localhost"
     )
    $estado = (Get-Service -Name $nombre -ComputerName $equipo).Status
    Write-Host "[$equipo] Servicio $nombre ==> $estado"
}

VerificarServicio -nombre "WinRM"
VerificarServicio -nombre "Spooler" -equipo "localhost"

#[localhost] Servicio WinRM ==> Stopped
#[localhost] Servicio Spooler ==> Running

Write-Host "============================="