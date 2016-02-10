module Stream (toStreamLine) where

import Time
import Graphics.Element as Element exposing (Element)
import Text
import String

-- Type of element which appear on streamline
type Action a
  = TimeSignal
  | Action a

streamLine : String
streamLine = "------------------------------------------------------"

timefps : Signal Time.Time
timefps = Time.fps 15

transformIntoStream : (String -> String) -> Signal a -> Signal String
transformIntoStream f signal =
      let
        action =
          Signal.merge (Signal.map Action signal) (Signal.map (always TimeSignal) timefps)
        
        update action stream =
            case action of
              TimeSignal ->
                String.append "-" stream
                  |> String.dropRight 1

              Action a   ->
                let
                  str = f (toString a)
                in 
                  String.append str stream
                    |> String.dropRight (String.length str)
      in
        Signal.foldp update streamLine action

view :  String -> Element
view stream =
      Text.fromString stream
      |> Text.monospace
      |> Element.centered

toStreamLine : (String -> String) -> Signal a -> Signal Element
toStreamLine f signal =
  Signal.map view (transformIntoStream f signal)