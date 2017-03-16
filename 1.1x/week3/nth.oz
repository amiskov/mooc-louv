% Взять N-й элемент списка
declare
fun {Nth L N}
	if N == 1 then L.1
	else {Nth L.2 N-1}
end