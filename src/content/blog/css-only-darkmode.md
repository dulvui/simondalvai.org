+++
title = "CSS only dark mode"
description = "Create dark mode with CSS only and no JS by using css media queries"
date = 2023-03-19
updated = 2023-03-19
draft = true
aliases = ["cod"]
+++

Last week I implemented dark mode on my website without using any JS and only modern CSS media queries.
It was pretty sure, that dark mode can only be implemented using JS, but a quick online search proved me wrong.


This tiny css one liner can define how your site looks on a device with dark mode set in the browser settings.
```css
@media (prefers-color-scheme: dark)
```
