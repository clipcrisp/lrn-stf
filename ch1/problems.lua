-- Ex 1.1
function Fact(n)
    if n == 0 then
        return 1
    else
        return n * Fact(n-1)
    end
end

function Ex1_1()
    print("Enter a number:")
    A = io.read("*n")

    if A < 0 then
        print("Can't input negative numbers.")
        os.exit(1)
    end

    print(Fact(A))
end


-- Boilerplate for all exercises in one file. Some of the questions may not
-- have solves but I'll probably print my thinking.
if arg[1] == nil then
    print("Please enter a exercise number to run the solve.")
    print("Exercises: 1.1, 1.2, ... 1.8")
    os.exit(1)
elseif arg[1] == "1.1" then
    Ex1_1()
end

