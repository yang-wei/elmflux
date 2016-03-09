module Page.SignalFoldp (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)
import Mouse

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote)
import Page.MouseSignal exposing (mouseClicksElement)
import Config.Color exposing (elmBlue)

-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ mouseClicksElement
    , clicksCounterNote
    , counter
    ]

clicksCounter : Signal Int
clicksCounter =
  Signal.foldp (\_ count -> count + 1) 0 Mouse.clicks

clicksCounterNote : Signal Element
clicksCounterNote =
  signalNote "counter = Signal.foldp (\\_ n -> n + 1) 0 Mouse.clicks"

counter : Signal Element
counter =
  displaySimpleSandbox [ ( clicksCounter, "counter : Signal Int", elmBlue ) ]