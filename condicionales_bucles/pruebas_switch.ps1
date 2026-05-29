
$extencion = ".txt"

switch ($extencion) {
    ".txt" { 
        Write-Host "Este es un archivo de texto"  
    }
    ".html" { 
        Write-Host "Este es un archivo web"  
    }
    ".exe" { 
        Write-Host "Este es un archivo ejecutable"  
    }
    Default {
        Write-Host "Extencion desconocida"
    }
}

