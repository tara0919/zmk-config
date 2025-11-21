param(
    [string]$PortName = 'COM1',
    [int]$Baud = 115200,
    [string]$OutFile = 'zmk-log.txt'
)

Write-Host "Starting ZMK serial logger on $PortName @ $Baud, output -> $OutFile"

$port = New-Object System.IO.Ports.SerialPort $PortName, $Baud, 'None', 8, 'One'
$port.NewLine = "`n"
$port.ReadTimeout = 5000

try {
    $port.Open()
} catch {
    Write-Error ("Failed to open {0}: {1}" -f $PortName, $_)
    exit 1
}

Write-Host ("Opened {0} @ {1}. Logging to {2}. Press Ctrl+C to stop.`n" -f $PortName, $Baud, $OutFile)

try {
    while ($true) {
        try {
            $line = $port.ReadLine()
        } catch [System.TimeoutException] {
            continue
        } catch {
            Write-Warning ("Read error: {0}" -f $_)
            break
        }

        $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
        $entry = "$ts $line"
        $entry | Tee-Object -FilePath $OutFile -Append
        Write-Host $entry
    }
} finally {
    if ($port.IsOpen) {
        $port.Close()
        Write-Host "`nPort $PortName closed."
    }
}
