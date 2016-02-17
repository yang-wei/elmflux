module Component.Sandbox (simpleSignalSandbox, displaySimpleSandbox) where 

import Signal exposing (..)
import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, show, flow, up, down, left, right, justified, beside, container, middle)

-- STYLING
import String
import Text
import Color
import List

-- COMPONENT
import Component.Line exposing (toStreamLine)
import Component.Size exposing (seriesHeight, seriesWidth, seriesValueWidth)

{-- A component that display signal. For eg:
  Mouse.clicks ---------()----------()---------------> ()
      |                  |           |                  |
    name          latest value  previous value     latest value
 --}

signalSandbox : Signal a -> (String -> String) -> String -> Signal Element
signalSandbox signal f signalName = 
  let
    topDisplay =
      signalLabel signalName
    bottomDisplay =
      Extra.mapMany (flow right)
      [ toStreamLine f signal
      , signalSpacer 10 seriesHeight
      , signalValue signal ]
  in
    Extra.mapMany (flow down) [ topDisplay, bottomDisplay ]

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
          |> Element.leftAligned
          |> Element.width (seriesWidth + seriesValueWidth)
          |> Element.color (Color.rgb 255 255 255)
      in
        Signal.constant displayName

-- For e.g: ()
signalValue : Signal a -> Signal Element
signalValue value =
  let
    display value =
      container seriesValueWidth seriesHeight middle
      (toString value
      |> Text.fromString
      |> Text.height 20
      |> Element.justified
      |> Element.width seriesValueWidth)
  in
    Signal.map display value

signalSpacer : Int -> Int -> Signal Element
signalSpacer x y =
  Signal.constant (Element.spacer x y)