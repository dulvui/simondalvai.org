# simondalvai.org
My personal website.

Created with [Zola](https://www.getzola.org/) and [magic-box theme](https://github.com/dulvui/magic-box)

This content is available under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).



# build
```
cd src
zola build
```

# deploy
```
rsync -ra docs/ floresta-root:/root/docker/web/simondalvai.org/site/
```