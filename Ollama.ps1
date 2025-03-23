$port = 11434
$ollamaServer = "http://localhost:$port"

function Send-OllamaMessage {
    param (
        [string]$userMessage,
        [string]$modelName = "llama3.2" # Change this to the model you want to use
    )

    $apiEndpoint = "$ollamaServer/api/generate"
    $promptText = "You are an assistent for User message: $userMessage" # Put your prompt here
    
    $requestBody = @{
        model = $modelName
        prompt = $promptText
        stream = $false
    } | ConvertTo-Json -Depth 10 -Compress
    
    try {
        $response = Invoke-RestMethod -Uri $apiEndpoint -Method Post -Body $requestBody -ContentType "application/json; charset=utf-8"
        return $response.response
    }
    catch {
        $errorDetails = $_.ErrorDetails.Message
        Write-Host "Error communicating with Ollama: $($_.Exception.Message)" -ForegroundColor Red
        if ($errorDetails) {
            Write-Host "Server response: $errorDetails" -ForegroundColor Red
        }
        return "Error: Could not get a response from Ollama."
    }
}

function Initialize-Ollama {
    try {
        $healthEndpoint = "$ollamaServer/api/tags"
        Invoke-RestMethod -Uri $healthEndpoint -Method Get -TimeoutSec 5
        Write-Host "Successfully connected to Ollama server. http://localhost:$port" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "Cannot connect to Ollama server at $ollamaServer" -ForegroundColor Red
        Write-Host "Make sure Ollama is running and accessible." -ForegroundColor Red
        return $false
    }
}

function Write-UserInput {
    param (
        [string]$userInput,
        [string]$modelResponse
    )

    try {
        Write-Host "You: $userInput" -ForegroundColor Cyan
        Send-OllamaMessage -userMessage $userInput
        Write-Host "Ollama: $modelResponse" -ForegroundColor Green
    }
    catch {
        Write-Host "Error writing user input." -ForegroundColor Red
    }
}

if (Initialize-Ollama) {
    Write-Host "Welcome to the Ollama Assistant!" -ForegroundColor Green
    Write-Host "Type 'exit' to leave the chat." -ForegroundColor Cyan
    
    while ($true) {
        $userInput = Read-Host "You"
        if ($userInput -eq "exit") {
            Write-Host "Goodbye!" -ForegroundColor Cyan
            break
        } elseif ($userInput -eq "") {
            continue
        } else {
            $modelResponse = Send-OllamaMessage -userMessage $userInput
            Write-UserInput -userInput $userInput -modelResponse $modelResponse
        }
    }
} else {
    Write-Host "Exiting due to connection error." -ForegroundColor Red
}
