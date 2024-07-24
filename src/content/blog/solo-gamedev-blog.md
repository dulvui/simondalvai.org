+++
title = "Personal blog, as a solo game dev?"
description = "Why you should have a personal website and blog as a solo game developer."
date = 2024-07-24T21:30:00+00:00
updated = 2023-07-24T21:30:00+00:00
[extra]
mastodon_link = "https://mastodon.social/@dulvui/112843615277807687"
hackernews_link = "https://news.ycombinator.com/item?id=41062417"
+++

Yes, it is worth it, **if you like writing** (or nowadays, prefer to let some fancy VC backed LLM service do the writing).
No worries, my blog posts are still written by crystallizing words out of my by brain.
All (grammar and syntax errors) inclusive.    
If you don't like writing at all, I still recommend having a simple personal webpage with at least the list of your created games. 
It is also great to host privacy policies for your games, that is mandatory for Google Play Store and Apple App Store.

I started with game development as a hobby around 2018 and created some games.
Since the end of 2022, I also have this personal website with a blog, where I post monthly something about game dev or other things I find interesting.

Here I share my experience on having a personal blog as a solo game developer.

## Hosting: Github Pages vs Self hosting
The first year I hosted my website on Github Pages.
It is completely free and gives you a great starting point for your personal webpage.
It works pretty well and within minutes, you can have a website with the url [your username].github.io online.
If you want to use a custom domain, this is also quite easy, but may vary between domain service provider.
So I won't go into detail on this topic.

Since January 2024, I'm hosting my website on a shared cloud server on Hetzner running  [Caddy](https://caddyserver.com) on [Debian](https://debian.org).
That costs me around 5€/month for now, but gives me **more control and insights** over my website.
By self hosting, I can see the access logs on the server, to get a rough overview on how many users and bots (there are a lot crawlers out there) are visiting.
Then I can also use some features like caching or URL redirects, that Github Pages doesn't provide.

I also don't really know how and if Github (and Microsoft) are using the traffic on Github Pages to **track users** and process/sell the data.
I would guess, yes they to, since nothing comes for free if it is provided by a big tech company.
So if you care about privacy, self hosting might be the better choice.

My recommendation is to use Github Pages or similar to get started, if you have no experience with self hosting.
Then slowly start playing around with some servers, when you start getting bored with your setup :-)

## Visibility
This blog has increased the visibility of my website and games a lot.
I guess **90% traffic** of my website, comes from my blog post.
I can't give exact numbers, because I not using any user tracking and analytic tools on my websites and games.
But there are some tools that still can give you a rough number, on how many users you reach.
It is also really helpful to see which blog posts or games attract the most users, organically.
Every user that reads your blog post is a potential player of your games.
From reading a blog post, to downloading a game might be only 2 more clicks.

You can then further increase the visibility of your content by posting on other websites.
I normally post them on [hackernews](https://news.ycombinator.com/), mastodon and sometimes on [reddit](https://reddit.com).
It is incredible how much traffic you can get, once something got up voted a lot.

As an example: the most views I got on [itch.io](https://simondalvai.itch.io/) was, when I landed on the front page of hackernews for some hours with this [blog post](https://news.ycombinator.com/item?id=36466698).

## Building an audience
Some people will read and like your blog posts and games.
If you have an RSS feed or post on social networks, you might even have people that reads your content immediately, when it is released.
I currently have a really small audience, but I'm pretty sure this is how it works for successful people :-) 

## Market share discovery
By having a website of your game and Google Search Console enabled, you can see if people search for your game already.
This can be really motivating, if your game's website gets views, even before it is released.
This actually happens right now for my game [Futsal Manager](https://simondalvai.org/games/futsal-manager/).
I get daily visits and occasionally e-mails because of it, and I haven't released the game yet.

So this means that once I release the game, I already know that some people will search for in and find it.
All organically and for free.

## Tracking
I don't use any user tracking tool in my games or website.
This makes makes it hard to understand, what content users like, and what not.
But there are still some **tools and tricks** out there, to get a rough estimate.
I currently use the Google Search console and get some data from the caddy web-server logs.

### Google Search Console
You can get a good search engine performance overview using the [Google Search Console](https://search.google.com/search-console).
For that you just need a Google Account and verify ownership of the websites you want to "track".
Google will give you some data on how many users have seen you page in their results, clicked on it and what the keywords where.

Even more interesting to me is the list of websites that **link back** to you website.
Here you might find that your blog post has been shared on some social network or cited in some article.

Here of course you'll see only data from people using the Google Search.
But they still have a huge market share in the web search world.
I would guess by adding 10% to the number you see in the Google Search Console, should make the real value.

### Caddy logs
I use [go-access](https://goaccess.io/) to analyze the caddy logs.
It works well in the terminal or browser, is really fast and supports a vast variety of log formats.
I tried to setup a nice looking Grafana dashboard, but as it didn't worked as expected, I felt that the effort is not worth it.

## Don't forget about your games
So having a personal blog will help you a lot to promote your games and to get visibility.
But I have spent a lot of time creating this website and writing all the blog posts.
Maybe too much, maybe not, who knows.
Sure is, every minute I spend here, I don't work on my games.

So my most important advice is: don't get too much distracted by other shiny things and **build great games!**
