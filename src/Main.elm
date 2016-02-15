import Router exposing (match, Route, (:->))

import Signal.Extra as Extra exposing ((<~), (~))

import Graphics.Element as Element exposing (Element, flow, right)
import History exposing (hash, setPath)
import Debug
import Task

import Component.NavBar exposing (navBarSignal)

-- BASIC SIGNAL
import Page.MouseSignal as MouseSignal
import Page.KeyboardSignal as KeyboardSignal
import Page.WindowSignal as WindowSignal

-- TIME SIGNAL
import Page.TimeEverySignal as TimeEverySignal
import Page.TimeFpsSignal as TimeFpsSignal
import Page.TimeFpsWhenSignal as TimeFpsWhenSignal
import Page.TimeDelaySignal as TimeDelaySignal

routingElement : Signal Element
routingElement = Signal.map2 routing hashSignal pageSignals

main : Signal Element
main =
  Extra.mapMany (flow right)
  [ navBarSignal
  , routingElement
  ]

pageSignals =
  (,,,,,,) <~ MouseSignal.view
       ~ KeyboardSignal.view
       ~ WindowSignal.view
       ~ TimeEverySignal.view
       ~ TimeFpsSignal.view
       ~ TimeFpsWhenSignal.view
       ~ TimeDelaySignal.view

hashSignal = Signal.map (Debug.log "hash") hash

routing pagePath (mouse, keyboard, window, timeEvery, timeFps, timeFpsWhen, timeDelay) =
  let
    allPage =
      match [ "" :-> always mouse
            , "#/mouseSignal" :-> always mouse
            , "#/keyboardSignal" :-> always keyboard
            , "#/windowSignal" :-> always window
            , "#/timeEvery" :-> always timeEvery
            , "#/timeFpsWhen" :-> always timeFpsWhen
            , "#/timeFps" :-> always timeFps
            , "#/timeDelay" :-> always timeDelay
      ] (always mouse)
  in
    allPage pagePath

hashClick =
  Signal.mailbox Nothing

port set : Signal (Task.Task String ())
port set =
  Signal.map 
  (\url -> case url of
                Just y -> setPath y
                Nothing -> Task.fail "")  
  hashClick.signal