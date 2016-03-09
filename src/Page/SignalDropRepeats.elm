module Page.SignalDropRepeats (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote)
import Config.Color exposing (elmBlue)
import Page.KeyboardSignal exposing (keyboardPressesElement)

-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ keyboardPressesElement
    , dropRepeatsPressesNote
    , dropRepeatsPressesElement
    ]

dropRepeatsPresses : Signal Int
dropRepeatsPresses =
  Signal.dropRepeats Keyboard.presses

dropRepeatsPressesNote : Signal Element
dropRepeatsPressesNote =
  signalNote "dropRepeatsPresses = Signal.dropRepeats Keyboard.presses"

dropRepeatsPressesElement : Signal Element
dropRepeatsPressesElement =
  displaySimpleSandbox [ ( dropRepeatsPresses, "dropRepeatsPresses : Signal Int", elmBlue) ]