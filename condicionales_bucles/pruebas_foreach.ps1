
$archivos = Get-ChildItem "C:\Users\T-City\OneDrive\Documentos\curso_powerShell\backups\originales"

foreach ($archivo in $archivos) {
    Write-Host "Archivo encontrado $($archivo.Name)"
}