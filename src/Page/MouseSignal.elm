module Page.MouseSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)


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
  displaySimpleSandbox [ ( mouseClicksSignal, "Mouse.clicks : Signal ()" ) ]

mouseIsDownElement : Signal Element
mouseIsDownElement =
  displaySimpleSandbox [ ( Mouse.isDown, "Mouse.isDown : Signal Bool" ) ]