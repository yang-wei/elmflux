module Line (toStreamLine) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time
import Color exposing (rgb)
import List
import Text
import Mouse

import Size exposing (seriesWidth, seriesHeight)

type Action a
  = TimeSignal
  | Action a

type alias Box = {
  x : Float,
  value : String
} 

initBox x value =
  Box x value

delta = Signal.map Time.inSeconds (Time.fps 45)

(pointWidth, pointHeight) = (15, 15)
startPoint = pointWidth - (seriesWidth / 2)

objectMoveX : Float -> Form -> Form
objectMoveX x shape =
  moveX startPoint shape -- start from most left instead of origin
    |> moveX x

makeBox : Float -> String -> Form
makeBox x value =
  let
    point = oval pointWidth pointHeight
            |> filled elmBlue
            |> objectMoveX x
    displayedValue = Text.fromString value
            |> text
            |> moveY (negate pointHeight)
            |> objectMoveX x
  in
    group [point, displayedValue]

initialSeries = []

moveXAsTimePassed point =
  { point | x = point.x + (30 * 0.15) }

toStreamLine : (String -> String) -> Signal a -> Signal Element
toStreamLine f signal =
  Signal.map view (transformIntoLine f signal)

transformIntoLine f signal=
  let
    action =
      Signal.merge (Signal.map Action signal) (Signal.map (always TimeSignal) delta)
    
    update action series =
      case action of
        TimeSignal ->
          List.map moveXAsTimePassed series

        {-- when new action is detected --}
        Action a   ->
          let
            value = f (toString a)
            newBox = initBox 0 value
          in 
            newBox :: series

  in
    Signal.foldp update initialSeries action

view series =
  let
    boxes = List.map (\{x, value} -> makeBox x value) series
  in
  collage seriesWidth seriesHeight
    ([ rect seriesWidth seriesHeight
        |> filled white
    , timeAxis
    , timeAxisArrow
    ] ++ boxes )

timeAxisArrow : Form
timeAxisArrow =
  let
    arrowWingPointX = seriesWidth * 0.49
    arrowHeadPoint = seriesWidth * 0.5
    axis = path [ (arrowWingPointX, 5)
                , (arrowHeadPoint, 0)
                , (arrowWingPointX, -5)
                ]
  in
    traced defaultLine axis

timeAxis : Form
timeAxis =
  let
    axis = path [(startPoint, 0), (seriesWidth, 0)]
  in
    traced defaultLine axis

elmBlue =
  rgb 96 181 204

white =
  rgb 255 255 255