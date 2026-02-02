local function find_opening_paren(line, pos)
	local stack = 0
	for i = pos-1, 1, -1 do
		local char = line:sub(i, i)
		if char == ')' then
			stack = stack + 1
		elseif char == '(' then
			if stack == 0 then
				return i
			else
				stack = stack - 1
			end
		end
	end
	return nil
end

local function find_closing_paren(line, pos)
	local stack = 0
	for i = pos+1, string.len(line) do
		local char = line:sub(i, i)
		if char == '(' then
			stack = stack + 1
		elseif char == ')' then
			if stack == 0 then
				return i
			else
				stack = stack - 1
			end
		end
	end
	return nil
end

local function find_paren()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local start_pos, end_pos

	for i = col+1, 1, -1 do
		local char = line:sub(i, i)
		if char == ')' then
			start_pos = find_opening_paren(line, i)
			end_pos = i
			break
		elseif char == '(' then
			start_pos = i
			end_pos = find_closing_paren(line, i)
			break
		end
	end

	return start_pos, end_pos
end

local function tokenize(expr)
	local args = {}
	local func = nil
	for token in expr:gmatch("%S+") do
		if func == nil then
			func = token
		else
			table.insert(args, token)
		end
	end
	return func, args
end

local function add(args)
	local res = 0
	for _, arg in ipairs(args) do
		local num = tonumber(arg)
		if num then
			res = res + num
		else
			return nil, "Expected number, got string in lua: function add()"
		end
	end
	return res, nil
end

local function subtract(args)
	local res = tonumber(args[1])
	for i = 2, #args do
		local num = tonumber(args[i])
		if num then
			res = res - num
		else
			return nil, "Expected number, got string in lua: function subtract()"
		end
	end
	return res, nil
end

local function multiply(args)
	local res = tonumber(args[1])
	if res == 0 then return 0 end

	for i = 2, #args do
		local num = tonumber(args[i])
		if num == 0 then return 0 end

		if num then
			res = res * num
		else
			return nil, "Expected number, got string in lua: function multiply()"
		end
	end
	return res, nil
end

local function divide(args)
	local res = tonumber(args[1])
	if res == 0 then return 0 end

	for i = 2, #args do
		local num = tonumber(args[i])
		if num == 0 then return nil, "Cannot divide by 0" end

		if num then
			res = res / num
		else
			return nil, "Expected number, got string in lua: function divide()"
		end
	end
	return res, nil
end

local function eval(expr)
	local res, err
	local func, args = tokenize(expr)
	if func == '+' then
		res, err = add(args)
	elseif func == '-' then
		res, err = subtract(args)
	elseif func == '*' then
		res, err = multiply(args)
	elseif func == '/' then
		res, err = divide(args)
	else
		return nil, string.format("Not a valid operation: %s", func)
	end
	if err ~= nil then
		return nil, err
	else
		return res, nil
	end
end

local function eval_and_replace()
	local start_pos, end_pos = find_paren()
	if not start_pos then
		vim.notify("Unbalanced parentheses", vim.log.levels.ERROR)
		return
	elseif not end_pos then
		vim.notify("Containing expression ends prematurely", vim.log.levels.ERROR)
		return
	end
	local line = vim.api.nvim_get_current_line()
	local expr = line:sub(start_pos+1, end_pos-1)
	local res, err = eval(expr)
	if err ~= nil then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end
	local before = line:sub(0, start_pos-1)
	local after = line:sub(end_pos+1, string.len(line))
	local new = before .. res .. after

	local cur = vim.api.nvim_win_get_cursor(0)
	cur[2] = string.len(before .. res) - 1
	vim.api.nvim_set_current_line(new)
	vim.api.nvim_win_set_cursor(0, cur)
end


vim.keymap.set("n", "<leader>j", eval_and_replace)

-- TODO: FUNCTIONS:
-- extended math
--
-- TODO: FEATURES:
-- multiline sexps
-- eval sub-sexps as argument to main sexp
