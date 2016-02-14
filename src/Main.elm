import Router exposing (match, Route, (:->))

import Signal.Extra as Extra

import Graphics.Element as Element exposing (Element, flow, left)
import Html exposing (button, text, Html, div, a, ul, li, h1)
import Html.Attributes exposing (href)
import History          exposing (hash, setPath)
import Debug
import Task

import Page.BasicSignal as BasicSignal
import Page.BasicSignal2 as BasicSignal2

navbar : Html
navbar = 
        div [] 
        [ ul []
             [ li [] [ a [href "#" ] [text "page-1" ] ] 
             , li [] [ a [href "#/page2" ] [text "page-2" ] ] 
             , li [] [ a [href "#/page3" ] [text "page-3" ] ] 
             ]
        ]

signals : Signal (String, Element, Element)
signals = Signal.map3 (,,) 
          (Signal.map (Debug.log "hash") hash)
          BasicSignal.app
          BasicSignal2.app

hashClick = Signal.mailbox Nothing

port set : Signal (Task.Task String ())
port set =
  Signal.map 
  (\url -> case url of
                Just y -> setPath y
                Nothing -> Task.fail "")  
  hashClick.signal

routing (pagePath, sig1, sig2) =
  let sig1Page = always sig1
      sig2Page = always sig2
      allPage =
        match [ "" :-> sig1Page
              , "#/Signal1" :-> sig1Page
              , "#/Signal2" :-> sig2Page
        ] sig1Page
  in
    allPage pagePath

routingElement = Signal.map routing signals

main =
  Extra.mapMany (flow left) [
    routingElement
  ]