module Page.TimeDelaySignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse exposing (clicks)
import Time exposing (delay, second)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote)
import Page.MouseSignal exposing (mouseClicksElement)
import Config.Color exposing (elmBlue)

view : Signal Element
view =
  Extra.mapMany (flow down)
    [ mouseClicksElement
    , timeDelayNote
    , timeDelaySignal
    ]

timeDelayNote : Signal Element
timeDelayNote =
  signalNote "delayedClick = Time.delay (second) Mouse.clicks"

timeDelaySignal : Signal Element
timeDelaySignal =
  displaySimpleSandbox [ ( delay (second) clicks, "delayedClick : Time -> Signal a -> Signal a", elmBlue ) ]
