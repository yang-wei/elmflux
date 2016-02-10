module SignalApp (app) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse exposing (clicks)
import Window

-- COMPONENT
import Sandbox exposing (simpleSignalSandbox)

app : Signal Element
app =
  Extra.mapMany (flow down)
    [ mouseClicksSignal
    , windowDimensionsSignal
    ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  Extra.mapMany (flow down)
  [ simpleSignalSandbox Mouse.clicks "Mouse.clicks" ]

windowDimensionsSignal : Signal Element
windowDimensionsSignal =
  Extra.mapMany (flow down)
  [ simpleSignalSandbox Window.dimensions "Window.dimensions" ]
