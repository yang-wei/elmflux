module Main where

import Signal.Extra as Extra exposing ((<~), (~))

import Html exposing (Html, fromElement)
import Graphics.Element as Element exposing (Element, flow, right)
import History exposing (hash, setPath)
import Debug
import Task

import Component.NavBar exposing (navBarSignal)
import Route exposing (routes)
import Component.Container exposing (container)

appView : Signal Html
appView =
  Signal.map fromElement (Extra.mapMany (flow right) [ navBarSignal, routes ])

main : Signal Html
main =
  container appView