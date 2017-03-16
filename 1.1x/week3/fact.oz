declare
fun {Fact N}
	local FactInner Makelist in
		fun {FactInner N Acc}
		   if N == 1 then Acc
		   else {FactInner N-1 Acc*N} end
		end

		fun {Makelist L N Acc}
		   if Acc == N + 1 then L
		   else {Makelist {Append L {FactInner Acc 1}|nil} N Acc + 1} end   
		end

		{Makelist nil N 1}
	end
end

{Browse {Fact 4}}
