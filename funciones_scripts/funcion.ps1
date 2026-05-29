
function saludar {
    Write-Host "Hola desde powerShell"
}
saludar

function Show-Persona {
    param (
        [string] $nombre
    )
    Write-Host "Hola te saludo $nombre"
}

Show-Persona -nombre "Santiago"
