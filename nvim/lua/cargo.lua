local function metadata()
	local f = io.popen("cargo metadata --format-version 1", "r")
	f:flush()
	local metadata = f:read("*a")
	f:close()

	return vim.fn.json_decode(metadata)
end

local function is_workspace_member(meta, id)
	for _, member in ipairs(meta.workspace_members) do
		if member == id then
			return true
		end
	end

	return false
end

local function binary_targets(meta)
	if meta == nil then
		meta = metadata()
	end

	local targets = {}	

	for _, package in ipairs(meta.packages) do	
		for _, target in ipairs(package.targets) do
			if target.kind[1] == "bin" and is_workspace_member(meta, package.id) then
				table.insert(targets, target)
			end
		end
	end	

	return targets
end

local function build(target)
	local args = { "build", "--message-format=json" }
	if target ~= nil then
		table.insert(args, "build")
		table.insert(args, "--bin")
		table.insert(args, target)
	end

	local job = require("plenary.job")

	vim.notify("Building " .. target .. "... This may take some time")

	job:new({
		command = "cargo",
		args = args,
	}):sync()
end

return {
	metadata = metadata,
	binary_targets = binary_targets,
	build = build,
}
