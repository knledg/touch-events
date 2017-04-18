module Tests exposing (..)

import TouchEvents as TE
import Test as ET
import Expect
import Fuzz


touchEventsTests : ET.Test
touchEventsTests =
    ET.describe "Touch Event Test Suite"
        [ getXDirectionTest
        , getYDirectionTest
        , emptyTouchText
        ]


getXDirectionTest =
    ET.fuzz2 Fuzz.float Fuzz.float "detects the touch direction on the x-axis"
        <| \n1 n2 ->
            case n1 > n2 of
                True ->
                    Expect.true "Expected swiping left to return a Left TouchEvent"
                        (TE.getDirectionX n1 n2 == TE.Left)

                False ->
                    Expect.true "Expected swiping right to return a Right TouchEvent"
                        (TE.getDirectionX n1 n2 == TE.Right)


getYDirectionTest =
    ET.fuzz2 Fuzz.float Fuzz.float "detects the touch direction on the y-axis"
        <| \n1 n2 ->
            case n1 > n2 of
                True ->
                    Expect.true "Expected swiping up to return an Up TouchEvent"
                        (TE.getDirectionY n1 n2 == TE.Up)

                False ->
                    Expect.true "Expected swiping down to return a Down TouchEvent"
                        (TE.getDirectionY n1 n2 == TE.Down)


emptyTouchText =
    ET.test "returns an empty Touch type"
        <| \() ->
            (Expect.true "Expected an empty touch to have x and y values of 0"
                (TE.emptyTouch == { clientX = 0, clientY = 0 })
            )
