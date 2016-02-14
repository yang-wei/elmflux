import Router exposing (match, Route, (:->))

import Signal.Extra as Extra

import Graphics.Element as Element exposing (Element, flow, right)
import Html exposing (button, text, Html, div, a, ul, li, h1, toElement)
import Html.Attributes exposing (href)
import History          exposing (hash, setPath)
import Debug
import Task

import Page.BasicSignal as BasicSignal
import Page.TimeSignal as TimeSignal

navbar : Html
navbar = 
        div [] 
        [ ul []
             [ li [] [ a [href "#/basicSignal" ] [text "Basic Signals" ] ] 
             , li [] [ a [href "#/timeSignal" ] [text "Time Signals" ] ] 
             ]
        ]

signalNavbar : Signal Element
signalNavbar = 
  Signal.constant (toElement 150 50 navbar)

routingElement = Signal.map routing signals

main =
  Extra.mapMany (flow right)
  [ signalNavbar
  , routingElement
  ]

signals : Signal (String, Element, Element)
signals = Signal.map3 (,,) 
          (Signal.map (Debug.log "hash") hash)
          BasicSignal.app
          BasicSignal2.app
 
routing (pagePath, basicSignal, timeSignal) =
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