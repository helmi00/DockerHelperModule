const args= process.argv.slice(2);

function fibonacci(n: number): number {
    if (n <= 0) {
        return 0;
    } else if (n === 1) {
        return 1;
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}

if (args.length > 0) {
    let n= parseInt(args[0]);
    console.log(fibonacci(n));
} else {
    // If no number is passed, output all Fibonacci numbers one by one every 0.5 second
    let n= 0;
    setInterval(() => {
        console.log(fibonacci(n));
        n++;
    }, 500);
}
