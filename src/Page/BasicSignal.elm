module Page.BasicSignal (app) where 

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
    [ mouseClicksSignal
    , mouseClicksSignalNote
    , windowDimensionsSignal
    , windowDimensionsSignalNote
    , keyboardArrowsSignal
    , keyboardWasdSignal
    , keyboardSignalNote
    , timeSignal
    , timeSignalNote
    ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  displaySimpleSandbox [ ( Mouse.clicks, "Mouse.clicks" ) ]

mouseClicksSignalNote : Signal Element
mouseClicksSignalNote =
  signalNote "This is the most simple signal in Elm. Try to click anywhere on window"

windowDimensionsSignal : Signal Element
windowDimensionsSignal =
  displaySimpleSandbox [ ( Window.dimensions, "Window.dimensions" ) ]

windowDimensionsSignalNote : Signal Element
windowDimensionsSignalNote =
  signalNote "Might be a bit verbose but why don't you try it out by resizing window."

keyboardArrowsSignal : Signal Element
keyboardArrowsSignal =
  displaySimpleSandbox [ ( Keyboard.arrows, "Keyboard.arrows" ) ]

keyboardWasdSignal : Signal Element
keyboardWasdSignal =
  displaySimpleSandbox [ ( Keyboard.wasd, "Keyboard.wasd") ]

keyboardSignalNote : Signal Element
keyboardSignalNote =
  signalNote "Press on any arrows or wsad key on your keyboard. You will notice the duplicated code. We will learn to fix this later."

timeSignal : Signal Element
timeSignal =
  displaySimpleSandbox [ ( (Time.every Time.second), "Time.every Time.second") ]

timeSignalNote : Signal Element
timeSignalNote =
  signalNote "The clock is ticking... Showing current time in unix timestamp."