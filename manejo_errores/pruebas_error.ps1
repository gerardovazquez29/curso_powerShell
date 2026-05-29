
try {
    Get-Content "archivo_inexistente.txt" -ErrorAction Stop
}
catch {
    <#Do this if a terminating exception happens#>
    Write-Host "Error al leer el archivo"
}
finally {
    Write-Host "Proceso finalizado"
}