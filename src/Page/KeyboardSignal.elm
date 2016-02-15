module Page.KeyboardSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)


-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ keyboardArrowsSignal
    , keyboardWasdSignal
    , keyboardPressesSignal
    ]

keyboardArrowsSignal : Signal Element
keyboardArrowsSignal =
  displaySimpleSandbox [ ( Keyboard.arrows, "Keyboard.arrows : Signal { x : Int, y : Int }" ) ]

keyboardWasdSignal : Signal Element
keyboardWasdSignal =
  displaySimpleSandbox [ ( Keyboard.wasd, "Keyboard.wasd : Signal { x : Int, y : Int }") ]

keyboardPressesSignal : Signal Element
keyboardPressesSignal =
  displaySimpleSandbox [ ( Keyboard.presses, "Keyboard.presses : Signal KeyCode") ]