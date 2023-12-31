# simondalvai.org
My personal website visible at [simondalvai.org](https://simondalvai.org/) or it's short link [s9i.org](https://s9i.org/)

Created with [Zola](https://www.getzola.org/) and [magic-box theme](https://github.com/dulvui/magic-box)


# Build
To build the site locally please install first [zola](https://www.getzola.org/).
```
cd src
zola build
```

# Deploy
This deployment is specific for my infrastructure, but it works with any caddy server or other http server.
```
rsync -ra public/ floresta-root:/root/docker/web/simondalvai.org/site/
```

# Licenses
The website itself is licensed under the [GNU AGPL v3.0](LICENSE) license.  
All content made by myself is licensed under the [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/) license.

[Simple-icons](https://github.com/simple-icons/simple-icons) are used in the footer. They are [CC0-1.0](https://github.com/simple-icons/simple-icons/blob/develop/LICENSE.md) licensed