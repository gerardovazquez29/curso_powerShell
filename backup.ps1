
$originales = "C:\Users\T-City\OneDrive\Documentos\curso_powerShell\backups\originales"
$respaldos = "C:\Users\T-City\OneDrive\Documentos\curso_powerShell\backups\respaldos"

Copy-Item $originales\* $respaldos -Force
