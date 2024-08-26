+++
title = "Use websockets in Godot on itch.io with Caddy"
description = "A short guide on how to use websockets with Godot in web applications hosted on itch.io or other websites."
date = 2024-08-26T16:10:00+00:00
updated = 2024-08-26T16:10:00+00:00
[extra]
mastodon_link = ""
hackernews_link = ""
+++

To use websockets within your Godot game on itch.io, or any other website, a **secure** websocket connection, aka `wss://`, is mandatory.

**WARNING**: This is probably not the correct way to secure Godot's websocket connections.
I'm using this setup only for some [real-time auction tool](https://github.com/dulvui/condor/) I created for personal use only.
Please inform yourself, before using this in production.  
If you know the correct way how to solve this (or this actually is the correct way), please le me know!

## Caddy for the rescue
The [caddy webserver](https://caddyserver.com/), by default, automatically obtains and renews TLS certificates for all your sites and applications. 
This includes your websocket server!

With this simple Caddyfile, your websocket server is ready.
Change the `8000` port to whatever port you are using.
Also the `/ws/*` can be changed to `/whatever/*` you prefer.
```bash
your.dom.ain {
        reverse_proxy /ws/* localhost:8000
        handle /ws/* {
                reverse_proxy localhost:8000
        }
}
```

In your Godot client code, you can simply put the secure websocket url.  
Just make sure you use `wss://` instead of `ws://`.
```gd
const HOST: String = "wss://your.dom.ain/ws/"
```

Now you can play your game on itch.io or other websites!

## Client/Server code
The [godot-demo-projects](https://github.com/godotengine/godot-demo-projects) repository has great code examples for networking.

My application uses the code from there and can be found here
 - [client](https://github.com/dulvui/condor/blob/main/app/src/websocket/client/client.gd)
 - [server](https://github.com/dulvui/condor/tree/main/server/src)

This is an application for managing an auction for the Italian fantasy football game [Fantacalcio](https://www.fantacalcio.it/).  
In this code, the server is just forwarding the messages from one client to all other connected clients.
The server does not store any data or state.
If needed, you can extend the server with more logic, handling sessions, store data etc...
