local Job = require("plenary.job")

local M = {}

local function get_metadata()
  local job = Job:new({
    command = "cargo",
    args = { "metadata", "--format-version", "1" },
  })

  job:sync()
  return vim.fn.json_decode(job:result())
end

local function is_package_in_workspace(metadata, package_id)
    for _, member in ipairs(metadata.workspace_members) do
        if member == package_id then
            return true
        end
    end

    return false
end

local function is_valid_target(target)
  return target.kind[1] == "bin" or target.kind[1] == "example"
end

local function get_targets()
  local metadata = get_metadata()
  local targets = {}

  for _, package in ipairs(metadata.packages) do
    if is_package_in_workspace(metadata, package.id) then
      for _, target in ipairs(package.targets) do
        if is_valid_target(target) then
          table.insert(targets, target)
        end
      end
    end
  end

  return targets
end

M.run = function()
  local targets = get_targets()

  vim.ui.select(targets, {
    prompt = "Select target to run",
    format_item = function(item)
      return item.name .. " (" .. item.kind[1] .. ")"
    end
  }, function(target)
    if target == nil then
      return
    end

    vim.cmd("term! cargo run --" .. target.kind[1] .. " " .. target.name)
  end)
end

return M
