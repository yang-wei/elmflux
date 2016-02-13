module Page.BasicSignal (app) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse exposing (clicks)
import Window

-- COMPONENT
import Component.Sandbox exposing (simpleSignalSandbox, displaySimpleSandbox)
import Component.Note exposing (signalNote)

app : Signal Element
app =
  Extra.mapMany (flow down)
    [ mouseClicksSignal
    , mouseClicksSignalNote
    , windowDimensionsSignal
    , windowDimensionsSignalNote
    , filterSignal
    ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  displaySimpleSandbox [
    ( Mouse.clicks, "Mouse.clicks" )
  ]

mouseClicksSignalNote : Signal Element
mouseClicksSignalNote =
  signalNote "This is the most simple signal in Elm. Try to click anywhere on window"

windowDimensionsSignal : Signal Element
windowDimensionsSignal =
  displaySimpleSandbox [
    ( Window.dimensions, "Window.dimensions" )
  ]

windowDimensionsSignalNote : Signal Element
windowDimensionsSignalNote =
  signalNote "Might be a bit verbose but why don't you try it out by resizing window."

{- when x,y of Window.dimensions are even number -}
evenWindowDimensionsSignal =
  Signal.filter (\(x, y) -> if x % 2 == 0 && y % 2 == 0 then True else False) (0, 0) Window.dimensions

filterSignal : Signal Element
filterSignal =
  displaySimpleSandbox
  [ ( Window.dimensions,  "Window.dimensions")
  , ( evenWindowDimensionsSignal, "evenWindowDimensionsSignal")
  ]
