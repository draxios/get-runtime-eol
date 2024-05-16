# Define the URL for the NodeJS EOL dates page
$url = "https://endoflife.date/api/nodejs.json"

# Fetch the HTML content from the URL
$response = Invoke-WebRequest -Uri $url

# Parse the JSON content
$data = $response.Content | ConvertFrom-Json

# Initialize an array to hold the parsed data
$eolData = @()

# Loop through each entry in the data and extract version and EOL date
foreach ($entry in $data) {
    $version = $entry.cycle
    $eol = $entry.eol

    # Create a custom object to hold the parsed data
    $eolData += [PSCustomObject]@{
        "version" = $version
        "eol_date" = $eol
    }
}

# Convert the array to JSON format
$json = $eolData | ConvertTo-Json -Depth 4

# Define the output file path
$outputDirectory = "C:\path\to\your\directory"
$outputFile = "$outputDirectory\nodejs.json"

# Check if the directory exists, if not, create it
if (-not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory
}

# Save the JSON data to a file
$json | Out-File -FilePath $outputFile

Write-Output "NodeJS EOL dates have been saved to $outputFile"
