# PS1OllamaConnection

A PowerShell script to connect with and utilize Ollama AI models directly from your terminal using PowerShell.

## Overview

This project allows you to interact with Ollama's AI models through a simple PowerShell interface. It demonstrates how to establish connections with Ollama's API and exchange messages with AI models.

## Features

- Connect to locally running Ollama instances
- Send prompts to any installed Ollama model
- Simple chat interface for AI interactions
- Error handling for connection issues

## Prerequisites

- PowerShell 5.1 or higher
- [Ollama](https://ollama.ai/) installed and running locally
- At least one model pulled in Ollama (default: llama3.2)

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/nour-saif/PS1OllamaConnection.git
   cd PS1OllamaConnection
   ```

2. Make sure Ollama is running on your system

## Usage

1. Start the script:
   ```
   .\Ollama.ps1
   ```

2. The script will check if Ollama is running locally
3. When connected, you can start chatting with the AI model
4. Type 'exit' to end the session

## Configuration

You can modify these parameters in the script:
- Change the default model by editing the `$modelName` parameter in the `Send-OllamaMessage` function
- Customize the system prompt by editing the `$promptText` variable
- Adjust the port if your Ollama instance runs on a different port than the default 11434

## How It Works

The script uses PowerShell's `Invoke-RestMethod` to communicate with Ollama's API endpoints:
- `/api/tags` to check connection status
- `/api/generate` to send prompts and receive responses

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Nour Saif Yassine