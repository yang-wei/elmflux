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
             , submenuLink ("#/timeEvery", "every")
             , submenuLink ("#/timeFps", "fps")
             , submenuLink ("#/timeFpsWhen", "fpsWhen")
             , submenuLink ("#/timeDelay", "delay")
             , submenuLink ("#/timeSince", "since")
             , submenuTitle "Signal Library"
             , submenuLink ("#/signalMap", "map")
             , submenuLink ("#/signalMap2", "map2")
             , submenuLink ("#/signalFilter", "filter")
             , submenuLink ("#/signalFoldp", "foldp")
             , submenuLink ("#/signalMerge", "merge")
             , submenuLink ("#/signalSampleOn", "sampleOn")
             , submenuLink ("#/signalDropRepeats", "dropRepeats")
             ]
        ]

navBarSignal : Signal Element
navBarSignal = 
  Signal.constant (toElement 200 600 navbar)