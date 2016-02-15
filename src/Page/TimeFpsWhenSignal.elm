module Page.TimeFpsWhenSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse
import Time exposing (fpsWhen)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)

view : Signal Element
view =
  Extra.mapMany (flow down)
    [ isMouseDownSignal
    , fpsWhenMouseDownSignal
    ]

isMouseDown = Mouse.isDown

isMouseDownSignal : Signal Element
isMouseDownSignal =
  displaySimpleSandbox [ ( isMouseDown, "isMouseDown = Mouse.isDown") ]

fpsWhenMouseDownSignal : Signal Element
fpsWhenMouseDownSignal =
  displaySimpleSandbox [ ( Time.fpsWhen 1 isMouseDown, "Time.fpsWhen 1 isMouseDown : number -> Signal Bool -> Signal Time") ]