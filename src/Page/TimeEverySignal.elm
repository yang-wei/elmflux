module Page.TimeEverySignal (view) where 

import Signal.Extra as Extra
import Graphics.Element as Element exposing (Element, flow, down)

import Mouse
import Time exposing (every, second)

-- COMPONENT
import Component.Sandbox exposing (displaySimpleSandbox)

view : Signal Element
view =
  Extra.mapMany (flow down)
    [ timeEverySecondSignal
    , timeEvery5SecondSignal
    ]

timeEverySecondSignal : Signal Element
timeEverySecondSignal =
  displaySimpleSandbox [ ( (every second), "every second : Time -> Signal Time") ]

timeEvery5SecondSignal : Signal Element
timeEvery5SecondSignal =
  displaySimpleSandbox [ ( every (5 * second), "every (5 * second) : Time -> Signal Time") ]