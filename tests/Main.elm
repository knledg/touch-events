module Main exposing (..)

import ElmTest as ET
import TouchEvents as TE


main : Program Never
main =
    ET.runSuiteHtml touchEventsTests


touchEventsTests : ET.Test
touchEventsTests =
    ET.suite "Touch Event Test Suite"
        [ getDirectionXRightTest
        , getDirectionXLeftTest
        , getDirectionYUpTest
        , getDirectionYDownTest
        , emptyTouchText
        ]


getDirectionXRightTest =
    ET.test
        "detects the touch in the Right direction"
        (ET.assert (TE.getDirectionX 12.12 13.2 == TE.Right))


getDirectionXLeftTest =
    ET.test
        "detects the touch in the Left direction"
        (ET.assert (TE.getDirectionX 13.2 12.12 == TE.Left))


getDirectionYUpTest =
    ET.test
        "detects the touch in the Up direction"
        (ET.assert (TE.getDirectionY 13.2 12.12 == TE.Up))


getDirectionYDownTest =
    ET.test
        "detects the touch in the Down direction"
        (ET.assert (TE.getDirectionY 12.12 13.2 == TE.Down))


emptyTouchText =
    ET.test
        "returns an empty Touch type"
        (ET.assert (TE.emptyTouch == { clientX = 0, clientY = 0 }))
