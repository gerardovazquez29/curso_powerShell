function SaludarUsuario {
    param (
        [string]$nombre,
        [string]$rol
    )
    $mensaje = "Bienvenido $nombre, tu rol es: $rol"
    Write-Host $mensaje
}
SaludarUsuario -nombre "Santiago" -rol "Administrador de Sistemas"

# Bienvenido Santiago, tu rol es: Administrador de Sistemas

Write-Host "====================================================="

# Función con fecha y formato de texto

function mostraFecha {
    param (
        [string]$evento
    )
    $fecha = Get-Date -Format "dd/MM/yyyy"
    $linea = "[$fecha] $evento"

    Write-Host $linea
}
mostraFecha -evento "El Servidor iniocio correctamente"
# [10/06/2026] El Servidor iniocio correctamente

Write-Host "====================================================="

# Función con validación de tipo (parecido al ejercicio)

function RegistrarEvento {
    param (
        [string]$descripcion,
        [string]$nivel   #"info", "Warning", "Error"
    )
    $fecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $nivel = $nivel.ToUpper() # convierte a mayusculas por seguridad
    $linea = "[$fecha] [$nivel] $descripcion"
    $ruta = "C:\Users\T-City\OneDrive\Documentos\PowerShellScripts\eventos.log"

    Write-Host $linea
    Add-Content -Path $ruta -Value $linea
}
# LLamadas de pruebas
RegistrarEvento -descripcion "Backup completo" -nivel "info"
RegistrarEvento -descripcion "Disco al 85% de capacidad" -nivel "Warning"
RegistrarEvento -descripcion "No se puede conectar a BD" -nivel "Error"

<#
[10/06/2026 09:01:24] [INFO] Backup completo
[10/06/2026 09:01:24] [WARNING] Disco al 85% de capacidad
[10/06/2026 09:01:24] [ERROR] No se puede conectar a BD
#>