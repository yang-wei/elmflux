module Page.SignalMap2 (view) where

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard
import Char

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote)


-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ keyboardEnterElement
    , isEnterAndSpacePressedElement
    ]

keyboardEnterElement : Signal Element
keyboardEnterElement =
  displaySimpleSandbox
  [ ( Keyboard.enter, "Keyboard.enter : Signal Bool") 
  , ( Keyboard.space, "Keyboard.space : Signal Bool")
  ]

--keyboardCharNote : Signal Element
--keyboardCharNote =
--  signalNote "isEnterAndSpacePressed = Signal.map2 (\(s, e) -> s && e) Keyboard.space Keyboard.enter"

isBothTrue s e =
  s && e 

isEnterAndSpacePressed : Signal Bool
isEnterAndSpacePressed =
  Signal.map2 isBothTrue Keyboard.space Keyboard.enter

isEnterAndSpacePressedElement : Signal Element
isEnterAndSpacePressedElement =
  displaySimpleSandbox [ ( isEnterAndSpacePressed, "isEnterAndSpacePressed : Signal Bool") ]