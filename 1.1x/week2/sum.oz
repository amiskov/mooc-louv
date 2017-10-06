% https://courses.edx.org/courses/course-v1:LouvainX+Louv1.1x+3T2017/courseware/bdbc6ae009e94fdd818b2815c3958a3c/41feb55f96054e7785ffd3155d56879a/?activate_block_id=block-v1%3ALouvainX%2BLouv1.1x%2B3T2017%2Btype%40sequential%2Bblock%4041feb55f96054e7785ffd3155d56879a
declare
fun {MainSum N}
    local Sum in
    	fun {Sum N Acc}
			if N == 0 then Acc
	    	else {Sum (N - 1) (Acc + N * N)}
	    	end
        end
        
        {Sum N 0}
    end
end

{Browse {MainSum 4} == 30}
