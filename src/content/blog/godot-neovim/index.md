+++
title = "Neovim as External Editor for Godot"
descriptior = "How to setup and use Neovim as external Editor in Godot, with a few Neovim plugins and customizations."
date = 2025-01-19T09:53:00+00:00
updated = 2025-03-24T09:05:00+00:00
[extra]
mastodon_link = "https://mastodon.social/@dulvui/113854416500491083"
preview_image = "/blog/godot-neovim/treesitter.webp"
+++

Since some months now, I'm happily using Neovim as an **external editor** with Godot Engine 3 and 4.
Godot's internal text editor is fine, but my desire to use Neovim was too big.  

This blog post covers a **minimal setup** to get Neovim working with Godot.
So you can integrate it directly to your existing configuration or use it as a starting point.

Please note that some minimal knowledge about **Linux and Neovim config files** is needed to follow this blog post.

Technically you can also **just use Godot with vanilla Vim/Neovim** with no further changes.
But you might miss some features like **opening files** when clicked in the file explorer or **LSP support**.  

So lets set this up to let Godot add some magic to Neovim.

## Neovim server mode
Before you can set Neovim as external editor in Godot, you need to start Neovim in server mode.
Additionally to that, a **pipe file** is needed, where Godot can send commands to Neovim.  
Add the following code to the [**init.lua**](https://neovim.io/doc/user/lua-guide.html#lua-guide-config) file.
```lua
-- paths to check for project.godot file
local paths_to_check = {'/', '/../'}
local is_godot_project = false
local godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
    if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
        is_godot_project = true
        godot_project_path = cwd .. value
        break
    end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. '/server.pipe')
-- start server, if not already running
if is_godot_project and not is_server_running then
    vim.fn.serverstart(godot_project_path .. '/server.pipe')
end
```
This code iterates over paths_to_check and tries to find a "project.godot" file.
Then it checks if a server is already running.  
I use this approach, because in my projects I separate the code in a "src/" directory.
In my case the project.godot file is located in the parent directory.
Additionally multiple Neovim instances can run, without causing errors or conflicts.  
You can adapt the paths to check to your needs.

Note that now a variable **is_godot_project** exists and allows to check if a Godot project is opened.
This can get very handy to start the Godot LSP client, only for Godot projects or similar Godot specific configuration.
No worries, this will be covered later in this blog post.

## Godot Editor Settings
Now Neovim is ready to be set as external editor in **Editor Settings > Text Editor > External**.  

<img class="blog-image-wide" src="godot-editor-settings.webp" alt="A screenshot of Godot's Editor Settings for external Text Editors">

There you need to set the following values:  
1) Enable **Use External Editor**.  
2) Set **Exec Path** to the Neovim path.
3) Set **Exec Flags** to the following line.

```bash
--server {project}/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
```
This line will make Neovim open the **file** in a buffer and move your cursor to the indicated **line** and **column**.
The **+1** in `cursor({line}+1)` is to go to the correct line.
For some reason without +1, the line above is selected.  
The **{project}** keyword instead stands for the Godot project path.

Now you can use Neovim as external editor in Godot and **open files** with it.

## LSP support
Godot has a built-in [**L**anguage **S**erver **P**rotocol](https://docs.godotengine.org/en/stable/tutorials/editor/external_editor.html#lsp-dap-support),
that gives you features like **code competition**, **error highlights** and **function definition lookups**.

First you need to install the [Neovim LSP plugin](https://github.com/neovim/nvim-lspconfig) and set it up.
I will use [vim-plug](https://github.com/junegunn/vim-plug) as my plugin manager.
```lua
-- Installation
Plug('neovim/nvim-lspconfig')

-- Setup
local lspconfig = require('lspconfig')

-- godot lsp
if is_godot_project then
    -- setup lsp
    lspconfig.gdscript.setup {}
end

```
Now you can access all special features when opening GDScript files.  
You can try code competition with **Ctrl + x** and **Ctrl + o**.
This will suggest also all class names, function names etc in your Godot project.  
With **Ctrl + ]** you can jump to the definition of a function.

There can be **issues** with the LSP, like auto complete giving no results.
In this case you can try **restarting** the LSP plugin with the command **:LspRestart**, or simply restart Neovim.

Keep in mind that the LSP runs within Godot, so you need a running editor instance with your project open.

## Treesitter
To get **better** colored code highlighting, [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) does a perfect job.
This plugin does also a lot of other things, like building a tree structure of your code.
Other plugins might use that tree for better manipulation of your code.  
But I use it only for nicer colors (probably, I'm not sure).

```lua
-- Installation
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- Setup
require'nvim-treesitter.configs'.setup {
    ensure_installed = {'gdscript', 'godot_resource', 'gdshader'},
    highlight = {
        enable = true,
    },
    -- disable auto install of languages when opening files
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
This setup of treesitter includes also some configuration.
The plugins gets **disabled** for files bigger than 100KB, to keep opening Neovim fast.
With **auto_install = false**, new languages don't get installed automatically, when opening a file of the respective language.
Only the languages defined in **ensure_installed** are installed.

Here you can see a side by side comparison of Treesitter **disabled on the left** and **enabled on the right**.

<img class="blog-image-wide" src="treesitter.webp" alt="A screenshot a side by side comparison of Treesitter disabled on the left and enabled on the right in Neovim ">

Neovim already can colorize some of the code, but Treesitter can do it better.


## Debugging
Godot has a built-in [**D**ebug**A**dapter**P**rotocol](https://docs.godotengine.org/en/stable/tutorials/editor/external_editor.html#lsp-dap-support),
so it is directly integrated with Godot, exactly as the LSP.
There are many Neovim Debug plugins out there, if you are already familiar with one, it's worth to check out if it supports Godot.

While writing this blog post, I used to have [nvim-dap](https://github.com/mfussenegger/nvim-dap) installed.
This can attach to Godot's DAP and allow you to set breakpoints or run the game from Neovim.
Then I also tried [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui), that adds the needed UI with variable values etc. to Neovim.
But with this setup, I faced **several crashes** of Godot and a inconsistent workflow.
So I found, in my opinion, and **more stable** and **easier** way to debug.

To be honest, the Godot's debug UI is hard to beat, with the remote tree inspector and all the rest.
Secondly another huge problem for my game: **launching specific scenes**.
I searched the web and haven't found a way to open a specific scene with nvim-dap.  

I often run specific scenes, since my [latest game](@/games/99managers-futsal-edition/index.md) got quite big.
Having to start from the main scene every time, can get quite **frustrating**.  
But you can run specific scenes from the editor, right?
Yes! But somehow Godot get's the breakpoints set with nvim-dap, **only** when started with nvim-dap.

So I had to ask myself: how the f*ck was I debugging the last months??  
And well, the answer is easy, I actually was not using nvim-dap, but the **breakpoint keyword**.  

The following code will print `Hello` and then break and wait.
```gd
func _ready() -> void:
    print("Hello")
    breakpoint
    print("world!")
```
This can have the **disadvantages** that you need to write it, and remember **to remove it**.
No worries, it won't break your game when exported.
This keyword only works, when the project runs inside a Godot editor.  

But the **advantages** are, that this breakpoints are written code, so they are persistent and can be **shared** with other developers or machines.
And there is no need for an additional Neovim plugin.

The best part of all this, I wrote my first **custom** Neovim functions/commands (or however they are called).
Seeing for the first time, why Neovim is so fun and truly hackable.  
```lua
-- define functions only for Godot projects
if is_godot_project then
    -- write breakpoint to new line
    vim.api.nvim_create_user_command('GodotBreakpoint', function()
        vim.cmd('normal! obreakpoint' )
        vim.cmd('write' )
    end, {})
    vim.keymap.set('n', '<leader>b', ':GodotBreakpoint<CR>')

    -- delete all breakpoints in current file
    vim.api.nvim_create_user_command('GodotDeleteBreakpoints', function()
        vim.cmd('g/breakpoint/d')
    end, {})
    vim.keymap.set('n', '<leader>BD', ':GodotDeleteBreakpoints<CR>')

    -- search all breakpoints in project
    vim.api.nvim_create_user_command('GodotFindBreakpoints', function()
        vim.cmd(':grep breakpoint | copen')
    end, {})
    vim.keymap.set('n', '<leader>BF', ':GodotFindBreakpoints<CR>')

    -- append "# TRANSLATORS: " to current line
    vim.api.nvim_create_user_command('GodotTranslators', function(opts)
        vim.cmd('normal! A # TRANSLATORS: ')
    end, {})
end
```

**GodotBreakpoint**  adds the "breakpoint" String below the line the cursor is on, indented correctly.  
**GodotDeleteBreakpoints** deletes all breakpoints lines in the current buffer.  
**GodotFindBreakpoints** finds all breakpoints in the current project.
**GodotTranslators** adds a comment to the end of the line, for
[translation comments](https://docs.godotengine.org/en/latest/tutorials/i18n/localization_using_gettext.html#extracting-localizable-strings-from-gdscript-files).  

Now its possible to write, delete and search breakpoints within Neovim with simple keymaps.

Finally you need to enable also **Debug with External Editor** under the Script view.
If this flag is not set, the internal editor will open while debugging.

<img class="blog-image-wide" src="debug-external-editor.webp" alt="Screenshot of the settings to be enabled for Debug with External Editor">

## Godot documentation
You can read documentation for a function with **Shift + k**, while the cursor is on a function.
If you want to read or search **Godot's full offline** documentation, you can still do that in the Editor with the **Search Help** button.
This will open the documentation in Godot's built-in editor.  
I don't know if it's even possible to open also this files in Neovim, but for me this is totally fine.

## Full Neovim configuration
Here you can find the **full init.lua** file, ready to be hacked and extended.  
You can find my personal full Neovim configuration in my dofiles repo on [Codeberg](https://codeberg.org/dulvui/dotfiles) and [Github](https://github.com/dulvui/dotfiles).
This contains some more plugins, color schemes and configurations.
```lua
-- ----------------------
-- vim-plug plugin-manager
-- ----------------------
local vim = vim
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('neovim/nvim-lspconfig')
vim.call('plug#end')

-- ----------------------
-- lsp
-- ----------------------
local lspconfig = require('lspconfig')
lspconfig.gdscript.setup{}

-- ----------------------
-- treesitter
-- -- ----------------------
require'nvim-treesitter.configs'.setup {
    ensure_installed = {'gdscript', 'godot_resource', 'gdshader'},
    highlight = {
        enable = true,
    },
    -- disable auto install of languages when opening files
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

-- ----------------------
-- Godot debug config
-- ----------------------
-- write breakpoint to new line
vim.api.nvim_create_user_command('GodotBreakpoint', function()
    vim.cmd('normal! obreakpoint' )
    vim.cmd('write' )
end, {})
vim.keymap.set('n', '<leader>b', ':GodotBreakpoint<CR>')

-- delete all breakpoints in current file
vim.api.nvim_create_user_command('GodotDeleteBreakpoints', function()
    vim.cmd('g/breakpoint/d')
end, {})
vim.keymap.set('n', '<leader>BD', ':GodotDeleteBreakpoints<CR>')

-- search all breakpoints in project
vim.api.nvim_create_user_command('GodotFindBreakpoints', function()
    vim.cmd(':grep breakpoint | copen')
end, {})
vim.keymap.set('n', '<leader>BF', ':GodotFindBreakpoints<CR>')
```

## Ignore some files
If you use file explorers plugins you might want to hide some files for Godot projects.
Like the server.pipe file or all *.uid files introduced in Godot 4.4.  
This hides the files in [Nerdtree](https://github.com/preservim/nerdtree).
```lua
if is_godot_project then
    -- ignore *.uid files introduced in godot 4.4
    -- ignore server.pipe file
    vim.cmd('let NERDTreeIgnore = ["\\.uid$", "server.pipe"]')
end
```

And this [Oil](https://github.com/stevearc/oil.nvim).
```lua
-- ----------------------
-- oil
-- ----------------------
require("oil").setup({
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
            -- for godot projects ignore *.uid files
            if is_godot_project then
                -- ignore *.uid files introduced in godot 4.4
                if vim.endswith(name, '.uid') then
                    return true
                end
                -- ignore server.pipe file
                if name == 'server.pipe' then
                    return true
                end
            else
                return false
            end
        end,
    },
})
```
If you use other file explorer plugins, there surely is a way to hide this files too.
Just check the docs or some example configs.

## What I miss in Neovim
So far the biggest feature I miss, is the easy **Ctrl + drag and drop** of a Node into the text editor.
This will automatically create the var with the correct Nodepath.  

After some time I found a much better approach by using **%** and 
[**Access as Unique Name**](https://docs.godotengine.org/en/stable/tutorials/scripting/scene_unique_nodes.html#creation-and-usage).
With this you can access the Node, without having to write the full Node path.
```gd
# This long path
@onready var healt_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/HealthLabel
# simply becomes
@onready var healt_label: Label = %HealthLabel
```
Another crucial advantage is that you can move the Node around the tree, or change parent Nodes, without having to adjust the path.

At the end of the day, being able to use Neovim pays back anyways, if you like it and are keen to keep learning.
Or you already know everything about Vim/Neovim, but let's be honest, **nobody does**.

## Credits
I want to thank [Daniel](https://github.com/DanWlker) for his great suggestions.
Now multiple instances can be used and the server mode only starts, if a Godot project has been found.
