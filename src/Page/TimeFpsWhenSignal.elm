module Page.TimeFpsWhenSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse
import Time exposing (fpsWhen)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote)

view : Signal Element
view =
  Extra.mapMany (flow down)
    [ isMouseDownElement
    , fpsWhenMouseDownNote
    , fpsWhenMouseDownElement
    ]

isMouseDown = Mouse.isDown

isMouseDownElement : Signal Element
isMouseDownElement =
  displaySimpleSandbox [ ( isMouseDown, "Mouse.isDown : Signal Bool") ]

fpsWhenMouseDownNote : Signal Element
fpsWhenMouseDownNote =
  signalNote "fpsWhenMouseDown : Time.fpsWhen 1 Mouse.isDown"

fpsWhenMouseDownElement : Signal Element
fpsWhenMouseDownElement =
  displaySimpleSandbox [ ( Time.fpsWhen 1 isMouseDown, "fpsWhenMouseDown : number -> Signal Bool -> Signal Time") ]