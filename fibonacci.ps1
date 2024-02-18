param([int]$n)

function Fibonacci($n) {
    if ($n -le 0) {
        return 0
    } elseif ($n -eq 1) {
        return 1
    } else {
        return (Fibonacci($n - 1) + Fibonacci($n - 2))
    }
}

if ($n) {
    Write-Output (Fibonacci $n)
} else {
    # If no number is passed, output all Fibonacci numbers one by one every 0.5 second
    $i= 0
    while ($true) {
        Write-Output (Fibonacci $i)
        $i++
        Start-Sleep -Milliseconds 500
    }
}
