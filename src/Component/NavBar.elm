module Component.NavBar (navBarSignal) where

import Graphics.Element exposing (Element)
import Html exposing (button, text, Html, div, a, ul, li, h1, toElement)
import Html.Attributes exposing (href, class)

submenuTitle label =
  li [ class "submenu-title" ] [ text label ]

submenuLink (hash, label) =
  li [] [ a [ href hash ] [ text label ] ]

navbar : Html
navbar = 
        div [] 
        [ ul [class "signals-menu"]
             [ submenuTitle "Basic Signal"
             , submenuLink ("#/mouseSignal", "Mouse")
             , submenuLink ("#/keyboardSignal", "Keyboard")
             , submenuLink ("#/windowSignal", "Window")
             , submenuTitle "Time Signal"
             , submenuLink ("#/timeEvery", "Time.every")
             , submenuLink ("#/timeFps", "Time.fps")
             , submenuLink ("#/timeFpsWhen", "Time.fpsWhen")
             , submenuLink ("#/timeDelay", "Time.delay")
             ]
        ]

navBarSignal : Signal Element
navBarSignal = 
  Signal.constant (toElement 150 50 navbar)