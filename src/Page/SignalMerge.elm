module Page.SignalMerge (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Keyboard
import Mouse
import Time

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)
import Component.Note exposing (signalNote, emptySpace)

-- VIEW
view : Signal Element
view =
  Extra.mapMany (flow down)
    [ clicksActionElement
    , keyPressesElement
    , tickActionElement
    , clicksAndPressNote
    , clicksAndPressElement
    , emptySpace
    , clickPressTickNote
    , clickPressTickElement
    ]

type Action = Click | Press | Tick

clicksAction : Signal Action
clicksAction =
  Signal.map (always Click) Mouse.clicks

clicksActionElement : Signal Element
clicksActionElement =
  displaySimpleSandbox [ (clicksAction, "clicksAction : Signal Action")]

keyPresses : Signal Action
keyPresses =
  Signal.map (always Press) Keyboard.presses

keyPressesElement : Signal Element
keyPressesElement =
  displaySimpleSandbox [ (keyPresses, "keyPresses : Signal Action")]

tickAction : Signal Action
tickAction =
  Signal.map (always Tick) (Time.every Time.second)

tickActionElement : Signal Element
tickActionElement =
  displaySimpleSandbox [ (tickAction, "tickAction : Signal Action")]

clicksAndPress : Signal Action
clicksAndPress =
  Signal.merge clicksAction keyPresses

clicksAndPressNote : Signal Element
clicksAndPressNote =
  signalNote "clicksAndPress = Signal.merge clicksAction keyPresses"

clicksAndPressElement : Signal Element
clicksAndPressElement =
  displaySimpleSandbox [ (clicksAndPress, "clicksAndPress : Signal Action")]

clickPressTick : Signal Action
clickPressTick =
  Signal.mergeMany
    [ clicksAction
    , keyPresses
    , tickAction
    ]

clickPressTickNote : Signal Element
clickPressTickNote =
  signalNote "clickPressTick = mergeMany [ clicksAction, keyPresses, tickAction ]"

clickPressTickElement : Signal Element
clickPressTickElement =
  displaySimpleSandbox [ (clickPressTick, "clickPressTick : Signal Action")]