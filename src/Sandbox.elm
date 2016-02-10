module Sandbox (simpleSignalSandbox) where 

import Signal exposing (..)
import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, show, flow , up, down, left, right, justified, beside, container, middle)

-- STYLING
import String
import Text
import Color

-- COMPONENT
import Stream exposing (toStreamLine)

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

simpleSignalSandbox : Signal a -> String -> Signal Element
simpleSignalSandbox signal signalName =
  signalSandbox signal identity signalName

-- For e.g Mouse.clicks
signalLabel : String -> Signal Element
signalLabel name =
      let
        format name =
          Text.fromString name
          |> Text.monospace
          |> Element.rightAligned
          |> Element.width 200
          |> Element.color (Color.rgb 255 255 255)
      in
        Signal.constant (format name)

-- For e.g ()
signalValue : Signal a -> Signal Element
signalValue value =
  let
    format str =
      toString str
      |> Text.fromString
      |> Text.monospace
      |> Element.leftAligned
      |> Element.width 200
  in
    Signal.map format value