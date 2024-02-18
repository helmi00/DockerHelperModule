function Build-DockerImage {
    param(
        [Parameter(Mandatory=$true)] [string]$Dockerfile,
        [Parameter(Mandatory=$true)] [string]$Tag,
        [Parameter(Mandatory=$true)] [string]$Context,
        [string]$ComputerName
    )

    if ($ComputerName) {
        # Execute on remote computer
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            docker build -t $using:Tag -f $using:Dockerfile $using:Context
        }
    } else {
        # Execute locally
        docker build -t $Tag -f $Dockerfile $Context
    }
}

function Copy-Prerequisites {
    param(
        [Parameter(Mandatory=$true)] [string]$ComputerName,
        [Parameter(Mandatory=$true)] [string[]]$Path,
        [Parameter(Mandatory=$true)] [string]$Destination
    )

    foreach ($item in $Path) {
        if (Test-Path -Path $item) {
            $destinationPath= "\\$ComputerName\$($Destination.Replace(':', '$'))"
            Copy-Item -Path $item -Destination $destinationPath -Recurse -Force
        } else {
            Write-Error "Path $item does not exist."
        }
    }
}

function Run-DockerContainer {
    param(
        [Parameter(Mandatory=$true)] [string]$ImageName,
        [string]$ComputerName,
        [string[]]$DockerParams
    )

    $params = if ($DockerParams) { $DockerParams -join ' ' } else { '' }

    if ($ComputerName) {
        # Execute on remote computer
        $containerName= Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            $output= docker run -d $using:params $using:ImageName
            return $output
        }
    } else {
        # Execute locally
        $containerName= docker run -d $params $ImageName
    }

    return $containerName
}

Export-ModuleMember -Function Build-DockerImage, Copy-Prerequisites, Run-DockerContainer
