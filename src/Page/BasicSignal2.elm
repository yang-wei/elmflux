module Page.BasicSignal2 (app) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse
import Window
import Keyboard
import Time

-- COMPONENT
import Component.Sandbox exposing (simpleSignalSandbox, displaySimpleSandbox)
import Component.Note exposing (signalNote)

app : Signal Element
app =
  Extra.mapMany (flow down)
    [ timeSignal
    , timeSignalNote
    ]

timeSignal : Signal Element
timeSignal =
  displaySimpleSandbox [ ( (Time.every Time.second), "Time.every Time.second") ]

timeSignalNote : Signal Element
timeSignalNote =
  signalNote "The clock is ticking... Showing current time in unix timestamp."