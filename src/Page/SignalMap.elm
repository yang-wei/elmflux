module Page.SignalMap (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard
import Char

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
    , keyboardCharNote
    , keyboardCharElement
    ]

keyboardCharNote : Signal Element
keyboardCharNote =
  signalNote "keyboardChar = Signal.map Char.fromCode Keyboard.presses"

keyboardChar : Signal Char
keyboardChar =
  Signal.map Char.fromCode Keyboard.presses

keyboardCharElement : Signal Element
keyboardCharElement =
  displaySimpleSandbox [ ( keyboardChar, "keyboardChar: Signal Char", elmBlue ) ]