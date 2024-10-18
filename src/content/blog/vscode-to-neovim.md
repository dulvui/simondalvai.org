+++
title = "From VSCode/VSCodium to Neovim"
description = "Why I switched from VSCode, then to VSCodium and finally to Neovim"
date = 2024-10-18T21:58:00+00:00
updated = 2024-10-18T21:58:00+00:00
[extra]
mastodon_link = "https://mastodon.social/@dulvui/113330672031232401"
hackernews_link = "https://news.ycombinator.com/item?id=41883883"
+++

I was using [VSCode](https://code.visualstudio.com/) and later [VSCodium](https://vscodium.com/) for some years as my editor for everything.
They are **awesome tools** and are getting the job done.
But as you might know, VSCode is built by Microsoft, and has in my opinion **some issues**, 
like [telemetry](https://github.com/VSCodium/vscodium/blob/master/docs/index.md#getting-all-the-telemetry-out),
[proprietary extensions ecosystem](https://github.com/VSCodium/vscodium/blob/master/docs/index.md#extensions--marketplace)
and actually [not being FOSS](https://github.com/VSCodium/vscodium?tab=readme-ov-file#why).  

I think Microsoft did really a great job here and VSCode is a great tool.
They especially started the development of the [Language Server Protocol](https://github.com/microsoft/language-server-protocol), that I use now also in Neovim.  
But in the long term, I feel that a real FOSS editor with an open extension/plugin ecosystem, **is the right choice**.

### Finding an alternative
It is not easy to find something similar to VSCode.  
This are my **minimal requirements**, in ascending order by importance
- FOSS, for real
- Fast opening and editing
- Language Server Protocol support
- Spell checker (since I make errors, a lot)
- No telemetry

Here some editors I tried to replace it
- [KDE's Kate](https://apps.kde.org/kate/)
- [KDE's KWrite](https://apps.kde.org/kwrite/)
- [Gedit](https://help.gnome.org/users/gedit/stable/)
- [Geany](https://www.geany.org/)
- [Micro](https://micro-editor.github.io/)
- [Zed](https://zed.dev/) (after switching to Neovim)

All without success.
They are all great editors, but I simply had the feeling, that it was time to **really** try Vim.

### It all started with ~a big bang~ Vim
So I chose [Vim](https://www.vim.org/) as my new text editor.
I could immediately feel the **advantage** of sticking to the keyboard as much as possible.
Everything is a **few keystrokes away** and is really fun.

After getting used to vim basics and motions, I wanted to give [Neovim](https://neovim.io/) a try.  
But lets check if my requirements fit Neovim.  

**FOSS, for real**  
Neovim is [Apache 2.0](https://github.com/neovim/neovim/blob/master/LICENSE.txt), and is based on Vim, with it's own [Vim License](https://github.com/vim/vim/blob/master/LICENSE)  
**Fast opening and editing**  
Opens instantly, even for big files  
**Language Server Protocol support**  
Full [LSP support](https://neovim.io/doc/user/lsp.html)  
**Spell checker (since I make errors, a lot)**  
The simple command `:set spell` does the magic, already built-in!  
**No telemetry**  
Or maybe [there is](https://github.com/neovim/neovim/pull/17957)??  

## Getting the latest version on Debian
My current OS of choice is Debian 12 bookworm.
Debian bookworm, at the time of writing, has Neovim version 0.7.2.
You can check the current version in Debian stable [here](https://packages.debian.org/bookworm/neovim).  
This version is not compatible with latest package managers and plugins.
Most of them work with 0.9.5 upwards.  
So I needed to get the latest Neovim from elsewhere...

### AppImage
First I tried Neovim's official AppImage, you can find on [Github](https://github.com/neovim/neovim/releases).
It was a good first start and an easy way to try the latest version on Debian.  

### Building from source
But after seeing ThePrimeagen building Neovim from source on [YouTube](https://youtu.be/ZWWxwwUsPNw?feature=shared&t=191),
I also wanted to do that, to have a proper .deb package and drop the AppImage.

It was actually **my first time**, that I built a program from source and installed in on my machine.
That makes it a lot easier to contribute back to a project!
But well, for now I'm happy with my home built Neovim deb file.

Here a quick guide on how to build it by yourself.  

**Requirements**
```bash
# first, install build deps
apt install -y ninja-build gettext cmake unzip curl build-essential

# clone neovim's repo
git clone https://github.com/neovim/neovim
cd neovim
```

**Build and install**
```bash
# check out stable tag, or specific version you prefer
git checkout stable
# build neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB

# install it, as root
dpkg -i nvim-linux64.deb
```

**Update**
```bash
# switch back to master
git checkout master
git pull
git fetch --all
# check out stable tag, or specific version you prefer
git checkout stable
```

After getting the updates, you can **build and install** again.

## Package manager(s)
There are so many package managers and Neovim distributions, that it can be **overwhelming**.
I think everybody needs to explore this jungle **on it's own**, get hands dirty and find what fits the most.  

Many recommend starting from [kickstart](https://github.com/nvim-lua/kickstart.nvim), and maybe I also should have done that too.
After days of restarting from scratch, trying this and trying that, I sticked with [vim-plug](https://github.com/junegunn/vim-plug) for now.

## Plugins
After thinking that Neovim has tons of package managers, I haven't yet seen the huge number of plugins.
Multiple plugins that solve the same issue, just maybe written in Lua or with fancy icons.
Many times there is no right or wrong, old or new.
My recommendation is **listen to your gut, and don't overthink it**.

I saw many videos and articles on the web, where users had at least 50 plugins installed.
There are even benchmarks the opening of Neovim in **milliseconds** where 40ms is the usual "fast enough" value.
Since I'm still in my early Neovim days, I have around 20 plugins installed.
But surely more are coming, and my first benchmark waits behind the corner.

But there is also the thing, that plugins **might break** during updates etc...
I haven't encountered that yet, but I guess, **less plugins is better** in that sense.

## Configure with init.lua
You can adapt Neovim as you prefer with all the plugins available.
Or even write some own scripts in Lua.  

But first you need a init.lua file.
```bash
mdir -p .config/nvim
touch .config/nvim/init.lua
```
Now you can watch hours of videos and read articles and books about vim.
The grind will never stop, unless you finally admit that you are wasting to much time in configuring your editor.
At some point you simply have to accept that **it's good enough**.

You can find my current Neovim configuration file on [Codeberg](https://codeberg.org/dulvui/dotfiles) or [Github](https://github.com/dulvui/dotfiles).

## Look Ma, no mouse
Now that I'm keyboard addicted, I also started using shortcuts whenever I can.  

I use [sway](https://swaywm.org/), as my **tiling window manager** on Debian.
With a few keystrokes you can switch workspaces, open terminals and align windows at the speed of typing.
And everything is a **configuration file**, like in Neovim.
So the next time you re-install your OS, you just need to get the file and get back where you left off.
If something breaks or you don't like some changes, simply `git revert` everything.

I also started to use [Firefox shortcuts](https://support.mozilla.org/en-US/kb/keyboard-shortcuts-perform-firefox-tasks-quickly),
like open a new tab with **ctrl+t**, close it with **ctrl+w** or cycle trough tabs with **ctrl+pgup** and **ctrl+pgdn**.
Then there is **F6** to focus the address bar or **ctrl+shift+p** for private browsing.  
I even tried [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/), a Vim Firefox extension to get vim navigation.
But there I drew the line and went back to endless scrolling, with the mouse...  

As you can see, Neovim is not just an editor, it is a **life style**.
