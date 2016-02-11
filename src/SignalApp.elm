module SignalApp (app) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse exposing (clicks)
import Window

-- COMPONENT
import Sandbox exposing (simpleSignalSandbox)
import Note exposing (signalNote)

app : Signal Element
app =
  Extra.mapMany (flow down)
    [ mouseClicksSignal
    , mouseClicksSignalNote
    , windowDimensionsSignal
    , filterSignal
    ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  Extra.mapMany (flow down)
  [ simpleSignalSandbox Mouse.clicks "Mouse.clicks" ]

mouseClicksSignalNote : Signal Element
mouseClicksSignalNote =
  signalNote "This is the most simple signal in Elm. Try to click anywhere on window"

windowDimensionsSignal : Signal Element
windowDimensionsSignal =
  Extra.mapMany (flow down)
  [ simpleSignalSandbox Window.dimensions "Window.dimensions" ]

{- when x,y of Window.dimensions are even number -}
evenWindowDimensionsSignal =
  Signal.filter (\(x, y) -> if x % 2 == 0 && y % 2 == 0 then True else False) (0, 0) Window.dimensions

filterSignal : Signal Element
filterSignal =
  Extra.mapMany (flow down)
  [ simpleSignalSandbox Window.dimensions "Window.dimensions"
  , simpleSignalSandbox evenWindowDimensionsSignal "evenWindowDimensionsSignal"
  ]