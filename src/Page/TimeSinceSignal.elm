module Page.TimeSinceSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse
import Time exposing (since, second)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)


-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ mouseClicksSignal
    , timeSinceSignal
    ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  displaySimpleSandbox [ ( Mouse.clicks, "Mouse.clicks : Signal ()" ) ]

timeSinceSignal : Signal Element
timeSinceSignal =
  displaySimpleSandbox [ ( since (2 * second) Mouse.clicks, "since (2 * second) clicks : Time -> Signal a -> Signal Bool") ]
