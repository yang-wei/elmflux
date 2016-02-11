module Note (signalNote) where

import Text
import Graphics.Element as Element exposing (Element)

{- Even the note need to be a Signal
   Because at the top level we want to mapMany
 -}
signalNote : String -> Signal Element
signalNote notes = 
  Signal.constant (strToElement notes)

strToElement : String -> Element
strToElement str =
  Text.fromString str
    --|> Text.style noteStyle
    |> Element.justified

noteStyle = { bold = True }