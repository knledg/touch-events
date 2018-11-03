module SwipeExample exposing (Model, Msg(..), divStyle, init, main, update, view)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (style)
import TouchEvents as TE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { touchPositionX : Maybe Float
    , touchPositionY : Maybe Float
    , direction : Maybe TE.Direction
    }


type Msg
    = OnTouchStart TE.Touch
    | OnTouchEnd TE.Touch


init : Model
init =
    { touchPositionX = Nothing
    , touchPositionY = Nothing
    , direction = Nothing
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        OnTouchStart touchEvent ->
            { model
                | touchPositionX = Just touchEvent.clientX
                , touchPositionY = Just touchEvent.clientY
            }

        OnTouchEnd touchEvent ->
            { model
                | touchPositionX = Just touchEvent.clientX
                , touchPositionY = Just touchEvent.clientY
                , direction =
                    model.touchPositionX `Maybe.andThen` (\x -> Just <| TE.getDirectionX x touchEvent.clientX)
            }


view : Model -> Html Msg
view model =
    div
        []
        [ div
            [ style divStyle
            , TE.onTouchEvent TE.TouchStart OnTouchStart
            , TE.onTouchEvent TE.TouchEnd OnTouchEnd
            ]
            []
        , span [ style "display" "block" ] [ text <| toString model ]
        ]


divStyle : List ( String, String )
divStyle =
    [ ( "width", "100%" )
    , ( "height", "400px" )
    , ( "background-color", "blue" )
    ]
