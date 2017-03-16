
% Acc2 is Sum
declare
fun {Fib N}
    local FibAux in
      fun {FibAux N Acc1 Acc2}
	    if N == 1 then Acc2
	    elseif N == 0 then 0
	    else {FibAux N-1 Acc2 Acc2+Acc1} end
      end
       
      {FibAux N 0 1}
   end
end

{Browse {Fib 42}}