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
import Page.TimeSinceSignal as TimeSinceSignal

-- SIGNAL CORE LIBRARY
import Page.SignalMap as SignalMap
import Page.SignalMap2 as SignalMap2
import Page.SignalFilter as SignalFilter
import Page.SignalFoldp as SignalFoldp

--routes : Signal Element
routes = Signal.map4 routing hashSignal basicSignals timeSignals coreSignals

basicSignals : Signal (Element, Element, Element)
basicSignals = Extra.zip3
                MouseSignal.view
                KeyboardSignal.view
                WindowSignal.view

timeSignals = 
  (,,,,) <~ TimeEverySignal.view
          ~ TimeFpsSignal.view
          ~ TimeFpsWhenSignal.view
          ~ TimeDelaySignal.view
          ~ TimeSinceSignal.view

coreSignals =
  (,,,) <~ SignalMap.view
         ~ SignalMap2.view
         ~ SignalFilter.view
         ~ SignalFoldp.view

hashSignal = Signal.map (Debug.log "hash") hash

routing hash basic time core =
  let
    (mouse, keyboard, window) = basic
    (timeEvery, timeFps, timeFpsWhen, timeDelay, timeSince) = time
    (map, map2, filter, foldp) = core
    allPage =
      match [ "" :-> always mouse
            , "#/mouseSignal" :-> always mouse
            , "#/keyboardSignal" :-> always keyboard
            , "#/windowSignal" :-> always window
            , "#/timeEvery" :-> always timeEvery
            , "#/timeFpsWhen" :-> always timeFpsWhen
            , "#/timeFps" :-> always timeFps
            , "#/timeDelay" :-> always timeDelay
            , "#/timeSince" :-> always timeSince
            , "#/signalMap2" :-> always map2
            , "#/signalMap" :-> always map
            , "#/signalFilter" :-> always filter
            , "#/signalFoldp" :-> always foldp
      ] (always mouse)
  in
    allPage hash