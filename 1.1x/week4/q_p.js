// Вопрос на понимание областей видимости.
// Что выведется в консоли и почему?
let p = () => console.log(100);

let q = () => {
	// LE.p = function() { console.log(100); }
    p();
}

{
    let p = () => console.log(200);
    q();
}
