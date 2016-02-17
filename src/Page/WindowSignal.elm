module Page.WindowSignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Window

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)


-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ windowDimensionsElement
    ]

windowDimensionsElement : Signal Element
windowDimensionsElement =
  displaySimpleSandbox [ ( Window.dimensions, "Window.dimensions : dimensions : Signal (Int, Int)" ) ]