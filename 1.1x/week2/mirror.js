// Imperative
function mirror(int) {
    var mirroredInt = 0;

    while (int > 0) {
        mirroredInt = mirroredInt * 10 + int % 10;
        int = Math.trunc(int / 10); // присваивание, деструктивная операция
    }

    return mirroredInt;
}

console.log(mirror(1234));

// Declarative
function mirrorR(int, acc) {
    if (int == 0) {
        return acc;
    } else {
        return mirrorR(Math.trunc(int / 10), acc * 10 + int % 10); // Хвостовая рекурсия, ничего не меняем
    }
}
console.log(mirrorR(1234, 0));
