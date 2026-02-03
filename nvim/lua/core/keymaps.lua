vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.keymap.set

set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("t", "<Esc>", "<C-\\><C-n>")

set("t", "<C-q>", "<cmd>quit<CR>")

set("i", "<C-c>", "<Esc>")

set("n", "<leader>fe", "<ESC><cmd>Dired<CR>")

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("x", "<leader>p", '"_dP')

set("n", "<leader>d", '"_d')
set("v", "<leader>d", '"_d')

set("n", "<leader>t", "<cmd>ToggleTerm<CR>")

set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

set("n", "<leader>ep", "i<?php  ?><C-c>2hi")

set("n", "<leader>h", "<cmd>e #<CR>")
set("n", "<leader>H", "<cmd>vsplit | e #<CR>")

set("n", "<leader>q", "<cmd>quit<CR>")

set("n", "<leader>c", "<cmd>Compile<CR>")
set("n", "<leader>!", "<cmd>Recompile<CR>")
set("n", "<leader>n", "<cmd>NextError<CR>")
