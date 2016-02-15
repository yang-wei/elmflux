module Route (routes) where

import Router exposing (match, Route, (:->))
import Signal.Extra as Extra exposing ((<~), (~))

import Graphics.Element exposing (Element)

import History exposing (hash)
import Debug

-- BASIC SIGNAL
import Page.MouseSignal as MouseSignal
import Page.KeyboardSignal as KeyboardSignal
import Page.WindowSignal as WindowSignal

-- TIME SIGNAL
import Page.TimeEverySignal as TimeEverySignal
import Page.TimeFpsSignal as TimeFpsSignal
import Page.TimeFpsWhenSignal as TimeFpsWhenSignal
import Page.TimeDelaySignal as TimeDelaySignal

routes : Signal Element
routes = Signal.map2 routing hashSignal pageSignals

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