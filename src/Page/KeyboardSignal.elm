module Page.KeyboardSignal (view, keyboardPressesElement) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Config.Color exposing (orange)


-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ keyboardArrowsElement
    , keyboardWasdElement
    , keyboardPressesElement
    ]

keyboardArrowsElement : Signal Element
keyboardArrowsElement =
  displaySimpleSandbox [ ( Keyboard.arrows, "Keyboard.arrows : Signal { x : Int, y : Int }", orange ) ]

keyboardWasdElement : Signal Element
keyboardWasdElement =
  displaySimpleSandbox [ ( Keyboard.wasd, "Keyboard.wasd : Signal { x : Int, y : Int }", orange) ]

keyboardPressesElement : Signal Element
keyboardPressesElement =
  displaySimpleSandbox [ ( Keyboard.presses, "Keyboard.presses : Signal KeyCode", orange) ]