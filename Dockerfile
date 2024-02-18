# Dockerfile

FROM mcr.microsoft.com/powershell:latest

WORKDIR /app

COPY . .

CMD ["pwsh", "./fibonacci.ps1"]
