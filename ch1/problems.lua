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

-- Apparently \n doesn't work in lua
function Ex1_2()
    local text = [[

I feel like using the -i when starting the interpreter makes more sense for
debugging an application with input. dofile() seems more pertinent for testing
out functions in a library or some other script that doesn't require input.]]
    print(text)
end

function Ex1_3()
    -- TODO: I have never heard of some of these languages, should look up.
    local text = [[

I do not know any other languages that use -- for comments, but I can look them
up now. If dk949 on Github is to be believed: ada, ahdl, asn, cabal, csp,
eiffel, gdmo, lace, mib, occam, sa, sather, vhdl, applescript, blade, laravel,
catalog, sgmldecl, elm, haskell, idris, literal haskell, hive, sqlforms, sqlj,
lean. Who knew!
Link to gist: https://gist.github.com/dk949/88b2652284234f723decaeb84db2576c]]
    print(text)
end

function Ex1_4()
    local text = [[

The valid identifiers are "___", "_end", "End" and "NULL". Double checked to be
correct with the interperter.]]
    print(text)
end

function Ex1_5()
    local text = [[

type(nil) == nil resolves to false because the type function returns a string
that is the name of the type. Double checked with interpreter.]]
    print(text)
    print("type(nil) == nil equals " .. tostring(type(nil) == nil))
end

-- Boilerplate for all exercises in one file. Some of the questions may not
-- have solves but I'll probably print my thinking.
if arg[1] == nil then
    print("Please enter a exercise number to run the solve.")
    print("Exercises: 1.1, 1.2, ... 1.8")
    os.exit(1)
elseif arg[1] == "1.1" then
    Ex1_1()
elseif arg[1] == "1.2" then
    Ex1_2()
elseif arg[1] == "1.3" then
    Ex1_3()
elseif arg[1] == "1.4" then
    Ex1_4()
elseif arg[1] == "1.5" then
    Ex1_5()
end
