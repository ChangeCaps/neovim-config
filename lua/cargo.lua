local Job = require("plenary.job")
local run = require("run")

local M = {}

---@class cargo.Target
---@field name string
---@field kind string[]

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

---@param target cargo.Target
---@param kinds string[]
---@return boolean
local function is_valid_target(target, kinds)
  for _, kind in ipairs(kinds) do
    if target.kind[1] == kind then
      return true
    end
  end

  return false
end

---@param kinds string[]
---@return cargo.Target[]
local function get_targets(kinds)
  if kinds == nil then
    kinds = { "lib", "bin", "example", "test", "bench" }
  end

  local metadata = get_metadata()
  local targets = {}

  for _, package in ipairs(metadata.packages) do
    if is_package_in_workspace(metadata, package.id) then
      for _, target in ipairs(package.targets) do
        if is_valid_target(target, kinds) then
          table.insert(targets, target)
        end
      end
    end
  end

  return targets
end

---@param kinds string[]
---@param on_select fun(target: cargo.Target)
local function select_target(kinds, on_select)
  local targets = get_targets(kinds)

  local max_name_length = 0

  for _, target in ipairs(targets) do
    max_name_length = math.max(max_name_length, #target.name)
  end

  vim.ui.select(targets, {
    prompt = "Select target",
    format_item = function(item)
      local whitespace = string.rep(" ", math.max(max_name_length - #item.name, 0))
      return item.name .. whitespace .. " - " .. item.kind[1]
    end
  }, on_select)
end

---@param command string
local function run_in_window(command)
  local prev_buf = vim.api.nvim_get_current_buf()

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_win_set_buf(win, buf)

  local function quit()
    vim.api.nvim_win_set_buf(win, prev_buf)
    vim.api.nvim_buf_delete(buf, { force = true })
  end

  vim.keymap.set("n", "q", quit, { buffer = buf })
  vim.keymap.set("n", "<CR>", quit, { buffer = buf })
  vim.keymap.set("n", "<Esc>", quit, { buffer = buf })

  vim.fn.termopen(command)
  vim.api.nvim_input("G")
end

local last_build_command = nil
local last_run_command = nil

M.check = function()
  run_in_window("cargo check")
end

M.test = function(opts)
  local command = "cargo test" .. " " .. opts.args
  run_in_window(command)
end

M.build = function(opts)
  select_target(
    { "lib", "bin", "example", "test", "bench" },
    function(target)
      if target == nil then
        return
      end

      local command = "cargo build --" ..
        target.kind[1] .. " " ..
        target.name .. " " ..
        opts.args

      last_build_command = command

      run_in_window(command)
    end
  )
end

M.build_last = function(opts)
  if last_build_command and #opts.fargs == 0 then
    run_in_window(last_build_command)
    return
  end

  M.build()
end

M.run = function(opts)
  if opts == nil then
    opts = {}
  end

  select_target(
    { "bin", "example", "test", "bench" },
    function(target)
      if target == nil then
        return
      end

      local function run_target(args)
        local command = "cargo run --" ..
          target.kind[1] .. " " ..
          target.name .. " " ..
          opts.args

        if #args > 0 then
          command = command .. " -- " .. args
        end

        last_run_command = command

        run_in_window(command)
      end

      if target.kind[1] == "bin" or target.kind[1] == "example" then
        run.get_arguments(run_target)
      else
        run_target("")
      end
    end
  )
end

M.run_last = function(opts)
  if last_run_command and #opts.fargs == 0 then
    run_in_window(last_run_command)
    return
  end

  M.run()
end

return M
