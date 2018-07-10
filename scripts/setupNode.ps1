[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

$url1 = "http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi"
$output1 = "D:\rewrite.msi"
Invoke-WebRequest -Uri $url1 -OutFile $output1

$url2 = "https://nodejs.org/dist/v8.11.3/node-v8.11.3-x64.msi"
$output2 = "D:\node.msi"
Invoke-WebRequest -Uri $url2 -OutFile $output2

$url3 = "https://github.com/tjanczuk/iisnode/releases/download/v0.2.21/iisnode-full-v0.2.21-x64.msi"
$output3 = "D:\iisnode.msi"
Invoke-WebRequest -Uri $url3 -OutFile $output3

$urlapplicationHost = "https://github.com/tjanczuk/iisnode/releases/download/v0.2.21/iisnode-full-v0.2.21-x64.msi"
$config = "C:\Windows\system32\inetsrv\config\applicationHost.config"
Invoke-WebRequest -Uri $urlapplicationHost -OutFile $config 

cd C:\Program Files\iisnode\www\logging>

npm init -y 
npm install tedious 
npm install async

$hellojs =  "https://github.com/"
$oldfile = "D:\OldFile.txt"
$newfile = "C:\Program Files\iisnode\www\logging\hello.js"

Invoke-WebRequest -Uri $hellojs  -OutFile $oldfile
 
$text = (Get-Content -Path $oldfile -ReadCount 0)
$text -replace 'CHANGEME.database.windows.net','test.database.windows.net' | Set-Content -Path $newfile -Force



Restart-Computer