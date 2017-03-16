% Расчет суммы элементов списка
declare
fun {Sum L}
	if L == nil then 0
	else L.1 + {Sum L.2} end
end

{Browse {Sum [1 2 3]}}


% Хвостовая оптимизация
declare
fun {SumTail L A}
	if L == nil then A
	else {SumTail L.2 L.1 + A} end
end

{Browse {SumTail [1 2 3] 0}}
