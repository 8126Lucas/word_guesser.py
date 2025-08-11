local words = require "words"

function clearScreen()
    if package.config:sub(1,1) == "\\" then
        os.execute("cls")
    else
        os.execute("clear")
    end
end

function randomWord()
    local index = math.random(#words)
    local word = words[index]
    return word
end

function gameHeader(word, lives)
    print("It's a " .. #word .. " letter word. Therefore you have " .. lives .. " lives.")
end

function processOutput(word, points, lives)
    for i = 1, #word do
        local letter = string.sub(word, i, i)
        if points[i] == true then
            io.write(letter .. " ")
        else
            io.write("_ ")
        end
    end
    print("\t Lives: " .. lives .. "/" .. #word)
end

function processInput(word, points, lives)
    local found = false
    io.write("> ")
    local guess = io.read()
    for i = 1, #word do
        local letter = string.sub(word, i, i)
        if guess == letter then
            points[i] = true
            found = true
        end
    end
    if found == false then
        lives = lives - 1
    end
    if lives == 0 then
        print("GAME OVER! GOODBYE! BTW the word was \"" .. word .. "\"")
        os.exit()
    else
        processOutput(word, points, lives)
    end
    return lives
end

function checkWin(points)
    for i = 1, #points do
        if points[i] == false then
            return false
        end
    end
    return true
end

function main()
    math.randomseed(os.time())
    clearScreen()
    local word = randomWord()
    local points = {}
    for i = 1, #word do
        points[i] = false
    end
    local lives = #word
    local win = false
    gameHeader(word, lives)
    while win == false and lives ~= 0 do
        lives = processInput(word, points, lives)
        if checkWin(points) then
            win = true
        end
    end
end

main()