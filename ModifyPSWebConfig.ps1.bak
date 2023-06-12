###################################################
#Script Name            :ModifyPSWebConfig.ps1
#Description            :This Script controls the threshold of the limitation by editing the web.config file to the, from Professional Service SVA, recommended size of 3000.
#						 for further details check 	https://forums.ivanti.com/s/article/Personalization-sync-failures-with-MS-Security-Update-KB2656356-MS11-100					
#Author                 :Sebastian Flint
#E-Mail                 :sebastian.flint@sva.de
###################################################

# Specify the path to the XML file
$xmlFilePath = "C:\Program Files\AppSense\Environment Manager\Personalization Server\PS\web.config"

# Get the current date in the desired format (YYYY-MM-DD)
$date = Get-Date -Format "yyyy-MM-dd-hh-mm-ss"

# Create the backup file path
$backupFilePath = [System.IO.Path]::Combine((Split-Path -Path $xmlFilePath), ([System.IO.Path]::GetFileNameWithoutExtension($xmlFilePath) + "_backup_" + $date + [System.IO.Path]::GetExtension($xmlFilePath)))

# Copy the original file to the backup file path
Copy-Item -Path $xmlFilePath -Destination $backupFilePath -Force

# Load the XML file
$xml = [xml](Get-Content -Path $xmlFilePath)

# Check if the line already exists
$existingLine = $xml.SelectSingleNode("//appSettings/add[@key='aspnet:MaxHttpCollectionKeys']")
if ($existingLine -ne $null) {
    # Line already exists, update the value attribute
    $existingLine.SetAttribute("value", "3000")
}
else {
    # Create a new XML element
    $newElement = $xml.CreateElement("add")
    $newElement.SetAttribute("key", "aspnet:MaxHttpCollectionKeys")
    $newElement.SetAttribute("value", "3000")

    # Find the <appSettings> section
    $appSettings = $xml.SelectSingleNode("//appSettings")

    # Append the new element to the <appSettings> section
    $appSettings.AppendChild($newElement)
}

# Save the modified XML back to the file
$xml.Save($xmlFilePath)

Write-Host -ForegroundColor Green "The line has been inserted or modified in the XML file."
Write-Host -ForegroundColor Green "A backup file has been created at: $backupFilePath"
Write-Host ""
Write-Host "!!!Please restart the server to activate the configuration.!!!"
