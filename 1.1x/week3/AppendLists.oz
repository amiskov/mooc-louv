declare
fun {AppendLists L1 L2}
   local IsNil IsCons Car Cdr Cons in
      fun{IsNil X}
	     X==nil
      end

      fun{IsCons X}
	     case X of _|_ then true
	     else false
	   end
   end

      fun {Car H|T}
	 H
      end

      fun{Cdr H|T}
	 T
      end

      fun{Cons H T}
	 H|T
      end

      if {IsNil L1} then L2
      else {Cons {Car L1} {AppendLists {Cdr L1} L2}}
      end
   end
end


{Browse {AppendLists [1 2] [1 2 3]}}

