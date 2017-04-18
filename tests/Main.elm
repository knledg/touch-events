port module Main exposing (..)

import TouchEvents as TE
import Tests
import Test as ET
import Expect
import Fuzz
import Test.Runner.Node as TRN
import Json.Encode as JE


port emit : ( String, JE.Value ) -> Cmd msg


main : TRN.TestProgram
main =
    TRN.run emit Tests.touchEventsTests
