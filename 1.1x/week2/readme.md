# Recursion, loops, and invariant programming
Циклы можно реализовать с помощью хвостовой рекурсии (tail recursion), когда рекурсивный вызов происходит в конце тела функции.

Цикл — форма рекурсии (tail recursion, хвостовая рекурсия), в которой повторный вызов функции происходит в конце ее тела.

## Invariant
Неизменяемый код эффективен при создании циклов.

Invariant formula — всегда `true` во время исполнения. True loop — рекурсивная формула, которая всегда выполняется.

## Затраты рекурсии
**Sum**

Functions have a certain type of memory. They can know something from a previous call, thanks to a variable passed as an argument. This is particularly useful when you need a result that is not only a result of the last function call, but an accumulated result of function calls.

Consider this situation: there is queue of men that will be used to compute something. You can give a number to a man and he will say something. Therefore, you provide a number N to the first man of the queue, and he responds: "give N-1 to the second man, take his answer and come back, we will complete the computation". Considering that, you provide N-1 to the second man and he says exactly the same as the first man: "give N-2 to the third man, take his answer and come back, we will complete the computation". The process continues for each man of the queue, until the last one. You are now in front of the last man, and you have to keep in mind the fact that the first waits for the answer of the second one, the second waits for the answer of the third one, etc. At this moment, the last one gives you an answer, which you have to provide to the penultimate, etc. until the first one of the queue. The first man is now able to answer your first question.

In this situation, you had a lot of things to keep in mind during the computation. In this exercise, we will work on a way to perform this kind of computation, without keeping as much information as that. We will use a variable which will accumulate our knowledge from step to step.

This exercise is focused on the use of accumulators. Using accumulators allows you to keep a stack constant size during the recursion calls.

You are asked to use an accumulator to compute the sum of the square of the n first integers. Here is the invariant:

`sum(n) = sum(i) + acc`

For `sum(n)`, your answer has to be:

`sum(n) = 1² + 2² + 3² + ... + n²`

## Задача Sum
Consider your code in the following template:

```oz
fun {MainSum N}
    local Sum in
        fun {Sum N Acc}
            % Your code here.
        end
        {Sum N 0}
    end
end
```

Provided the following signature, write the tail recursive function computing the sum of the square of the n first integers. You are asked to stop the recursion calls when `N == 0`.

Note: You must only write the body of the function. The signature and the final end must not be written.

The signature is:

`fun {Sum N Acc}`

Решение в файле `sum.oz`.


## Задача Mirror
Mirror
You will work with the Reverse function, which may reverse an integer, a word, a sentence, etc. For instance, reversing a string S may be useful to observe if S is a palindrome. Indeed, if S == {Reverse S} then S is a palindrome. There are lots of applications in which Reverse is useful. You will certainly be tempted, in the future, to use it. Therefore, you have to implement it yourself, in order to know how it could be done.

This exercise is focused on the use of accumulators. Using accumulators allows you to keep a stack of constant size during the recursion calls. You are asked to use accumulators to reverse an integer. For instance, given 1234, you are asked to return 4321. Do not consider integers with zeros.

At the beginning of each call to {Mirror Int Acc}, the following condition must be true:

Let I be the integer to reverse, `Digits(X)` a function returning 0 if X=0 and the number of digits in X if `X>0`, then:

```
I == (Int*(10^Digits(Acc))) + MainMirror(Acc)
```

Note: You must not use this Digits or any other defined Digits to solve this exercise.

You will want to use div (it returns the quotient of the Euclidian division) and mod (it returns the remainder of the Euclidian division) to solve this problem.

Решение: mirror.oz

## Задача Prime
Prime
This exercise is focused on the use of accumulators. Using accumulators allows you to keep a stack constant size during the recursion calls.

In this exercise, you are asked to use accumulators in order to determine if a number is prime. A prime number is a number that can be divided only by 1 and by itself (euclidean division without remainder).

Consider your code in the following template:

fun {Prime N}
    %Your code here.
end
{Prime N}
Please note that 1 is not considered as a prime number ({Prime 1} == false) and that N >= 1.

Write the Prime function, which returns true if N is a prime number and false otherwise.

Note: You must only write the body of the function. The signature and the final end must not be written.

## Задача: Числа Фибоначчи
Fib
Now that you know how many accumulators you have to use, think about their evolution. More precisely, think about the efficient fibonacci signature and how the parameters change over calls.

In this exercise, you are asked to use accumulators to compute the nth Fibonacci number. Here is the definition:

fib(0) = 0
fib(1) = 1
fib(n) = fib(n-1) + fib(n-2)
Consider your code in the following template:

fun {Fib N}
    local FibAux in
        fun {FibAux N Acc1 Acc2}
            % Your code here.
        end
        {FibAux N 0 1}
    end
end
×CloseYour answer passed the tests! Your score is 100.0%
Provided the following signature, write the tail recursive fibonacci function.

Note: You must only write the body of the function. The signature and the final end must not be written.

fun {FibAux N Acc1 Acc2}

Решение: fib.oz