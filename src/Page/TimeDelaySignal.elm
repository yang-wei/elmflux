module Page.TimeDelaySignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse exposing (clicks)
import Time exposing (delay, second)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)

view : Signal Element
view =
  Extra.mapMany (flow down)
    [ mouseClicksSignal
    , timeDelaySignal
    ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  displaySimpleSandbox [ ( clicks, "Mouse.clicks : Signal ()" ) ]

timeDelaySignal : Signal Element
timeDelaySignal =
  displaySimpleSandbox [ ( delay (second) clicks, "delay (second) Mouse.clicks : Time -> Signal a -> Signal a" ) ]
