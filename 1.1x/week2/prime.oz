declare
fun {Prime N}
   local CheckN in
      fun {CheckN N Acc}
	 if (Acc == 1) then true
	 elseif (N mod Acc == 0) then false
	 else {CheckN N Acc - 1} end
      end

      if (N == 1) then false
      else {CheckN N (N div 2)} end
      
   end
end
{Browse {Prime 6}}