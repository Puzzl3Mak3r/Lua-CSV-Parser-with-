-- The Replacer, replaces commas with ¤, but this character is replaceable
local function replace_commas_with_forex(text)
    local result = "" -- New text getting formed
    local in_string = false
    for i = 1, #text do
        local char = text:sub(i, i)
        if char == '"' then -- Check if the current character is a " to replace the next commas with ¤
            in_string = not in_string
        elseif char == ',' and in_string then
            char = '¤' -- Replace the comma with ¤, can be swapped out with any character
        end
        result = result .. char -- Add the current character to the new text
    end
    print("Result: "..result)
    return result
end

-- The Parser
local function parse_csv_to_array(oldCsv)
    -- The 2D array
    local csv = replace_commas_with_forex(oldCsv) -- Call the Replacer
    local array = {} -- The 2D array the csv will be parsed into
    for line in csv:gmatch("[^\r\n]+") do -- Split lines
        -- The 1D array inside the 2D array
        local row = {}
        for cell in line:gmatch("[^,]+") do -- Split cells
            table.insert(row, cell) -- Add cells
        end
        table.insert(array, row) -- Add rows
    end
    return array
end