+++
title = "[Talk] Making FOSS games for fun and (hopefully) profit"
descriptior = "The content of my talk for the monthly Developers Thursday at the NOI Techpark about FOSS game development"
date = 2025-04-03T08:15:00+00:00
updated = 2025-05-15T07:02:00+00:00
aliases = ["dt25"]
[extra]
mastodon_link = "https://mastodon.social/@dulvui/114386121698522017"
preview_image = "/blog/make-foss-games/talk.webp"
+++

This is the complete blog post to my talk at the
[Software Developer's Thursday](https://noi.bz.it/en/events/software-developer-s-thursday/4e8d5838-d3e6-4a08-819c-38016cc8f9c7).  
It is not a word to word transcript,
but should cover most I said during the talk with some additional notes.  

A video will be uploaded to YouTube a few days after the talk and the link will be added here.
But I accidentally used the wrong microphone while recording the talk, so the video has horrible sound and is not ready yet.
I hope to solve the audio issues soon and add the link here.

Anyway, let's **make some FOSS games!**

## About me
Before starting, I want to make clear that **I'm not a professional** game developer (yet).
I haven't made any income with my games and haven't worked as game developer yet.
So everything I write here is based on my personal experience as a hobby game developer, with some additional stuff I read on the web.

Everything started with **childhood dreams** since I saw the [Nintendo Game Boy](https://en.wikipedia.org/wiki/Game_Boy)
for the first time.
Seeing the infinite possibilities of creating imaginary worlds blew my mind and is fascinating me until to this day.  
This experience created the desire to become a game developer.

I learned programming in high-school and worked afterwards as a software developer (as employee and freelance) since **2016**.  
In **2017** I started creating my first games with [libGDX](https://libgdx.com/) in my free time.
In the following **3 years** I created some mobile games.
- [ColorShooter](@/games/color-shooter/index.md)
- [Sn4ke](@/games/sn4ke/index.md)
- [WhatColor](@/games/whatcolor/index.md)

They where my first attempt to create the next [Flappy bird](https://en.wikipedia.org/wiki/Flappy_Bird) and become rich and famous.
Of course without success.
But it still didn't kill my desire and joy to create games.

In **2020** I tried the [Godot Engine](https://godotengine.org/) and started making games just for fun.
I created the following **2 games** available for mobile, on the web and as flatpaks.
- [Pocket Broomball](@/games/pocket-broomball/index.md)
- [Ball2Box](@/games/ball2box/index.md)

I still tried to make some dollars with ads, but quickly realized that it doesn't work.
So I removed all ads and tracking from my games and open sourced all of them, using a copyleft license.

Since September **2024** I'm working full time on my **first FOSS commercial game**
[99 Managers Futsal Edition](@/games/99managers-futsal-edition/index.md) (still in beta).  
I started this game right after Ball2Box in 2021, but I was not able to see how I can finish this game just in my free time.
The decision to quit my job and go all in was not easy, but if not now, when can I work on my childhood dreams?

The plan is to sell the game on Steam and release it on other platforms like itch.io and Flathub for free.
I really care about free and open source software, and I hope also other people do and see that the game industry needs more of it.

## Problems with most games
Modern games have in my opinion quite some serious problems, that would not exist in FOSS games.
Most players are **children** and they are exposed to malicious practices, mostly for profits.

**Ads and user tracking** bring all the privacy issues to the (mostly mobile) gaming world.
Even without consent, apps can track gamers and sell the data to brokers, as showed in this
[article](https://timsh.org/tracking-myself-down-through-in-app-ads/).

**Micro-transactions and loot boxes** are the next big issue.
Loot boxes are illegal in Belgium and many other countries demand higher age rating, real money disclosure, probability disclosure etc...
This [EU press release](https://ec.europa.eu/commission/presscorner/detail/en/ip_25_831)
about **protecting children from harmful practices** shows,
how games are designed to attract and mislead children to spend (lots of) money on games.

And then there are the famous **freemium game**, where tiny fraction of players pay insane amounts of money.
The South Park episode [Freemium Isn't Free](https://www.southparkstudios.com/episodes/jy5lbq/south-park-freemium-isn-t-free-season-18-ep-6)
explains very well how this works.
You can skip forward to 15:12 for the interesting part, but I recommend watching the full episode.

**Down the rabbit hole it can get alarming.**
There are even more malicious practices in games, like the German satire show Neo Magazin Royale showed in the episode
[Coin Master - Abzocke mit Fun](https://www.youtube.com/watch?v=hTeTjx4k9jQ) (in German, auto subs available).
You can read about it also on [Wikipedia](https://en.wikipedia.org/wiki/Coin_Master#Criticism).  
Long story short, it's slot machine masquerading as a game that targets children.
They did also a research on who financed the game studio Moon Active, the studio that created Coin Master,
and found that the main investors come from [the gambling industry](https://youtu.be/hTeTjx4k9jQ?t=644).  
So they are showing children how slot machines work, make them addicted and create the **gamblers of tomorrow**.

Of course not **all games** using ads, micro-transactions or similar are pure evil, but many of them are.

## Game development job market
Since I showed you the bad part of the gaming industry, let's continue with bad news.
Here I want to justify again that I'm not a professional game developer yet,
and **my knowledge is mostly based on what I see on the web**.

Game developers get a **lower pay** than rest of the software industry.

They also have more **working hours** aka crunch time, because there are tough deadlines.

Working in the games industry is also **seen as a privilege**.
So many studios exploit childhood dreams, like mine and get people to work more for less.
Because well, you are working your dream job!

**No jobs in South Tyrol** (the region in Italy I live) and in other locations outside big cities.
I could easily find a job as a common software developer here, but the next game studio is more than 150km away.

**Finding remote jobs really difficult** and most studios want people in the office.
There are lots of NDAs that need to be signed, for example to use proprietary SDKs for consoles.
So studios prefer to keep everything in the office, to prevent leaks and other issues.

## Why FOSS games
So now let's see how FOSS games can partially solve this problems.

The **Kiwi Free Software CD** was the very first free software I got in elementary school.
It was created by the province of Bolzano for schools to give them access to free (as in free speech and free beer) software.
There is an article in German, Italian and Ladin about the CD on the [province's website](https://news.provinz.bz.it/de/news-archive/207075).  
I really enjoyed playing Supertux or becoming a deejay with Audacity.
At the time I didn't know what FOSS is and why it is important, but it surely shaped my path as a software developer.  
Said that, I'm convinced that also FOSS games can have this effect and shape the **FOSS developer of the future**.

**Get quality feedback**, as this happy reddit user showed in his
[post](https://old.reddit.com/r/gamedev/comments/qeqn3b/despite_having_just_58_sales_over_38_of_bug/).
His game was not FOSS, but by simply releasing the game also for GNU/Linux was a success.
His GNU/Linux users produced 650% more high quality bug reports.
Also in my experience I saw that once developers discover your game, through F-Droid or Flathub, much more issues get created.

**Get contributions** to your game with bug fixes, features and non code parts like translations.
It might be difficult to get code contributions, as many FOSS projects struggle to get contributors.
But in my case I already got my games translated in many other languages, by being FOSS.

**Get free access** to paid tools like [Weblate](https://hosted.weblate.org/projects/99-managers-futsal-edition/game/),
I'm currently using for translations.
Weblate gives free hosting to FOSS projects and I want to thank them here once again, for their generous offer!

**Give free access** to the game, to give something back to the community.
But also to give access to people who can't afford games.
In some countries the monthly average wage is less than what most games costs nowadays.
So this people can't play games or need go pirate them.
Being FOSS gives free and safe access to everybody.

**All problems** magically disappear, because if someone does nasty things with FOSS, the project will get forked.

## Game engines
Now that I convinced you that your next game will be FOSS ;-), let's talk about game engines.

It is important to choose the right tool for the development of your game, even if it will be proprietary.  
In 2024 **Unity** wanted to introduce a **0.20 cent runtime fee**, for every installation of a Unity game.
After strong critics by the community, Unity canceled the fee.
But many developers understood what it means to be **dependent on a closed project**.
Something like that would never happen with a
(real, no [CLA](https://en.wikipedia.org/wiki/Contributor_License_Agreement))
open source project.

**The list of game engines** on [Wikipedia](https://en.wikipedia.org/wiki/List_of_game_engines)
has a lot of open source projects that can fit your needs.
Another great website I just found recently is [enginesdatabas.com](https://enginesdatabase.com/),
where you can find many possible engines with great filters.

In my opinion, there are **two main categories**: libraries/frameworks and full engines.
Like [libGDX](https://libgdx.com/) and [Godot Engine](https://godotengine.org/) I already used.  
**LibGDX** is a Java library that helps you to create a game, but you need to code everything.
It brings a physics engine, so you don't need to code that, but you still need to care about low level stuff like memory management.
And to create UIs you have to code every button's size and position, without fancy visual editor.
But you are free to implement the games as you want on a architectural design level.
So it gives you more power and freedom, at the cost of having to code parts that are already solved in full engines.  
**Godot** on the other hand brings you a full engine with visual editor and lot's of other features.
You can create games much faster and really focus on creating the game, without having to care about low level stuff.
But you are limited to Godot's design decisions of using Node based scenes with events/signals.

So if you want to learn more about what happens under the hood and have more control over your game, use a library of framework.
If you want to focus on the game and be fast, choose a full engine.
But never forget, the most important part is **making a fun game**, it doesn't matter what technologies are used.

## Free (as in free speech) assets
Most games are not made by just code, but also use audio and visual assets.
So itis important to know where to find good assets that can be used in FOSS games.

This is my top 3 list, but there are plenty of websites on the web.  
- [kenney.nl](https://kenney.nl/) 2D, 3D and audio, all CC0  
- [opengameart.org](https://opengameart.org/) 2D, 3D and audio, multiple license  
- [freesound.org](https://freesound.org/) audio, multiple licenses  

Just keep in mind that you need to have the rights to use and share the assets you get.
You probably can't use and distribute assets you can buy online, because they have a proprietary license.

## Licenses and Trademarks
Now that have the source code and assets, let's talk a bit [legalese](https://en.wikipedia.org/wiki/Legal_English).

To keep it short, I will just make a quick list of most used licenses.
I highly recommend making your own research on licenses, to make sure you understand them.  
You can find a comprehensive list on [Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_free_and_open-source_software_licenses)

For **source code**  
permissive MIT, Apache  
weak copyleft MPL, LGPL  
strong copyleft GPL, AGPL

For **assets**  
public domain CC0  
attribution CC-BY  
attribution and share alike CC-BY-SA  

[**Reuse tool**](https://reuse.software/)
to keep track of licenses in your repositories.  
It is really easy to get a piece of code or asset from the web and add it to your game.
You just want to try and see it fits, but then a bug appears and you forget about it.
Good luck finding the website months later and hope, that it had a compliant license.  
The reuse tool forces you to add **license headers to all files** in a repository.
This makes forgetting things much harder and in the long run it will payoff.

Finally **trademarks** to protect name and branding of your game.
So someone can't reuse the name, logo or both (depending on which trademark) in their clones, without your permission.
This is not always necessary and costs quite some money.
But it's like an insurance, you hope that you don't have to use it, but when it's necessary, you are happy to have it.
Especially if you plan to create a commercial game.

## Game distribution platforms
Also here I don't want to spend to much time, since there are better articles on this topic.

[**F-Droid**](https://f-droid.org/en/) is a open source dedicated Android App catalog.
It will give you visibility in the open source community and might get you some contributions and donations.

[**Flathub**](https://flathub.org/) is a GNU/Linux app store for open source and proprietary software.
It allows you to easily bring your game to most GNU/Linux distributions.

[**itch.io**](https://itch.io) it a great place for indie games and developers.
You can reach a big audience that will expect unique and small games by solo developers or small studios.

[**Steam**](https://partner.steampowered.com) can give you the visibility and possibility to create a valid commercial game.
Most successful indie developers sell their games on Steam.

The **Google Play Store** and **Apple App Store** are also valid platforms, but can be complicated.
It is also really hard to get visibility and make money, since the mobile game market is much different compared to desktop game market.  
Just ask yourself when did you buy the last mobile app?
And how much did you spend on your last desktop or console game?

## FOSS business models

**No business, just fun** is the best model and surely the one you will have most fun with ;-)  
It's not really a business model, but I suggest to every beginner to focus on fun and learning.
Leave the business side to the day it makes sense.

**Donations** can be a nice way to stay motivated.
There are many platforms, like [liberapay](https://liberapay.com/), where people can donate you money.
In my case, I got around 25 Euros in donations overall.
It's a real great feeling if a complete stranger gives you a few bucks, because he liked your game.  
But it can be really difficult to get so much donations, that you can live from them.
And donations might make paying taxes or similar things more difficult.

**Sell desktop games platforms like Steam** is potentially the best way to earn a living as a game developer.
There are several FOSS games that do this and still have free versions on all other platforms.  
The best example I found is [Mindustry](https://mindustrygame.github.io/), that is a GPL licensed tower defense games.
According to an estimation from [game-stats.com](https://games-stats.com/steam/game/mindustry/),
the game made more than 3 million dollars.

## Guerilla marketing
As with business models, I suggest to care about marketing only when you feel confident about your games.
Learn how to make great games first, than start with the rest.

**Write a blog** if you like writing, like me.
I didn't like it from the beginning, but later I started really to love to write blog posts.
That passion survived also the rise of LLMs, so my blogs are still written by typing letter by letter by me.

**Make videos** if you prefer that.
It's important to have a web presence in some way, it doesn't really matter the format.
People can stumble upon your games only if there is a way to do it.

**FOSS lists** are a great way to get visibility for free without lifting a finger.  
If your games is FOSS and has an audience, somebody will add your games to this lists.
My games got added to the following (but not only) lists  
- [awesome-godot](https://github.com/godotengine/awesome-godot)  
- [fossdroid](https://fossdroid.com/a/ball2box.html)  
- [fossgaming](https://fossgaming.codeberg.page/games/pocket-broomball/)  

**Niche games** bring natural visibility.
Pick something unique nobody has created yet, and you will get downloads.  
I saw this happen with Pocket Broomball, because it was and still is the only Broomball video game.
And I hope to get the same effect with 99 Managers Futsal Edition.

**Stickers, stickers, stickers** are cheap and are loved by everyone.
Once you have a logo, print stickers and don't forget to bring them to events and whenever you leave the house.
The cheapest way I found is to print them on sticky paper with a ordinary printer.

## My game development advice

**Start with small games** and finish them.
The first games are great to learn how to make games.
You will notice that your second game is already much easier to make and is much better organized.
To not talk about the code quality.
I always get embarrassed when I have to fix a bug for Pocket Broomball and have to see the code I wrote a few years ago.  
Working immediately on big games can bring a lot of frustration and you will probably never finish it.
Making something small, finishing it and being proud of it is much better to stay motivated.
Once you feel confident, you can use your skills to create bigger games.

**Make web or desktop games**, because it is easier to release and get feedback.
Releasing mobile games can be really difficult, if you have no experience with it.
And your game will just be one of out of billions.
It can also get quite frustrating when Google/Apple decide to remove your perfectly working game from the market,
if you don't update to the latest SDK.
itch.io is a much more beginner friendly platform for Web, Desktop and even Android.

**No gaming computer/laptop is needed** for game development.
I created my first games with libGDX on a tiny 11inch laptop with 4gb of ram and an Intel Celeron.
Just if you want to create a open world 3D game or similar a graphic card might be needed.

**Participate in game jams** online on [itch.io](https://itch.io/jams) or
offline in South Tyrol like **castle game jam** organized by [gameground](https://www.gameground.it/)
or the **dung game jam** organized by [dung-gaming](https://www.dung-gaming.it/).  
Personally I don't like competitive coding competitions, but it's a great place to meet like minded people and create games!


## 99 Managers roadmap
Here a tiny roadmap of my next milestones regarding 99 Managers.

**2025** release Futsal Edition on Steam and other platforms  
**2025** [SFSCon](https://sfscon.it) talk proposal  
**2026** adapt code for other team sport  
**2027** and many other team sports  
**2030** ALL team sports ;-)  
...and of course, plans are made to be broken.

## 99 Managers gameplay
During the talk I showed the gameplay of my game.
You can watch the video (when it is available) or simply play the game.
The up to date download links are available [here](@/games/99managers-futsal-edition/index.md)

