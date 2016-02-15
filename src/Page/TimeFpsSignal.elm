module Page.TimeFpsSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse
import Time exposing (fps)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)

view : Signal Element
view =
  Extra.mapMany (flow down)
    [ oneFpsSignal
    , fiveFpsSignal
    ]

oneFpsSignal : Signal Element
oneFpsSignal =
  displaySimpleSandbox [ ( fps 1, "fps 1 number -> Signal Time") ]

fiveFpsSignal : Signal Element
fiveFpsSignal =
  displaySimpleSandbox [ ( fps 5, "fps 5 number -> Signal Time") ]