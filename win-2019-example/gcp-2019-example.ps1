# Define the download URL for BGInfo
$bginfoUrl = "https://download.sysinternals.com/files/BGInfo.zip"

# Define the temporary folder to download and extract BGInfo
$tempFolder = "$env:TEMP\BGInfo"

# Create the temporary folder if it doesn't exist
if (-not (Test-Path $tempFolder)) {
    New-Item -ItemType Directory -Force -Path $tempFolder | Out-Null
}

# Download BGInfo.zip to the temporary folder
Invoke-WebRequest -Uri $bginfoUrl -OutFile "$tempFolder\BGInfo.zip"

# Extract BGInfo.zip to the temporary folder
Expand-Archive -Path "$tempFolder\BGInfo.zip" -DestinationPath $tempFolder

# Install BGInfo
$bginfoExe = Get-ChildItem "$tempFolder\BGInfo\*.exe" | Select -First 1
Start-Process -FilePath $bginfoExe.FullName -ArgumentList "/silent"

# Clean up the temporary files
Remove-Item "$tempFolder\BGInfo.zip" -Force
Remove-Item "$tempFolder\BGInfo" -Recurse -Force
