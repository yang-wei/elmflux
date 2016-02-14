module Router (match, Route, (:->)) where

import String exposing (startsWith, dropLeft, length)

{-| Router helper
    https://github.com/TheSeamau5/elm-router/blob/master/src%2FRouter.elm
-}
type alias Route a = String -> a

type alias Router a = (String, Route a)

match : List (Router a) -> Route a -> Route a
match routers defaultRoute url = case routers of
  [] -> defaultRoute url
  (prefix, route) :: rs ->
    if
      prefix == "" || prefix == "/"
    then
      if
        url == prefix
      then
        route url
      else
        match rs defaultRoute url
    else
      case matchPrefix prefix url of
        Just value -> route value
        Nothing    -> match rs defaultRoute url

matchPrefix : String -> String -> Maybe String
matchPrefix prefix string =
  if
    startsWith prefix string
  then
    Just <| dropLeft (String.length prefix) string
  else
    Nothing

(:->) : String -> Route a -> Router a
(:->) = (,)