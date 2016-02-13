module Note (signalNote) where

import Text
import Graphics.Element as Element exposing (Element)

import Size exposing (seriesWidth, seriesHeight, seriesLabelWidth, seriesValueWidth)

{- Even the note need to be a Signal
   Because at the top level we want to mapMany
 -}
signalNote : String -> Signal Element
signalNote notes = 
  Signal.constant (toElement notes)

toElement : String -> Element
toElement str =
  let
    totalWidth = 
      seriesLabelWidth + seriesWidth + seriesValueWidth
    
    textElement = 
      Text.fromString str
        |> Element.justified
  
  in
    Element.container totalWidth seriesHeight Element.middle textElement
