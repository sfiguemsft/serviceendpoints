Add-WindowsFeature Web-Server

Get-Job | Wait-Job

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

$url1 = "http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi"
$output1 = "D:\rewrite.msi"
Invoke-WebRequest -Uri $url1 -OutFile $output1
D:\rewrite.msi /quiet

$url2 = "https://nodejs.org/dist/v8.11.3/node-v8.11.3-x64.msi"
$output2 = "D:\node.msi"
Invoke-WebRequest -Uri $url2 -OutFile $output2
D:\node.msi /quiet

$url3 = "https://github.com/tjanczuk/iisnode/releases/download/v0.2.21/iisnode-full-v0.2.21-x64.msi"
$output3 = "D:\iisnode.msi"
Invoke-WebRequest -Uri $url3 -OutFile $output3
D:\iisnode.msi /quiet

$urlapplicationHost = "https://raw.githubusercontent.com/sfiguemsft/serviceendpoints/master/files/applicationHost.config"
$config = "C:\Windows\system32\inetsrv\config\applicationHost.config"
Invoke-WebRequest -Uri $urlapplicationHost -OutFile $config 

Set-Location "C:\Program Files\iisnode\www\logging"

& "C:\Program Files\nodejs\npm.cmd" init -y
& "C:\Program Files\nodejs\npm.cmd" install tedious
& "C:\Program Files\nodejs\npm.cmd" install async
& "C:\Program Files\iisnode\setupsamples.bat" /s

$hellojs =  "https://raw.githubusercontent.com/sfiguemsft/serviceendpoints/master/files/hello.js"
$oldfile = "D:\OldFile.txt"
$newfile = "C:\Program Files\iisnode\www\logging\hello.js"

Invoke-WebRequest -Uri $hellojs  -OutFile $oldfile
 
$text = (Get-Content -Path $oldfile -ReadCount 0)
$text -replace 'CHANGEME.database.windows.net','test.database.windows.net' | Set-Content -Path $newfile -Force

Restart-Computer