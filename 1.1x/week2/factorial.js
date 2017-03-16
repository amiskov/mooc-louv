/**
 Факториал через рекурсию:
 0! = 1
 n! = n * (n - 1)! when n > 0
*/
function fac1(n) {
    if (n == 0) {
        return 1;
    } else {
        return n * fac1(n - 1);
    }
}
console.log(fac1(5));

/**
Факториал через принцип сообщающихся сосудов:

n! = n! * 1
n! = n * (n - 1)! * 1
n! = (n - 1)! * n * 1
n! = (n - 2)! * n * (n - 1) * 1

n! = i! * a
   = i * (i - 1)! * a
   = (i - 1)! * (i * a)
   
Итого: i' = i - 1 and a' = i * a (i' и a' пойдут в рекурсивный вызов)
*/
function fact2(i, a) {
    if (i == 0) {
        return a;
    } else {
        return fact2(i - 1, a * i);
    }
}

console.log(fact2(5, 1));
