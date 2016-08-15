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
    , getDirectionXLestTest
    , emptyTouchText
    ]

getDirectionXRightTest =
  ET.test
    "detects the touch in the Right direction"
    (ET.assert (TE.getDirectionX 12.12 13.2 == TE.Right))

getDirectionXLestTest =
  ET.test
    "detects the touch in the Left driection"
    (ET.assert (TE.getDirectionX 13.2 12.12 == TE.Left))


emptyTouchText =
  ET.test
  "returns an empty Touch type"
  (ET.assert (TE.emptyTouch == { clientX = 0, clientY = 0}))
