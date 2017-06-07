Function Get-RedirectedUrl
{
    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )
 
    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()
 
    If ($response.StatusCode -eq "Found")
    {
       $response.GetResponseHeader("Location")
    }
}

$url = 'https://createanaccount1298-my.sharepoint.com/personal/trip_createanaccount1298_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=1f9db9d4d11744c20aa2326709c0eea12&authkey=ASeRRa_r-8oySMZL2HSZheI'
$codeSetupUrl = Get-RedirectedUrl -URL $url

$uploadfilecodeSetup = "${env:Temp}\AZURE ACTIVE DIRECTORY B2B COLLABORATION.docx"

try
{
    (New-Object System.Net.WebClient).DownloadFile($codeSetupUrl, $uploadfilecodeSetup)
}
catch
{
    Write-Error "Failed to download a file"
}