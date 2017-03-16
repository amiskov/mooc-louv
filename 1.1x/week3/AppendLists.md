Intuitive Append
You will often need to produce one list from two other lists using the Append function. Therefore, it is necessary to learn how it may be done before using it.

This exercise is focused on the use of lists. Lists can be represented in several forms. For instance:

[a b c] == a|b|c|nil == '|'(1:a 2:'|'(1:b 2:'|'(1:c 2:nil)))
In this exercise, you are asked to append two lists. L2 appended to L1 means that the elements of L2 are added at the end of L1. For instance, {AppendLists [1 2 3] [4 5 6]} returns [1 2 3 4 5 6].

Consider your code in the following template:

fun {AppendLists L1 L2}
    % Your code here.
end
Provided the following signature, write the append function for two lists:

Note: You must only write the body of the function. The signature and the final end must not be written.

fun {AppendLists L1 L2}