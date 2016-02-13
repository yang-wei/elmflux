module Component.Sandbox (simpleSignalSandbox, displaySimpleSandbox) where 

import Signal exposing (..)
import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, show, flow , up, down, left, right, justified, beside, container, middle)

-- STYLING
import String
import Text
import Color
import List

-- COMPONENT
import Component.Line exposing (toStreamLine)
import Component.Size exposing (seriesHeight, seriesLabelWidth, seriesValueWidth)

{-- A component that display signal. For eg:
  Mouse.clicks ---------()----------()---------------> ()
      |                  |           |                  |
    name          latest value  previous value     latest value
 --}

signalSandbox : Signal a -> (String -> String) -> String -> Signal Element
signalSandbox signal f signalName = 
  Extra.mapMany (flow right) [ signalLabel signalName
                             , toStreamLine f signal
                             , signalValue signal
                             ]

displaySimpleSandbox signals =
  let
    sandboxes =
      List.map (\(signal, name) -> simpleSignalSandbox signal name) signals
  in
    Extra.mapMany (flow down) sandboxes

simpleSignalSandbox : Signal a -> String -> Signal Element
simpleSignalSandbox signal signalName =
  signalSandbox signal identity signalName

-- For e.g: Mouse.clicks
signalLabel : String -> Signal Element
signalLabel name =
      let
        displayName =
          Text.fromString name
          |> Element.rightAligned
          |> Element.width 200
          |> Element.color (Color.rgb 255 255 255)
        labelContainer =
          container seriesLabelWidth seriesHeight middle displayName
      in
        Signal.constant labelContainer

-- For e.g: ()
signalValue : Signal a -> Signal Element
signalValue value =
  let
    display value =
      container seriesValueWidth seriesHeight middle
      (toString value
      |> Text.fromString
      |> Element.leftAligned
      |> Element.width 200)
  in
    Signal.map display value