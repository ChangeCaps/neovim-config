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

local function select_target(on_select)
  local targets = get_targets()

  vim.ui.select(targets, {
    prompt = "Select target",
    format_item = function(item)
      return item.name .. " (" .. item.kind[1] .. ")"
    end
  }, on_select)
end

M.build = function()
  select_target(function(target)
    if target == nil then
      return
    end

    local command = "cargo build --" .. target.kind[1] .. " " .. target.name
    local prev_buf = vim.api.nvim_get_current_buf()

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_win_set_buf(win, buf)

    vim.fn.termopen(command, {
      on_exit = function(_, _, _)
        local function close ()
          vim.api.nvim_win_set_buf(win, prev_buf)
          vim.api.nvim_buf_delete(buf, { force = true })
        end

        vim.keymap.set("n", "<CR>", close, { buffer = buf })
          vim.keymap.set("n", "q", close, { buffer = buf })
        end
    })
  end)
end

M.run = function()
  select_target(function(target)
    if target == nil then
      return
    end

    local command = "cargo run --" .. target.kind[1] .. " " .. target.name
    local prev_buf = vim.api.nvim_get_current_buf()

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_win_set_buf(win, buf)

    vim.fn.termopen(command, {
      on_exit = function(_, _, _)
        local function close ()
          vim.api.nvim_win_set_buf(win, prev_buf)
          vim.api.nvim_buf_delete(buf, { force = true })
        end

        vim.keymap.set("n", "<CR>", close, { buffer = buf })
        vim.keymap.set("n", "q", close, { buffer = buf })
      end
    })
  end)
end

return M
