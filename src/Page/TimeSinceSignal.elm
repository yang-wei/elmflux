module Page.TimeSinceSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse
import Time exposing (since, second)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote)

-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ mouseClicksSignal
    , timeSinceNote
    , timeSinceSignal
    ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  displaySimpleSandbox [ ( Mouse.clicks, "Mouse.clicks : Signal ()" ) ]

timeSinceNote : Signal Element
timeSinceNote =
  signalNote "twoSecondClick = Time.since (2 * second) Mouse.clicks"

timeSinceSignal : Signal Element
timeSinceSignal =
  displaySimpleSandbox [ ( since (2 * second) Mouse.clicks, "twoSecondClick : Time -> Signal a -> Signal Bool") ]
