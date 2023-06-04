+++
title = "CSS only dark mode"
description = "Create dark mode with CSS only and no JS by using css media queries"
date = 2023-03-19
updated = 2023-03-20
aliases = ["cod"]
[extra]
mastodon_link = "https://mastodon.social/@dulvui/110486078968483198"
+++

Last week I implemented dark mode on my website, without using any JS and only modern CSS media queries.  
It was pretty sure, that dark mode can only be implemented using JS, but a quick online search proved me wrong.

## Lets make it dark
This css one liner can define how your site looks on a device with dark mode set in the browser settings.
```css
@media (prefers-color-scheme: dark)
```

Or if your main style is dark mode, you can define how the light mode will look.
```css
@media (prefers-color-scheme: light)
```

And with this little scss and media query you can set dynamically the background and font color of the whole body of your html.  
```scss
$background-color-light: #FDF6E3;
$background-color-dark: #002b36;
$font-color-light: $background-color-dark;
$font-color-dark: $background-color-light;

body {
    background-color: $background-color-light;
    color: $font-color-light;

    @media (prefers-color-scheme: dark) {
        background-color: $background-color-dark;
        color: $font-color-dark;
    }
}
```

Of course, you can't switch between dark mode and light mode with a button (or at least I don't know, how to do that) like you could do with JS.
But anyway I can't remember the last time I used a button like that and websites should follow directly the system settings.

## How to test it
To test it, you can simply switch the color theme of your browser in the settings and voilà: the site changes automatically colors.  
For this website I used the [solarized](https://ethanschoonover.com/solarized/) theme.
It is my favorite theme and I use the solarized light theme everywhere I can.  


So here, the internet proved me again, that a simple website can have a lot of cool features, without using JS at all.