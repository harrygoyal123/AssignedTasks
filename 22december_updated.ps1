  #Setup TCP Port
  $servername = Read-Host "Enter Server name"                         # Enter Server Name
  $servername.Replace("`"","")                                        
  $testpath = Test-Path "\\$servername\c$"                            # Check Server exists or not

  if($testpath -eq "True")                            
  {  
        Invoke-Command -ComputerName $servername -ScriptBlock{    
        try
        {
            $string_port = Read-Host "Enter Port number"              # Input of Port Number
            $port_number = [int]$string_port                          # string to int conversion of port no.          
            $Listen = [System.Net.Sockets.TcpListener]$port_number
            $Listen.Start();                                          # To open or setup port
            Write-Host (netstat -na | Select-String :$port_number )   # Check existence of port
            Write-Host "`nCheck By using Test-Netconnection"
            Test-NetConnection 127.0.0.1 -Port $port_number           # Cross-check the existence of port
        }
        catch
        {   Write-Host "$port_number already exists"                  # if port is already opened
            Write-Host $_.Exception.Message -ForegroundColor yellow   # print exception message
        }                                                    }
  }
  else
  {    
     Write-Host "$servername Server Not Found" -ForegroundColor Red   # if server is not present
  }