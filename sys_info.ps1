Clear-Host
#Determinamos las funciones de los menus
Function app{
Function menu1 {
Write-Host "------------------"
"1.-Conexiones"
"2.-Hardware"
"3.-Procesos"
"4.-Reiniciar PC"
"-----------------"
}
menu1
Function menuc{
Write-Host "-----------------------"
"1.Test de conexion"
"2.Detalles TCP/IP"
"3.Adaptadores y drivers"
"4.Adaptadores avanzados"
"5.Puertos TCP abiertos"
"6.Informacion transmitida"
"7.Estadistica conexiones actuales TCP"
"----------------------------" 
}

Function menuh {
Write-Host "------------------"
"1.-Info hardware"
"2.-Info,numero e nucleos y carga procesador"
"3.Info de memoria"
"4.Lugar fisico donde se encuentra la memoria"
"5.Tension maxima y minima que soportan las memorias"
"6.Informacion sobre discos duros"
"7.Info de buses y puertos"
"------------------"
}

Function menup {
Write-Host "---------------------------" 
"1.Info procesos"
"2.Procesos que se estan ejecutando desde el inicio"
"3.Listado de procesos con alto consumo del CPU"
"4.Listado de procesos que se estan ejecutando"
"-----------------------------"
}
#Ahora vamos a empezar con las opciones 

$op1 =  Read-Host "Seleccione una opcion"
Clear-Host

#Gracias a los if (tambien se puede con un switch) vamos a especificar nuestro ultimo menu
if ($op1 -eq 1){
    menuc
    $opc= Read-Host "Seleccione su opcion"
}
elseif ($op1 -eq 2){
   menuh
    $oph = Read-Host "Selecciona una opcion" 
}
elseif ($op1 -eq 3){
    menup
    $opp = Read-Host "Selecciona una opcion"    
}
elseif ($op1 -eq 4){
    Restart-Computer
}
else {
    Write-Host "ERROR"
}

#ahora vamos a especificar con switches que queremos hacer 
switch($opc){
1.{Test-NetConnection
    break;}
2.{ipconfig /all
    break;}
3.{Get-NetAdapterHardwareInfo
    break;}
4.{Get-NetAdapterAdvancedProperty 
Get-NetAdapter | Format-Table Name, DriverName, DriverVersion, DriverInformation, DriverFileName
    break;}
5.{Get-NetTCPConnection
    break;}
6.{Get-NetAdapterStatistics
    break;}
7.{netstat -n
    break;}
}

switch ($oph){
1.{(Get-WmiObject Win32_ComputerSystem).SystemType
    break;}
2.{Get-WmiObject -Class Win32_Processor | Select-Object -Property Name, Number*
    break;}
3.{Get-WmiObject Win32_PhysicalMemory |Select-Object -Property Name|ForEach-Object {$_.capacity / 1GB}
    break;}
4.{Get-WmiObject Win32_PhysicalMemory | Select-Object BankLabel
    break;}
5.{Get-WmiObject Win32_PhysicalMemory | Select-Object MaxVoltage,MinVoltage
    break;}
6.{Get-disk
    break;}
7.{Get-WmiObject Win32_InfraredDevice
    Get-WmiObject Win32_ParallelPort
    Get-WmiObject Win32_PCMCIAController
    Get-WmiObject Win32_SerialPort
    Get-WmiObject Win32_SerialPortConfiguration
    Get-WmiObject Win32_SerialPortSetting
        break;}
}

switch ($opp){
1.{Get-Process | Select-Object Name, Id, Company | Sort-Object Name
    break;}
3.{Get-Process | Select-Object cpu,id,name | Sort-Object cpu -Descending
    break;}
4.{Get-Process | Select-Object Name
    break;}
}
}
app
pause
Clear-Host
do {
    app
    pause
    Clear-Host
}
While ($op1 -eq $op1)