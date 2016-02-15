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
    [ mouseClicksSignal
    , mouseIsDownSignal
    ]

mousePositionXSignal : Signal Element
mousePositionXSignal =
  displaySimpleSandbox [ ( Mouse.x, "Mouse.x : Signal Int" ) ]

mouseClicksSignal : Signal Element
mouseClicksSignal =
  displaySimpleSandbox [ ( Mouse.clicks, "Mouse.clicks : Signal ()" ) ]

mouseIsDownSignal : Signal Element
mouseIsDownSignal =
  displaySimpleSandbox [ ( Mouse.isDown, "Mouse.isDown : Signal Bool" ) ]