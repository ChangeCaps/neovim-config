local Job = require("plenary.job")

local function metadata()
	local job = Job:new({
		command = "cargo",
		args = { "metadata", "--format-version", "1" },
	})

	job:sync()
	local metadata = job:result()

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

local function targets(meta)
	if meta == nil then
		meta = metadata()
	end

	local targets = {}

	for _, package in ipairs(meta.packages) do
		if is_workspace_member(meta, package.id) then
			for _, target in ipairs(package.targets) do
				table.insert(targets, target)
			end
		end
	end

	return targets
end

local function binary_targets(meta)	
	local targets = targets(meta)
	local binary_targets = {}

	for _, target in ipairs(targets) do
		if target.kind[1] == "bin" then
			table.insert(binary_targets, target)
		end
	end

	return binary_targets
end

local function test_targets(meta)
	local targets = targets(meta)
	local test_targets = {}

	for _, target in ipairs(targets) do
		if target.kind[1] == "test" then
			table.insert(test_targets, target)
		end
	end

	return test_targets
end

local function choose_target(targets)	
	if #targets == 0 then
		vim.notify("No binary targets found", vim.log.levels.ERROR)
		return nil
	end

	if #targets == 1 then
		return targets[1]
	end

	local names = {}

	for _, target in ipairs(targets) do
		table.insert(names, target.name)
	end

	local choice = vim.fn.inputlist(names)

	if choice == 0 then
		vim.notify("No binary target chosen", vim.log.levels.ERROR)
		return nil
	end

	return targets[choice]
end

local function choose_binary_target(meta)
	return choose_target(binary_targets(meta))
end

local function choose_test_target(meta)
	return choose_target(test_targets(meta))
end

local function build(target)
	local args = { "build", "--message-format=json" }
	if target ~= nil then
		if target.kind[1] == "bin" then
			table.insert(args, "--bin")
		elseif target.kind[1] == "test" then
			table.insert(args, "--test")
		end

		table.insert(args, target.name)
	end

	vim.notify("Building " .. target.name .. "... This may take some time")

	Job:new({
		command = "cargo",
		args = args,
	}):sync()
end

return {
	metadata = metadata,
	binary_targets = binary_targets,
	test_targets = test_targets,
	choose_target = choose_target,
	choose_binary_target = choose_binary_target,
	choose_test_target = choose_test_target,
	build = build,
}
