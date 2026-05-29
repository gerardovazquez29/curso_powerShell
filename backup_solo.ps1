
$originales = "C:\Users\T-City\OneDrive\Documentos\curso_powerShell\backups\originales"
$respaldos = "C:\Users\T-City\OneDrive\Documentos\curso_powerShell\backups\respaldos"

$archivos = Get-ChildItem $originales

foreach ($archivo in $archivos) {
    if ($archivo.Extension -eq ".docx") {
        Copy-Item $archivo.FullName $respaldos -Force
    }
}
