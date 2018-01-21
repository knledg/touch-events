module SwipeExample exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import TouchEvents


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }


type alias Model =
    { lastTouch : TouchEvents.Touch
    , direction : Maybe TouchEvents.Direction
    }


type Msg
    = OnTouchStart TouchEvents.Touch
    | OnTouchEnd TouchEvents.Touch


init : Model
init =
    { lastTouch = TouchEvents.Touch 0 0
    , direction = Nothing
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        OnTouchStart touchEvent ->
            { model
                | lastTouch = touchEvent
            }

        OnTouchEnd touchEvent ->
            { model
                | lastTouch = touchEvent
                , direction =
                    TouchEvents.getDirection model.lastTouch touchEvent
            }


view : Model -> Html Msg
view model =
    div
        []
        [ div
            [ style divStyle
            , TouchEvents.onTouchEvent TouchEvents.TouchStart OnTouchStart
            , TouchEvents.onTouchEvent TouchEvents.TouchEnd OnTouchEnd
            ]
            []
        , span [ style [ ( "display", "block" ) ] ] [ text <| toString model ]
        ]


divStyle : List ( String, String )
divStyle =
    [ ( "width", "100%" )
    , ( "height", "400px" )
    , ( "background-color", "blue" )
    ]
