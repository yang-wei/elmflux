import Router exposing (match, Route, (:->))

import Signal.Extra as Extra exposing ((<~), (~))

import Graphics.Element as Element exposing (Element, flow, right)
import History exposing (hash, setPath)
import Debug
import Task

import Component.NavBar exposing (navBarSignal)
import Route exposing (routes)

main : Signal Element
main =
  Extra.mapMany (flow right)
  [ navBarSignal
  , routes
  ]