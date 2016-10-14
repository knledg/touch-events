module TouchEvents exposing
  ( TouchEvent(..), Direction(..), Touch
  , emptyTouch, getDirectionX
  , onTouchEvent, onTouchEnd, onTouchStart, onTouchMove
  )

{-| The is a library to provide touch event helpers

# Types
@docs TouchEvent, Direction, Touch

# Helpers
@docs emptyTouch, getDirectionX

# Event Handlers
@docs onTouchEvent, onTouchEnd, onTouchStart, onTouchMove

-}

import Json.Decode as JD exposing ((:=))
import Html exposing (Attribute)
import Html.Events exposing (on)

{-| Supported touch event types
-}
type TouchEvent
  = TouchStart
  | TouchEnd
  | TouchMove


{-| Supported touch directions
-}
type Direction
  = Left
  | Right
  | Up
  | Down

{-| Type alias for the touch record on the touch event object
-}
type alias Touch =
  { clientX : Float
  , clientY : Float
  }


{-| Returns a `Touch` record with 0 as default values
-}
emptyTouch : Touch
emptyTouch =
  { clientX = 0
  , clientY = 0
  }


{-| Gets the direction of the swipe on the x axis (`Left` or `Right`)
-}
getDirectionX : Float -> Float -> Direction
getDirectionX start end =
  if start > end then
    Left
  else
    Right


{-| Higher level touch event handler

This takes a TouchEvent type and application `Msg` type.
The `Msg` type should take a `TouchEvent.Touch` type.

```
type Msg
  = UserSwipeStart TouchEvents.Touch

view model =
  div
    [ TouchEvents.onTouchEvent TouchEvents.TouchStart UserSwipeStart
    ]
    []
```
-}
onTouchEvent : TouchEvent -> (Touch -> msg) -> Attribute msg
onTouchEvent eventType msg =
  case eventType of
    TouchStart -> onTouchStart msg
    TouchEnd -> onTouchEnd msg
    TouchMove -> onTouchMove msg


{-| Lower level "touchend" event handler

Takes the application `Msg` type which should take `TouchEvents.Touch`
as a payload

```
type Msg
  = UserSwipeEnd TouchEvents.Touch

view model =
  div
    [ TouchEvents.onTouchEnd UserSwipeEnd
    ]
    []
```
-}
onTouchEnd : (Touch -> msg) -> Attribute msg
onTouchEnd msg =
  on "touchend" <| eventDecoder msg "changedTouches"


{-| Lower level "touchstart" event handler

Takes the application `Msg` type which should take `TouchEvents.Touch`
as a payload

```
type Msg
  = UserSwipeStart TouchEvents.Touch

view model =
  div
    [ TouchEvents.onTouchStart UserSwipeStart
    ]
    []
```
-}
onTouchStart : (Touch -> msg) -> Attribute msg
onTouchStart msg =
  on "touchstart" <| eventDecoder msg "touches"

{-| event decoder
-}
eventDecoder : (Touch -> msg) -> String -> JD.Decoder msg
eventDecoder msg eventKey =
  JD.at [ eventKey, "0" ] (JD.map msg touchDecoder)

{-| touch decoder
-}
touchDecoder : JD.Decoder Touch
touchDecoder =
  JD.object2 Touch
    ("clientX" := JD.float)
    ("clientY" := JD.float)

{-| Lower level "touchmove" event handler
-}
onTouchMove : (Touch -> msg) -> Attribute msg
onTouchMove msg =
  on "touchmove" <| eventDecoder msg "touches"
