module Component.Line (toStreamLine) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (Time)
import List
import Text
import Mouse
import Color exposing (Color)
import AnimationFrame

import Config.Size exposing (seriesWidth, seriesHeight)

type Action a
  = TimeSignal Time
  | Action a

type alias Box = {
  x : Float,
  value : String
} 

initBox x value =
  Box x value

(pointWidth, pointHeight) = (25, 25)

startPoint : Float
startPoint = seriesWidth / 2

endPoint : Float
endPoint = negate (seriesWidth / 2)

maxDisplayPoint : Int
maxDisplayPoint =
  seriesWidth // pointWidth

objectMoveX : Float -> Form -> Form
objectMoveX x shape =
  moveX startPoint shape -- start from most left instead of origin
    |> moveX x

makeBox : Float -> String -> Color -> Form
makeBox x value color =
  let
    point = oval pointWidth pointHeight
            |> filled color
            |> objectMoveX x
    displayedValue = Text.fromString value
            |> text
            |> moveY (negate pointHeight)
            |> objectMoveX x
  in
    group [point, displayedValue]

initialSeries = []

moveXAsTimePassed delta box =
  { box | x = box.x - (pointWidth * 6 * Time.inSeconds delta) }

{-| Prevent overlapping of point to point but whole series jump =(
-}
moveXAsNewBoxIsAdded box =
  { box | x = box.x - pointWidth }

toStreamLine : Color -> (String -> String) -> Signal a -> Signal Element
toStreamLine color f signal =
  Signal.map (view color) (transformIntoLine f signal)

transformIntoLine : (String -> String) -> Signal a -> Signal (List Box)
transformIntoLine f signal=
  let
    action =
      Signal.merge (Signal.map Action signal) (Signal.map TimeSignal AnimationFrame.frame)

    update action series =
      case action of
        TimeSignal delta ->
          List.map (moveXAsTimePassed delta) series

        {-- when new action is detected --}
        Action a   ->
          let
            value = f (toString a)
            newBox = initBox 0 value
            -- move the old series forward and only display fit-screen box for perfomance reason -}
            forwardedSeries = List.take maxDisplayPoint (List.map moveXAsNewBoxIsAdded series)
          in 
            newBox :: forwardedSeries

  in
    Signal.foldp update initialSeries action


-- VIEW
view : Color -> List Box -> Element
view color series =
  let
    boxes = List.map (\{x, value} -> makeBox x value color) series
  in
  collage seriesWidth seriesHeight
    ([ timeAxisTick
      , timeAxis
      , timeAxisArrow
      ] ++ boxes )

axisLineStyle = 
  { defaultLine
    | width = 1.5
  }

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
    traced axisLineStyle axis

timeAxis : Form
timeAxis =
  let
    axis = path [(endPoint, 0), (seriesWidth, 0)]
  in
    traced axisLineStyle axis

timeAxisTick : Form
timeAxisTick =
  let
    axis = path [ (endPoint, 10)
                , (endPoint, -10)
                ]
  in
    traced axisLineStyle axis
