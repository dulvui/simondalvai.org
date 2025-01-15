+++
title = "Neovim as External Editor for Godot"
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

This blog post covers a minimal setup to get Neovim working with Godot.
So you can integrate it directly to you existing configuration or later extend it.

Please note that some minimal knowledge about **Linux and Neovim config files** is needed to be able follow this blog post.

## Minimal Neovim setup
Before we can set Neovim as external editor in Godot, some configuration is needed first.  
Note: You can find my full Neovim configuration in my dofiles repo on [Codeberg](https://codeberg.org/dulvui/dotfiles) and [Github](https://github.com/dulvui/dotfiles).
This contains some more plugins and other configurations too.

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
Note: The **+1** in `cursor({line}+1)` is to go to the correct line.
For some reason without +1, the line above is selected.

Now you can use Neovim as external editor in Godot 3 and 4!  
This is the **most minimal** setup needed to use it as external editor.
The next steps will extend it to add more features.

## LSP support
Godot has a built-in [**L**anguage **S**erver **P**rotocol](https://docs.godotengine.org/en/stable/tutorials/editor/external_editor.html#lsp-dap-support)
that gives you features like **code competition**, **error highlights** and **function lookups**.
I highly recommend enabling this too, so you don't miss this nice features.

First we need to install the [Neovim lsp plugin](https://github.com/neovim/nvim-lspconfig) and set it up.
```lua
-- Installation
Plug('neovim/nvim-lspconfig')

-- Setup
local lspconfig = require('lspconfig')
lspconfig.gdscript.setup{}
```
Now you can access all special features 

I faced sometime some issues with the LSP, like not being able to look up functions or auto complete.
In this case you can try restarting the LSP plugin with the command `:LspRestart`, or simply restart Neovim.

## Treesitter
To get colored code highlighting, [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) does a perfect job.
This plugin does also a lot of other things, like building a tree structure of your code.
Other plugins and Neovim might use that tree for better manipulation of your code.
```lua
-- Installation
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- Setup
require'nvim-treesitter.configs'.setup {
    ensure_installed = {'gdscript', 'godot_resource', 'gdshader'},
    highlight = {
        enable = true,
    },
    auto_install = false,
    -- disable for files bigger than 100 KB
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
}
```

Here you can see a side by side comparison of Treesitter **disabled on the left** and **enabled on the right**.

<img class="blog-image-wide" src="treesitter.webp" alt="A screenshot a side by side comparison of Treesitter disabled on the left and enabled on the right in Neovim ">

Neovim already can colorize some of the code, but Treesitter can do more.


## Debugging
Godot has a built-in [**D**ebug**A**dapter**P**rotocol](https://docs.godotengine.org/en/stable/tutorials/editor/external_editor.html#lsp-dap-support),
so it is directly integrated with Godot and you can still use Godot's inspector.
There are many Neovim Debug plugins out there, if you are already familiar with one, it's worth to check out if it support Godot.

Here I will use [nvim-dap](https://github.com/mfussenegger/nvim-dap).
```lua
-- Installation
Plug('mfussenegger/nvim-dap')

-- Setup
local dap = require('dap')
-- Maps Fn-Keys to the same Godot uses
vim.keymap.set('n', '<F12>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F9>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

-- Adjust to the port in your Editor settings
dap.adapters.godot = {
  type = 'server',
  host = '127.0.0.1',
  port = 6006, -- for Godot 3 the default port is 6005
}

-- To script scene files
dap.configurations.gdscript = {
  {
    type = 'godot',
    request = 'launch',
    name = 'Launch scene',
    program = '${workspaceFolder}',
  },
}

-- To launch scene files
dap.configurations.gdresource = {
  {
    type = "godot",
    request = "launch",
    name = "Launch current scene",
    scene = "pinned",
    project = "${workspaceFolder}",
  }
}
```


If this doesn't work, or you prefer to use no more plugins, you can also set **breakpoints** by simply writing breakpoint in the code. 
So the following example code will first print `Hello` and the stop.
```gdscript
func _ready() -> void:
	print("Hello")
    breakpoint
	print("world!")
```
This has the **disadvantages** that you need to write it, and remember **to remove it**.  
One **advantage** is that this breakpoints are in the code, so they are saved and can be **shared with others**.

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

