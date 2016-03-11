module Page.SignalSampleOn (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard
import Mouse
import Time
import Char

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote, emptySpace)
import Page.MouseSignal exposing (mouseClicksElement)
import Config.Color exposing (elmBlue)

-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ mouseClicksElement
    , everySecondElement
    , clickTimeNote
    , clickTimeElement
    --, emptySpace
    --, keyboardPressesElement
    --, deltaElement
    --, keepFiringWhenPressedNote
    --, keepFiringWhenPressedElement
    ]

everySecond : Signal Time.Time
everySecond =
  Time.every Time.second

everySecondElement : Signal Element
everySecondElement =
  displaySimpleSandbox [ (everySecond, "everySecond : Signal Time.Time", elmBlue)]

clickTime : Signal Time.Time
clickTime = Signal.sampleOn Mouse.clicks everySecond

clickTimeNote : Signal Element
clickTimeNote =
  signalNote "clickTime = Signal.sampleOn mouseClicks everySecond"

clickTimeElement : Signal Element
clickTimeElement =
  displaySimpleSandbox [ (clickTime, "clickTime : Signal Time.Time", elmBlue)]

{-
-- Keep firing when pressed
keyboardChar : Signal Char
keyboardChar =
  Signal.map Char.fromCode Keyboard.presses

keyboardPressesElement : Signal Element
keyboardPressesElement =
  displaySimpleSandbox [ ( keyboardChar, "Keyboard.presses : Signal Char") ]

delta : Signal Time.Time
delta =
  Time.fps 5

deltaElement : Signal Element
deltaElement =
  displaySimpleSandbox [ ( delta, "delta : Signal Time.Time")]

keepFiringWhenPressed : Signal Char
keepFiringWhenPressed =
  Signal.sampleOn delta keyboardChar

keepFiringWhenPressedNote : Signal Element
keepFiringWhenPressedNote =
  signalNote "keepFiringWhenPressed = Signal.sampleOn delta keyboardChar"

keepFiringWhenPressedElement : Signal Element
keepFiringWhenPressedElement =
  displaySimpleSandbox [ ( keepFiringWhenPressed, "keepFiringWhenPressed : Signal Char") ]
-}