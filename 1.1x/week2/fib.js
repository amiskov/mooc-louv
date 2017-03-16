function fib(n) {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        return fib(n - 2) + fib(n - 1);
    }
}

console.time('Recursive');
console.log(fib(32));
console.timeEnd('Recursive');


function fibI(n) {
    function fibIter(n, acc1, sum) {
        if (n == 1) {
            return sum;
        } else {
            return fibIter(n - 1, sum, sum + acc1);
        }
    }

    return fibIter(n, 0, 1);
}

console.time('Tail Recursive');
console.log(fibI(32));
console.timeEnd('Tail Recursive');
