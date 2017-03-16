# Higher-order programming and records

Базируется на двух понятиях:
* Contextual environment
* Procedure value

С помощью этого можно реализовать любые фишки ООП.

## Contextual environment
В этом примере выведется `100`:

```oz
local P Q in
   proc {P}
      {Browse 100}
   end

   proc {Q}
       {P}
   end
   
   local P in
      proc {P}{Browse 200} end
      {Q}
   end
end
```

Процедура `{Q}` при создании имеет свою структуру данных — contextual environment. И в ней она сохраняет все то, от чего зависит.

Cont. env. — функции содержит в себе ссылки на идентификаторы, используемые в функции, но объявленные снаружи ее.

a free identifier is a identifier that is called in the function but is declared outside of it :) the contextual environnement is made of all theses free identifier

## Procedure Values
Procedures are values in memory. Variables are bound to procedure values.

На самом деле такая запись — синтаксический сахар:

```oz
proc {Inc X Y} Y=X+A end
```

На самом деле идентификатор `Inc` привязывается (bound to) к анонимной процедуре:

```oz
Inc = proc {$ X Y} Y=X+A end
```

То есть процедура — это значение в памяти. Знак `$` говорит, что у процедуры нет имени, это плейсхолдер.

В памяти значение процедуры хранится как пара: код процедуры и ее контекст:

```oz
inc = (proc {$ X Y} Y=X+A end, {A->a})
```

То, что в круглых скобках — это и есть procedure value: код процедуры и контекст вызова. Вот это значение назвают замыканием (closure) или лексическим окружением (lexically scoped closure).

Еще пример:

```oz
local D=2 in
    proc {Add B C E}
       E = B + C + D
    end
end

add = (proc {$ B C E} E = B+C+D end, {D->d}
```

Procedure value with a contextual environment — важнейшее изобретение в программировании. Дает возможность масштабировать системы, создавать абстракции и инкапсуляцию.

Функция — процедура с одним дополнительным выходным параметром.

## Order of a function
We define the order of a function (or procedure):
* A function whose inputs and output are not functions is first order.
* A function is order `N+1` if its inputs and output contain a function of maximum order `N` (higher-order, order > 1).

## Genericity
Genericity is when a function is passed as an input.

Пример — функция `Map`:

```oz
declare
fun {Map F L}
    case L of nil then nil
    [] H|T then {F H}|{Map F T} end
end

{Browse {Map fun {$ X} X*X end [7 8 9]}}
```

Здесь анонимная ф-я, передаваемая в `Map`, имеет порядок (order) 1. Соответственно, сама ф-я `Map` имеет порядок 2.

## Instantiation
Instantiation is when a function is returned as an output.

```oz
declare
fun {MakeAdd A}
    fun {$ X}
        X+A
    end
end

Add5 = {MakeAdd 5}{Browse {Add5 100}}
```

Прослеживается аналог между классами и экземплярами классов в ООП. Так и есть, связь достаточно большая.

## Function composition
We take two functions as input and return their composition:

```oz
declare
fun {Compose F G}
   fun {$ X}
      {F {G X}}
   end
end

Fnew = {Compose fun {$ X} X*X end
                fun {$ X} X+1 end }

{Browse {Fnew 2}} % 9
{Browse {{Compose Fnew Fnew} 2}} % 100
```

## Abstracting an accumulator

## Encapsulation
We can hide a value inside a function:

```oz
declare
fun {Zero}
    0
end

fun {Inc H}
    N = {H} + 1 in
    fun {$}
        N
    end
end

Three = {Inc {Inc {Inc Zero}}}
{Browse {Three}} % 3
```

This is the foundation of encapsulation as used in data abstraction
What is the difference if we write Inc as follows:

```oz
fun {Inc H}
    fun {$}
        {H} + 1
    end
end
```


