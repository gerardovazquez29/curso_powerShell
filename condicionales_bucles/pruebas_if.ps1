
$archivo = "C:\Users\T-City\OneDrive\Documentos\curso_powerShell\archivo.txt"

if (Test-Path $archivo){
    Write-Host "El archivo si existe"
}
else {
    "El archivo No existe"
}
