# elm_image_gallery_example

# Overview
This is a step by step tutorial to build a stunning photo gallery.
There are 4 steps to achive the final web app:
*   static version
*   dynamic version
*   inverse data flow
*   unsplash integrated version

they are in 4 folders respectively, if you want to view the result for one version, use the following command:

```shell
elm-live static_version/Main.elm --output=elm.js --open
elm-live static_version/Main.elm --open
```

Noted: I recommend to use the command with `output=elm.js`, this will not touch `index.html` file which included the css file
if you use the command without `output=elm.js`, the css style will gone:)
