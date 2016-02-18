## [Elmflux](http://yang-wei.github.io/elmflux/)

> Let's prove that [Elm](http://elm-lang.org/) signals do exist =)

![](https://cldup.com/xxMHJ6fkox.gif)

Like the diagram above, Elmflux is a web app that visualizing **Signal** in Elm. If you do not know anything about Signal then you can read it on [my blog](http://yang-wei.github.io/blog/2016/02/04/a-step-to-step-guide-to-elm-signal/). Elmflux is inspired by [rxmarbles](https://github.com/staltz/rxmarbles) which visualizes Rx operators.

### How to use ?
For some signals, you have to move your mouse, type using your keyboard or resizing browser. You probably can guess what to do when you see the signal name.

## Contributing
More examples will be added to the website soon. I currently do not have roadmap of this repository yet so any ideas are welcome.

To run it locally, fork and clone this repository. Make sure you have [Elm installed](http://yang-wei.github.io/blog/2016/02/03/lets-elm-setting-up-everything/) then

```
elm make src/Main.elm --output build/main.js
open index.html
```

I am using travis to deploy this application and all the scripts are in [deploy.sh](https://github.com/yang-wei/elmflux/blob/master/deploy.sh) 

## Read more
 * [Elm doc](http://elm-lang.org/guide/reactivity)
 * [Signal API](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Signal)
 * [A Step to Step Guide to Elm Signal](http://yang-wei.github.io/blog/2016/02/04/a-step-to-step-guide-to-elm-signal/)