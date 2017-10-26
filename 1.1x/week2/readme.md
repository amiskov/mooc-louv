# Lesson 2: Recursion, loops, and invariant programming
## Overview of invariant programming
Темы урока:
* Инвариантное программирование. Invariant — a mathematical formula that is true at each recursive call.
* Спецификация функции (математическое представление того, что она делает). Specification — a mathematical formula that defines what the function calculates.
* Аккумулятор
* Принцип сообщающихся сосудов

Циклы можно реализовать с помощью хвостовой рекурсии (tail recursion), когда рекурсивный вызов происходит в конце тела функции.

Цикл — форма рекурсии, в которой повторный вызов функции происходит в конце ее тела.

## Invariant
Инвариант — это формула, условие, которое остается неизменным (`true`) при выполнении каждой итерации. Такие формулы используют в рекурсиях, чтобы избавится от заполнения стэка. Чтоб все вычисления происходили внутри функции, без вызова и вместо такого: `N * {Factorial N - 1}` было бы такое: `{Factorial I-1 I*A}` (с аккумулятором).

## Factorial with communicating vases
На примере факториала. Факториал от `n` (обозначается `n!`) — это перемножение последовательности чисел: `1 * 2 * 3 * ... * n`. Факториал от `0` равен `1`, поэтому на самом деле будет: `1 * 1 * 2 * 3 * ... * n`. Что можно записать так:

```
n! = n * (n - 1)! если n > 0
n! = 1 если n == 0
```

Рекурсивная функция для вычисления:

``` oz
declare
fun {Fact1 N}
   if N == 0 then 1
   else N * {Fact1 (N - 1)}
   end
end

{Browse {Fact1 4}}
```

Такой функции надо на каждой итерации сохранять значение `{Fact1 (N - 1)}` в стэке, чтоб потом их все перемножить. Это дорого.

Если абстрагироваться от переменных справа, можно записать так:

```
n! = i! * a
```

То есть мы имеем какой-то факториал `i!`, который умножается на какое-то `a` и мы получаем `n!`.

При `i == n` и `a == 1` мы получим `n! = n! * 1`. Ну тут хер поспоришь.

А если у нас будет `i == 0`, то результатом будет `a`: `n! = 0! * a` (чтобы равенство выполнялось наше `a` как раз должно быть как `n!`).

Пример, где `n == 4`. Помним, что `4! = 4 * 3 * 2 * 1 * 1`. Получим ряд истинный выражений (все равенства `true`):

```
4! == 4! * 1
4! == 3! * (4 * 1)             == 3! * 4
4! == 2! * (4 * 3 * 1)         == 2! * 12
4! == 1! * (4 * 3 * 2 * 1)     == 1! * 24
4! == 0! * (4 * 3 * 2 * 1 * 1) == 0! * 24
```

Мы можем представить тождество по-разному, передавая куски из `i` в `a`. В этом и заключается принцип сообщающихся сосудов (инвариантная формула).

Получается, что на каждой итерации у нас появляется `i' = i - 1` и `a' = i * a`, которые передадутся в следующий вызов. И так будет до тех пор, пока мы не уменьшим `i` до `0` (пока все значения из `i` не перетекут в `a`). Начальные значение  `i` — число, от которого надо вычислить факториал, `a` — единица:

```
Факториал (i, a) {
    если i == 0
        вернуть a
    иначе
        вернуть Факториал (i - 1, i * a) // то есть Факториал (i', a')
}
```

Получим такое:

``` oz
declare
fun {Fact2 I A}
   if I == 0 then A
   else {Fact2 (I - 1) (A * I)}
   end
end

{Browse {Fact2 4 1}}
```

Так норм, нигде ничего не надо сохранять, все дешево.

## Sum of digits with communicating vases
Рекурсивная функция, которая считает суммирует все цифры переданного интеджера:

``` oz
declare
fun {SumDigitsR N}
   if (N == 0) then 0
   else
      (N mod 10) + {SumDigitsR (N div 10)}
   end
end

{Browse {SumDigitsR 314159}}
```

Кажется, что тут особо менять нечего. Но на самом деле есть более эффективный способ сделать такое вычисление.

Например, `n=314159`. Нам нужно просуммировать эти числа. Представить это можно так:

```
s(314159) = s(314159) + 0
s(314159) = s(31415) + 9
s(314159) = s(3141) + 14
s(314159) = s(314) + 15
s(314159) = s(31) + 19
s(314159) = s(3) + 20
s(314159) = s(0) + 23 = 0 + 23 = 23
```

Инвариант: `s(n) = s(dk-1, dk-2, ···, di) + (di-1 + di-2 + ··· + d0)`. Получаем новую функцию:

``` oz
declare
fun {SumDigits2 S A}
    if S==0 then A
        else {SumDigits2 (S div 10) A + (S mod 10)}
    end
end
```

## The golden rule of tail recursion


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

``` oz
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

## The golden rule of tail recursion
[Слайды](https://d37djvu3ytnwxt.cloudfront.net/assets/courseware/v1/aa216449e7f6438be93d75ff35767dc2/asset-v1:LouvainX+Louv1.1x+3T2017+type@asset+block/2-4tailrecursionFigure.pdf)

Рекурсивную ф-ю можно написать математически и инвариантно. Первая будет неоптимальной, плохо будет работать, но понятной. Вторая — более заморочной, но работать будет лучше.

Инвариантная версия (сообщающиеся сосуды) принимает 2 аргумента (добавляется аккумулятор). И рекусивный вызов функции — последний в коде тела функции. Нет никаких операций с вызываемой функции, она просто вызывается с новыми аргументами.

Использовать в программах математическую рекурсию не правильно. Это ведет к огромным вычислительным затратам. Надо юзать хвостовую рекурсию (то есть инвариантное программирование, принцип сообщающихся сосудов). Найти инвариантную формулу и юзать ее — создать **true loop**.

Декларативная версия true loop: инвариантная формула, single assignment (переменные не переопределяются):

``` oz
fun {While S}
  if {IsDone S} then S
  else {While {Transform S}} end % tail recursion
end
```

Императивная (используется multiple assignment, можно переопределять переменные):

```c++
state whileLoop(state s) {
  while (!isDone(s))
    s = transform(s); /* destructive assignment */
  return s;
}
```

Задача Prime.

## Invariant programming to calculate powers
* Рекурсивная функция эквивалентна циклу, когда она хвостовая.
* Хвостовая рекурсия реализуется через аккумулятор
* Для аккумулятора нужно найти инвариантную формулу, которая всегда `true` (true loop) и работает по принципу сообщающихся сосудов

Это называется инвариантное программирование и только так нужно писать рекурсивные функции. Инвариантное программирование распространяется на все парадигмы.

Напишем функцию, которая вычисляет `X` в степени `N`: `{Pow X N}`, где `X >= 0`. Спецификация функции (математическое определение):

X<sup>0</sup> = 1<br>
X<sup>n</sup> = X * X<sup>n-1</sup>, при `n > 0`

По-простому, получим:

``` oz
declare
fun {Pow X N}
   if N == 0 then 1
   else X * {Pow X (N - 1)} end
end

{Browse {Pow 3 3}} % 27
```

Но эта функция не эффективна: долго выполняется, использует много памяти.

Можно оптимизировать так. Например, нужно возвести в 16-ю степень. Можно делать умножение 16 раз, а можно сделать меньше итераций, если учесть, что:

X<sup>16</sup> = X<sup>8</sup> * X<sup>8</sup><br>
X<sup>8</sup> = X<sup>4</sup> * X<sup>4</sup><br>
X<sup>4</sup> = X<sup>2</sup> * X<sup>2</sup><br>
X<sup>2</sup> = X * X<br>
X<sup>1</sup> = X

То есть, если надо возвести в четную степень, то можно добавлять не `1`, а `2` на каждой итерации и их будет меньше. Теперь спецификацию можно записать так:

X<sup>0</sup> = 1<br>
X<sup>n</sup> = X * X<sup>n-1</sup>, при `n > 0` и `n` — нечетное<br>
X<sup>n</sup> = Y<sup>2</sup>, где Y = X<sup>n/2</sup> при `n > 0` и `n` — четное

Получим:

``` oz
declare
fun {Pow X N}
   if N == 0 then 1
   elseif ((N mod 2) == 0) then Y in
      Y = {Pow X (N div 2)}
      Y * Y
   else
      X * {Pow X (N - 1)}
   end
end

{Browse {Pow 3 8}} % 6561
```

Лучше вычисление, но рекурсия не хвостовая, стэк быстро заполнится. Для хвостовой рекурсии нужен инвариант. Шукаем...

X<sup>n</sup> = Y<sup>i</sup> * a

Тут `X` и `n` — константы, а `Y`, `i` и `a` будут меняться каждую итерацию.

У нас есть `(y, i, a)`.

Сначала будет `(y, i, a) = (x, n, 1)`. Будем уменьшать `i`, сохраняя наш инвариант `true`. Мы можем уменьшать `i` двумя способами:

```
(y, i, a) => (y*y, i/2, a), когда i четное
(y, i, a) => (y, i-1, y*a), когда i нечетное
когда i = 0, будет просто `a`
```

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