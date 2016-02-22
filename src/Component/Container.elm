module Component.Container (container) where

import Html exposing (text, Html, div, a, img, h1, h3, header, footer, toElement)
import Html.Attributes exposing (href, class, alt, attribute, src, id)

wrap : Html -> Html
wrap mainView = 
  div [ class "container" ]
    [ a [ href "https://github.com/yang-wei/elmflux" ]
      [ img [ alt "Fork me on GitHub", attribute "data-canonical-src" "https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png", src "https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67", attribute "style" "position: absolute; top: 0; right: 0; border: 0;" ]
        []
      ]
    , header []
      [ h1 [ class "title" ]
        [ a [ href "#" ]
          [ text "Elm Flux" ]
        ]
      , h3 [ class "subtitle" ]
        [ text "Visualization of Elm Signals" ]
      ]
    , div [ id "app" ]
      [ mainView ]
    , footer []
      [ div [ class "footnote" ]
        [ text "foldp by "
        , a [ href "http://elm-lang.org/" ]
          [ text "Elm 0.16" ]
        ]
      ]
    ]

container : Signal Html -> Signal Html
container appState =
  Signal.map wrap appState