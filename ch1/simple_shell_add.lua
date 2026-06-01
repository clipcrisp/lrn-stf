#!/opt/homebrew/bin/lua

-- Lua has a global array for args passed to a script, take the following
-- example and it's lay out in the arg[] array.
--
-- ex. lua -e "sin=math.sin" script a b
-- arg[-3] = "lua"
-- arg[-2] = "-e"
-- arg[-1] = "sin=math.sin"
-- arg[0] = "script"
-- arg[1] = "a"
-- arg[2] = "b"
--
-- Simple addition script below

if arg[1] == nil or arg[2] == nil then
    print("Please provide two integer arguments to add.")
    os.exit(1)
elseif arg[3] ~= nil then
    print("Please provide two integer arguments to add.")
    os.exit(1)
elseif math.tointeger(arg[1]) == nil or math.tointeger(arg[2]) == nil then
    print("Please provide two integer arguments to add.")
    os.exit(1)
end

print(math.tointeger(arg[1]) + math.tointeger(arg[2]))
