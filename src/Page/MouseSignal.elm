module Page.MouseSignal (view, mouseClicksElement, mouseIsDownElement) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Config.Color exposing (yellow)


-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ mouseClicksElement
    , mouseIsDownElement
    ]

mouseClicksSignal : Signal ()
mouseClicksSignal = Mouse.clicks

mouseClicksElement : Signal Element
mouseClicksElement =
  displaySimpleSandbox [ ( mouseClicksSignal, "Mouse.clicks : Signal ()", yellow ) ]

mouseIsDownElement : Signal Element
mouseIsDownElement =
  displaySimpleSandbox [ ( Mouse.isDown, "Mouse.isDown : Signal Bool", yellow ) ]