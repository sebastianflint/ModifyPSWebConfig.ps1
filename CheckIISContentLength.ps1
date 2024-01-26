# Define the URL of your server
$serverUrl = "http://localhost:7771/personalizationserver/deployment/status.aspx"

# Define the maximum content length
$maxContentLength = 100000001    # Adjust this value based on your server configuration

# Create a string with payload data 
$payload = "A" * $maxContentLength

# Send a POST request to the server with the payload and Windows Authentication
$response = Invoke-WebRequest -Uri $serverUrl -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials

# Display the response status code
$response.StatusCode
