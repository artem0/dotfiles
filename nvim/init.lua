-- Bootstrap lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  { "junegunn/fzf", build = ":call fzf#install()" }, -- Install fzf binary
  "junegunn/fzf.vim",                                -- fzf.vim integration
  "easymotion/vim-easymotion",                       -- EasyMotion plugin
  { "nvim-tree/nvim-tree.lua",                       -- nvim-tree plugin
  -- "nvim-tree/nvim-web-devicons" is disabled; it shows ? because of iTerm2 - https://github.com/ryanoasis/vim-devicons/issues/198#issuecomment-338769056
    config = function()
      require("nvim-tree").setup({
      -- Left Arrow: go up a dir, Right Arrow/Enter: enter dir or open file, o - expand/collapse, r - rename, a - create
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          api.config.mappings.default_on_attach(bufnr)
          local o = { buffer = bufnr, noremap = true, silent = true, nowait = true }
          local function open_or_enter()
            local node = api.tree.get_node_under_cursor()
            if node.type == "directory" then api.tree.change_root_to_node()
            else api.node.open.edit() end
          end
          vim.keymap.set("n", "<CR>", open_or_enter, o)    -- enter dir or open file
          vim.keymap.set("n", "<Right>", open_or_enter, o) -- same
          vim.keymap.set("n", "yc", function()              -- copy file to clipboard
            local node = api.tree.get_node_under_cursor()
            if node and node.absolute_path then
              if vim.fn.has("mac") == 1 then
                vim.fn.system({
                  "osascript", "-e",
                  'set the clipboard to (POSIX file "' .. node.absolute_path .. '")'
                })
                vim.notify("Copied: " .. node.name)
              else
                vim.notify("yc: file copy not supported on this OS", vim.log.levels.WARN)
              end
            end
          end, o)
          vim.keymap.set("n", "<Left>", function()         -- go up, focus the dir we came from
            local current_root = require("nvim-tree.core").get_explorer().absolute_path
            local dir_name = vim.fn.fnamemodify(current_root, ":t")
            api.tree.change_root_to_parent()
            vim.schedule(function()
              api.tree.collapse_all()
              vim.fn.search(dir_name, "w")
            end)
          end, o)
        end,
        view = {
          width = 30, -- Default width of the tree
        },
        renderer = {
          highlight_git = true, -- color filenames by git status
          add_trailing = true,  -- append `/` to directory names
          icons = {
            show = {
              file = false,         -- Disable file icons
              folder = false,       -- Disable folder icons
              folder_arrow = false, -- Disable folder arrows
              git = false,          -- Disable git status icons
            },
          },
        },
      })
    end,
  },
  -- colorschemes
  "folke/tokyonight.nvim",
  "nickkadutskyi/jb.nvim",
  "rebelot/kanagawa.nvim",
  "AlexvZyl/nordic.nvim",
  -- colorschemes
  "vim-scripts/YankRing.vim",
 {
   "jake-stewart/multicursor.nvim",
   branch = "1.0",
   config = function()
     local mc = require("multicursor-nvim")
     mc.setup()

     local set = vim.keymap.set
     -- Add cursor above/below;
     -- Use M-up/down because S-up/down is used for page up/down; Option+Mouse doesn't work, so keymaps are inconsistent
     set({"n", "x"}, "<M-up>", function() mc.lineAddCursor(-1) end)
     set({"n", "x"}, "<M-down>", function() mc.lineAddCursor(1) end)

     -- Skip cursor above/below
     set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
     set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

    -- Add and remove cursors with Shift + left click; Hold Shift + Drag - like double Fn in Intellij
     set("n", "<S-leftmouse>", mc.handleMouse)
     set("n", "<S-leftdrag>", mc.handleMouseDrag)
     set("n", "<S-leftrelease>", mc.handleMouseRelease)

    -- Exit back to multicursors after Insert; Doesn't work with Esc
    set("n", "<C-c>", function() mc.clearCursors() end)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
     mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({"n", "x"}, "<left>", mc.prevCursor)
        layerSet({"n", "x"}, "<right>", mc.nextCursor)
        -- Delete the main cursor.
        layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

        -- Exit multicursor with <C-C>
        -- <Esc> doesn't work, another key shall be pressed to fully exit multicursor, double <Esc> is the fastest way
        layerSet("n", "<C-c>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            else
                mc.clearCursors()
            end
        end)
    end)

   end
 },
 {
   "sphamba/smear-cursor.nvim",
      opts = {
        stiffness = 0.5,
        trailing_stiffness = 0.5,
        matrix_pixel_threshold = 0.5,
      },
 }
})

-- Set leader key to comma
vim.g.mapleader = ","

-- Key mappings for fzf.vim commands; Not added: :Maps, :Commits, :Changes, :Jumps
-- A jump is recorded when you move to a different location via Search, Marks
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>f", ":Files<CR>", opts)    -- All files,
-- :Files & NvimTree: Ctrl+V - vertical split (instead of :vs), Ctrl+X - horizontal split, Ctrl+T - in a new tab;
-- :Files ../ - open dir above
vim.keymap.set("n", "<leader>g", ":GFiles<CR>", opts)   -- Git files
vim.keymap.set("n", "<leader>b", ":Buffers<CR>", opts)  -- Open buffers
vim.keymap.set("n", "<leader>L", ":Lines<CR>", opts)    -- Lines in buffers
vim.keymap.set("n", "<leader>a", ":Rg<CR>", opts)       -- Ripgrep search
vim.keymap.set("n", "<leader>m", ":Marks<CR>", opts)    -- Marks
vim.keymap.set("n", "<leader>q", ":History:<CR>", opts) -- Applied Commands history
vim.keymap.set("n", "<leader>r", ":History<CR>", opts)  -- File edit history

-- EasyMotion mappings
-- vim.keymap.set("n", "<leader>s", "<Plug>(easymotion-bd-f)", opts)               -- <Leader>s{char} to move to {char}
vim.keymap.set("n", "<leader><leader>", "<Plug>(easymotion-overwin-f)", opts)   -- Same but overwin
vim.keymap.set("n", "<leader>s", "<Plug>(easymotion-overwin-f2)", opts)         -- s{char}{char} to move to {char}{char}
vim.keymap.set("n", "<leader>l", "<Plug>(easymotion-bd-jk)", opts)              -- Move to a line
vim.keymap.set("n", "<leader>l", "<Plug>(easymotion-overwin-line)", opts)       -- Same but overwin
vim.keymap.set("n", "<leader>w", "<Plug>(easymotion-bd-w)", opts)               -- Move to a word
vim.keymap.set("n", "<leader>e", "<Plug>(easymotion-bd-e)", opts)               -- Move to the end of a word
vim.keymap.set("n", "<leader>w", "<Plug>(easymotion-overwin-w)", opts)          -- Same but overwin

-- Optional: Configure fzf layout
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

-- YankRing
vim.keymap.set("n", "<leader>y", ":YRShow<CR>", { noremap = true, silent = true })

vim.cmd([[colorscheme jb]]) -- kanagawa, tokyonight-moon, tokyonight-storm

vim.opt.ttimeoutlen = 0 -- process ESC sequences immediately so Option+key combos work in popups in Command mode

-- Make possible navigation with Option+Left Arrow and Option+Right Arrow
-- <Esc>b == Option+Left Arrow; <Esc>f == Option+Right Arrow; https://superuser.com/a/635550
-- Normal mode
vim.keymap.set('n', '<Esc>b', 'b', { noremap = true })
vim.keymap.set('n', '<Esc>f', 'w', { noremap = true })
-- Insert mode
vim.keymap.set('i', '<Esc>b', '<C-o>b', { noremap = true })
vim.keymap.set('i', '<Esc>f', '<C-o>w', { noremap = true })
-- Same for Command mode wildmenu: slash-aware word navigation
vim.keymap.set('c', '<Esc>b', function()
  local line = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos() - 1
  while pos >= 1 and line:sub(pos, pos):match('[%s/]') do pos = pos - 1 end
  while pos >= 1 and not line:sub(pos, pos):match('[%s/]') do pos = pos - 1 end
  vim.fn.setcmdline(line, pos + 1)
end, { noremap = true })
vim.keymap.set('c', '<Esc>f', function()
  local line = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos()
  while pos <= #line and not line:sub(pos, pos):match('[%s/]') do pos = pos + 1 end
  while pos <= #line and line:sub(pos, pos):match('[%s/]') do pos = pos + 1 end
  vim.fn.setcmdline(line, pos)
end, { noremap = true })

-- Up/Down Arrow in Command mode wildmenu: navigate list
vim.keymap.set('c', '<Down>', '<C-N>', { noremap = true })
vim.keymap.set('c', '<Up>', '<C-P>', { noremap = true })
-- Right Arrow in Command mode wildmenu: commit current completion and dive into directory
vim.keymap.set('c', '<Right>', function()
  if vim.fn.wildmenumode() == 1 then
    vim.schedule(function()
      local line = vim.fn.getcmdline():gsub('%s+$', '')
      vim.fn.setcmdline(line)
    end)
    return ' '  -- space commits the wildmenu selection; schedule cleans it up
  end
  return '<Right>'
end, { expr = true, noremap = true })

vim.opt.clipboard = "unnamedplus" -- Use default system clipboard
vim.opt.number = true

-- Tab == 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Clear search highlighting after pressing Enter
vim.api.nvim_set_keymap('n', '<CR>', ':nohlsearch<CR>', { noremap = true, silent = true })

local opts = { noremap = true }

-- C-A & C-E aliases
-- Normal mode
vim.keymap.set('n', '<C-A>', '0', opts)
vim.keymap.set('n', '<C-E>', '$', opts)

-- Insert mode
vim.keymap.set('i', '<C-A>', '<Home>', opts)
vim.keymap.set('i', '<C-E>', '<End>', opts)

-- Visual/Select mode
vim.keymap.set('x', '<C-A>', '<Home>', opts)
vim.keymap.set('x', '<C-E>', '<End>', opts)

-- Command mode
vim.keymap.set('c', '<C-A>', '<Home>', opts)
vim.keymap.set('c', '<C-E>', '<End>', opts)

-- nvim-tree: keymaps
vim.keymap.set("n", "<leader>1", ":NvimTreeToggle<CR>", opts)   -- Toggle nvim-tree display
vim.keymap.set("n", "<leader>2", function()
  require("nvim-tree.api").tree.find_file({ open = true, focus = true, update_root = true })
end, opts) -- Open nvim-tree with current file selected, updating root if needed

-- nvim-tree: directories in blue
vim.api.nvim_set_hl(0, "NvimTreeFolderName",       { fg = "#6aaade" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#6aaade" })
vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName",  { fg = "#6aaade" })

-- Auto open nvim-tree when starting without a file
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 or data.file == "" then
      require("nvim-tree.api").tree.open()
    end
  end
})

-- Highlight yanked text
vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({higroup = 'IncSearch', timeout = 1})
  end,
})

-- Delete word before cursor with Option+Backspace
vim.api.nvim_set_keymap('n', '<A-BS>', 'vb"_d', { noremap = true, silent = true })
-- Delete word after cursor with Option+Fn+Backspace
vim.api.nvim_set_keymap('n', '<A-d>', 'dw', { noremap = true, silent = true })
-- The same in Command mode
vim.api.nvim_set_keymap('c', '<A-BS>', '<C-W>', { noremap = true })
vim.keymap.set('c', '<Esc>d', function()
  local line = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos() - 1  -- 0-indexed cursor position
  local new_pos = pos
  while new_pos < #line and not line:sub(new_pos + 1, new_pos + 1):match('[%s/]') do
    new_pos = new_pos + 1
  end
  while new_pos < #line and line:sub(new_pos + 1, new_pos + 1):match('[%s/]') do
    new_pos = new_pos + 1
  end
  vim.fn.setcmdline(line:sub(1, pos) .. line:sub(new_pos + 1), pos + 1)
end, { noremap = true })

-- Fix Python exception keywords (try/except) highlight errors to use Keyword color
vim.api.nvim_set_hl(0, "pythonException", { link = "Keyword" })
vim.api.nvim_set_hl(0, "pythonInclude", { link = "Keyword" })

-- Map ZQ in normal mode to quit all without saving qa!
vim.keymap.set('n', 'ZQ', ':qa!<CR>', { noremap = true, silent = true })