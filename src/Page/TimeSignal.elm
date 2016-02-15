module Page.TimeSignal (app) where 

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
    [ fpsSignalNote
    , fpsSignal
    , fpsWhenSignalNote
    , isMouseDownSignal
    , fpsWhenSignal
    , timeEverySignalNote
    , timeEveryNote
    , timeDelaySignalNote
    , mouseClicksSignal
    , timeDelaySignal
    ]


-- Time.fps

fpsSignalNote : Signal Element
fpsSignalNote =
  signalNote "number -> Signal Time"

fpsSignal : Signal Element
fpsSignal =
  displaySimpleSandbox [ ( (Time.fps 1), "Time.fps 1") ]


-- Time.fpsWhen

fpsWhenSignalNote : Signal Element
fpsWhenSignalNote =
  signalNote "number -> Signal Bool -> Signal Time"

isMouseDown = Mouse.isDown

isMouseDownSignal : Signal Element
isMouseDownSignal =
  displaySimpleSandbox [ ( isMouseDown, "isMouseDown = Mouse.isDown") ]

fpsWhenSignal : Signal Element
fpsWhenSignal =
  displaySimpleSandbox [ ( Time.fpsWhen 1 isMouseDown, "Time.fpsWhen 1 isMouseDown") ]


-- Time.every

timeEverySignalNote : Signal Element
timeEverySignalNote =
  signalNote "Time -> Signal Time"

timeEveryNote : Signal Element
timeEveryNote =
  displaySimpleSandbox [ ( (Time.every Time.second), "Time.every Time.second") ]


-- Time.delay

timeDelaySignalNote : Signal Element
timeDelaySignalNote =
  signalNote "Time -> Signal a -> Signal a"

mouseClicksSignal : Signal Element
mouseClicksSignal =
  displaySimpleSandbox [ ( Mouse.clicks, "Mouse.clicks" ) ]

timeDelaySignal : Signal Element
timeDelaySignal =
  displaySimpleSandbox [ ( Time.delay (Time.second) Mouse.clicks, "Time.delay (Time.second) Mouse.clicks" ) ]
