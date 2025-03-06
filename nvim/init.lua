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
  "easymotion/vim-easymotion",                      -- EasyMotion plugin
  { "nvim-tree/nvim-tree.lua",                      -- nvim-tree plugin
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30, -- Default width of the tree
        },
        renderer = {
          icons = {
            show = {
              file = false,        -- Disable file icons
              folder = false,      -- Disable folder icons
              folder_arrow = false, -- Disable folder arrows
              git = false,         -- Disable git status icons
            },
          },
        },
      })
    end,
  },
  "nvim-tree/nvim-web-devicons",
  "folke/tokyonight.nvim",
  "rebelot/kanagawa.nvim",
  "vim-scripts/YankRing.vim"
})

-- Set leader key to comma
vim.g.mapleader = ","

-- Key mappings for fzf.vim commands
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>f", ":Files<CR>", opts)    -- All files
vim.keymap.set("n", "<leader>g", ":GFiles<CR>", opts)   -- Git files
vim.keymap.set("n", "<leader>b", ":Buffers<CR>", opts)  -- Open buffers
vim.keymap.set("n", "<leader>L", ":Lines<CR>", opts)    -- Lines in buffers
vim.keymap.set("n", "<leader>a", ":Rg<CR>", opts)       -- Ripgrep search
vim.keymap.set("n", "<leader>m", ":Marks<CR>", opts)    -- Marks
vim.keymap.set("n", "<leader>e", ":History:<CR>", opts) -- Command history
vim.keymap.set("n", "<leader>r", ":History<CR>", opts)  -- File edit history

-- EasyMotion mappings
vim.keymap.set("n", "<leader>s", "<Plug>(easymotion-bd-f)", opts)        -- <Leader>f{char} to move to {char}
vim.keymap.set("n", "<leader>s", "<Plug>(easymotion-overwin-f)", opts)   -- Same but overwin
vim.keymap.set("n", "<leader><leader>s", "<Plug>(easymotion-overwin-f2)", opts) -- s{char}{char} to move to {char}{char}
vim.keymap.set("n", "<leader>l", "<Plug>(easymotion-bd-jk)", opts)       -- Move to line
vim.keymap.set("n", "<leader>l", "<Plug>(easymotion-overwin-line)", opts) -- Same but overwin
vim.keymap.set("n", "<leader>w", "<Plug>(easymotion-bd-w)", opts)        -- Move to word
vim.keymap.set("n", "<leader>w", "<Plug>(easymotion-overwin-w)", opts)   -- Same but overwin

-- nvim-tree mappings (migrated from NERDTree)
vim.keymap.set("n", "<leader>1", ":NvimTreeToggle<CR>", opts)  -- Toggle nvim-tree display
vim.keymap.set("n", "<leader>2", ":NvimTreeFindFile<CR>", opts) -- Open nvim-tree with current file selected

-- Optional: Configure fzf layout
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

-- Configure nvim-web-devicons (kept but not necessary without icons)
require("nvim-web-devicons").setup({
  default = true,
})

-- YankRing
vim.keymap.set("n", "<leader>y", ":YRShow<CR>", { noremap = true, silent = true })

vim.cmd([[colorscheme tokyonight-night]]) -- kanagawa, tokyonight-moon, tokyonight-storm
