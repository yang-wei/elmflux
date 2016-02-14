import Router exposing (match, Route, (:->))

import Signal.Extra as Extra exposing ((<~), (~))

import Graphics.Element as Element exposing (Element, flow, right)
import History exposing (hash, setPath)
import Debug
import Task

import Component.NavBar exposing (navBarSignal)

import Page.BasicSignal as BasicSignal
import Page.TimeSignal as TimeSignal

routingElement : Signal Element
routingElement = Signal.map2 routing hashSignal pageSignals

main : Signal Element
main =
  Extra.mapMany (flow right)
  [ navBarSignal
  , routingElement
  ]

pageInfo =
  [ (BasicSignal.app, "basicSignal")
  , (TimeSignal.app, "timeSignal")
  ]

pageSignals =
  (,) <~ BasicSignal.app
       ~ TimeSignal.app

hashSignal = Signal.map (Debug.log "hash") hash

routing pagePath (basicSignal, timeSignal) =
  let
    allPage =
      match [ "" :-> always basicSignal
            , "#/basicSignal" :-> always basicSignal
            , "#/timeSignal" :-> always timeSignal
      ] (always basicSignal)
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