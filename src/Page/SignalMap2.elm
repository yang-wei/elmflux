module Page.SignalMap2 (view) where

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard
import Char

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote)
import Config.Color exposing (orange, elmBlue)

-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ keyboardEnterElement
    , keyboardCharNote
    , isEnterAndSpacePressedElement
    ]

keyboardEnterElement : Signal Element
keyboardEnterElement =
  displaySimpleSandbox
  [ ( Keyboard.enter, "Keyboard.enter : Signal Bool", orange) 
  , ( Keyboard.space, "Keyboard.space : Signal Bool", orange)
  ]

keyboardCharNote : Signal Element
keyboardCharNote =
  signalNote "isEnterAndSpacePressed = map2 (\\(s, e) -> s && e) space enter"

isBothTrue s e =
  s && e 

isEnterAndSpacePressed : Signal Bool
isEnterAndSpacePressed =
  Signal.map2 isBothTrue Keyboard.space Keyboard.enter

isEnterAndSpacePressedElement : Signal Element
isEnterAndSpacePressedElement =
  displaySimpleSandbox [ ( isEnterAndSpacePressed, "isEnterAndSpacePressed : Signal Bool", elmBlue) ]