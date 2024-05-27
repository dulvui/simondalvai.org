+++
title = "Godot static types"
description = "How and why use static types in Godot."
date = 2024-05-26
updated = 2024-05-26
draft = true
[extra]
mastodon_link = ""
hackernews_link = ""
+++

GDScript is a dynamic typed language, but you can add type hints, that make it static typed.


## Typing system
Here some examples:  

```gd
# dynamic
var a = hello
# automatic type guess
var b := "hello"
# static typing
var c: String = "hello" 
```

It is highly recommended to use one typing system across your project.
I suggest to always use static typing, even for small projects.
This can help to **prevent errors** before even the game runs.
With dynamic typing, you could have a bug in your code, and only see it, when that code gets executed.
Static typing and the use of class_name will make bigger projects much safer.

## Project settings to have stricter error checks
In project settings under **Debug** -> **GDScript** you can change how the editor handles different warnings as errors and vice versa.
Changing here some warnings to errors can be game changing and really important to bring real static typing advantages.

Here the setup I'm currently using:  
<img class="blog-image blog-image-wide" src="gdscript-debug-settings.webp" alt="Changed warnings to errors in Project settings">  

## Magic keyword class_name
Another good habit is to use **class_name** in your custom Nodes as much as possible.
With static typing and class_name you can get auto complete for functions and variables.
The debug settings enable even error messages, if you have wrong parameters, or try to assign a wrong type.


## Real world examples

Here an example, where you would not see an error when assigning a wrong value
```gdscript

```

Here an example, where you would not see an error when assigning a wrong value
```gdscript

```

Here the same, but with class_name, static typing and enabled error settings, you'll get an error already in the editor
```gdscript

```
