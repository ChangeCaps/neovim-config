local locaters = {}
local function locate()
	local ft = vim.bo.filetype

	if locaters[ft] then
		if type(locaters[ft]) == "function" then
			local program = locaters[ft]()

			if program then
				return program
			end
		else
			return locaters[name]
		end
	end

	return vim.fn.input("Enter program path: ", vim.fn.getcwd() .. "/", "file")
end

return {	
	locaters = locaters,
	locate = locate,
}
