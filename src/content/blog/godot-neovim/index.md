+++
title = "Godot with Neovim"
descriptior = "How to setup and use Neovim as external Editor in Godot"
date = 2025-01-15T17:26:00+00:00
updated = 2025-01-15T17:26:00+00:00
draft = true
[extra]
mastodon_link = ""
hackernews_link = ""
preview_image = "/blog/godot-neovim/godot-neovim.webp"
+++

Since some months now I'm happily using Neovim as an **external editor** with Godot Engine 3 and 4.
Godot's internal text editor is fine, but my desire to really learn Neovim was too big.  
There actually exists even an [Vim plugin](https://github.com/joshnajera/godot-vim) for Godot, that brings basic motions to the built-in text editor.
But I simply want to use the real thing.

Please note that some minimal knowledge about **Linux and Neovim config files** is needed to be able follow this blog post.

## Minimal Neovim setup
Before we can set Neovim as external editor in Godot, some configuration is needed first.  
Note: You can find my full Neovim configuration in my dofiles repo on [Codeberg](https://codeberg.org/dulvui/dotfiles) and [Github](https://github.com/dulvui/dotfiles)

Technically you can also just use Godot with Neovim with no further changes.
But then you might miss some features like opening the file in Neovim when clicking on a script in the file explorer or lsp support.
So lets set up the minimal configuration to let Godot interact with Neovim.

A server pipe file is needed for Godot to send commands to Neovim.
So lets first create the nvim cache directory, where the file will be located.
```bash
mkdir -p ~/.cache/nvim
```

Now we can create the server pipe file in out `init.lua` file.
This will create the file and start Neovim in server mode, so it can handle calls from external tools.
```lua
local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end
```

## Setup Godot
Now you can set Neovim as external editor in **Editor Settings > Text Editor > External**.  
There you need to set the following values, as in the screenshot below.

<img class="blog-image-wide" src="godot-editor-settings.webp" alt="A screenshot of Godot's Editor Settings for external Text Editors">

Enable *Use External Editor*  
Set *Exec Path* to the path Neovim is located (on Linux you can find the path with `which nvim`)  
Set *Exec Flags* to the following line, by replacing **YOUR_USER** with your actual username
```bash
--server /home/YOUR_USER/.cache/nvim/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
```
Note: The `+1` in `cursor({line}+1)` is to go to the real line, for some reason without +1 the line above is selected.

Now you can use Neovim as external editor in Godot 3 and 4!  

## LSP support
Godot has a built-in [**L**anguage **S**erver **P**rotocol](https://docs.godotengine.org/en/stable/tutorials/editor/external_editor.html#lsp-dap-support)
that gives you features like **code competition**, **error highlights** and **function lookups**.
I highly recommend enabling this too, so you don't miss this nice features.

First we need to install the [Neovim lsp plugin](https://github.com/neovim/nvim-lspconfig) and set it up.
```lua
-- Installation
local vim = vim
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('neovim/nvim-lspconfig')
vim.call('plug#end')

-- The actual setup
local lspconfig = require('lspconfig')
lspconfig.gdscript.setup{}
```
Now you can access all special features 

I faced sometime some issues with the LSP, like not being able to look up functions or auto complete.
In this case you can try restarting the LSP plugin with the command `:LspRestart`, or simply restart Neovim.

## Treesitter



## Godot documentation
You can read documentation for a function with **Shift + k** while the Neovim cursor is on a function in normal mode.
If you want to read or search **Godot's full offline** documentation, you can still do that in the Editor with the **Search Help** button.
This will open the documentation in Godot's built-in text Editor.  
I don't know if it's even possible to open also this files in Neovim, but for me this is totally fine.

## What I miss in Neovim
So far the biggest feature I miss, is the easy drag and drop of a Node into the text editor.
This will automatically create the var with the correct Nodepath.
But after some time I found a much better approach by using **%** and **Access as Unique Name**.
With this you can access the Node without having to write the full Node path.
Another crucial advantage is that you can move the Node around the tree, without having to adjust the path in the code.

Then there is of course the not so nice debugging experience I currently have.

Aside of this two issues, I really love this setup and could not imagine going back to use the built-in Text Editor.

## Sum up

Plugins used
- For LSP support - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- For nicer color highlights - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- For Debug support - [nvim-dap](https://github.com/mfussenegger/nvim-dap)

Godot settings changed
- Enable external editor
- Allow debug with external editor

