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
import Config.Size exposing (seriesHeight, seriesWidth, seriesValueWidth)
import Config.Color exposing (elmBlue)

{-- A component that display signal. For eg:
  Mouse.clicks ---------()----------()---------------> ()
      |                  |           |                  |
    name          latest value  previous value     latest value
 --}

signalSandbox : Signal a -> (String -> String) -> String -> Signal Element
signalSandbox signal f signalName = 
  let
    smallHorizontalSpace = signalSpacer 10 1
    smallVerticalSpace = signalSpacer 1 10
    mediumHorizontalSpace = signalSpacer 15 1
    topDisplay =
      Extra.mapMany (flow right)
      [ smallHorizontalSpace
      , signalLabel signalName
      ]
    bottomDisplay =
      Extra.mapMany (flow right)
      [ mediumHorizontalSpace
      , toStreamLine f signal
      , smallHorizontalSpace
      , signalValue signal
      , mediumHorizontalSpace
      ]
  in
    Extra.mapMany (flow down) [ smallVerticalSpace, topDisplay, bottomDisplay, smallVerticalSpace ]

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
          |> Text.typeface ["Source Code Pro", "consolas", "inconsolata", "monospace"]
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
      |> Text.color elmBlue
      |> Element.justified
      |> Element.width seriesValueWidth)
  in
    Signal.map display value

signalSpacer : Int -> Int -> Signal Element
signalSpacer x y =
  Signal.constant (Element.spacer x y)