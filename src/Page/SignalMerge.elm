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
    , enterActionElement
    , tickActionElement
    , clicksAndEnterNote
    , clicksAndEnterElement
    , emptySpace
    , clickEnterTickNote
    , clickEnterTickElement
    ]

type Action = Click | Enter | Tick

clicksAction : Signal Action
clicksAction =
  Signal.map (always Click) Mouse.clicks

clicksActionElement : Signal Element
clicksActionElement =
  displaySimpleSandbox [ (clicksAction, "clicksAction : Signal Action")]

enterAction : Signal Action
enterAction =
  Signal.map (always Enter) Keyboard.enter

enterActionElement : Signal Element
enterActionElement =
  displaySimpleSandbox [ (enterAction, "enterAction : Signal Action")]

tickAction : Signal Action
tickAction =
  Signal.map (always Tick) (Time.every Time.second)

tickActionElement : Signal Element
tickActionElement =
  displaySimpleSandbox [ (tickAction, "tickAction : Signal Action")]

clicksAndEnter : Signal Action
clicksAndEnter =
  Signal.merge clicksAction enterAction

clicksAndEnterNote : Signal Element
clicksAndEnterNote =
  signalNote "clicksAndEnter = Signal.merge clicksAction enterAction"

clicksAndEnterElement : Signal Element
clicksAndEnterElement =
  displaySimpleSandbox [ (clicksAndEnter, "clicksAndEnter : Signal Action")]

clickEnterTick : Signal Action
clickEnterTick =
  Signal.mergeMany
    [ clicksAction
    , enterAction
    , tickAction
    ]

clickEnterTickNote : Signal Element
clickEnterTickNote =
  signalNote "clickEnterTick = mergeMany [ clicksAction, enterAction, tickAction ]"

clickEnterTickElement : Signal Element
clickEnterTickElement =
  displaySimpleSandbox [ (clickEnterTick, "clickEnterTick : Signal Action")]