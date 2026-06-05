$servicios = @("winRM", "Spooler", "WinDefend")

foreach ($servicio in $servicios) {
    $estado = (Get-Service -Name $servicio).Status
    Write-Host "Servicio: $servicio --> Estado: $estado"
}

# Servicio: winRM --> Estado: Stopped
# Servicio: Spooler --> Estado: Running
# Servicio: WinDefend --> Estado: Running
