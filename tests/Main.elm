port module Main exposing (..)

import Tests
import Test.Runner.Node as TRN
import Json.Encode as JE


port emit : ( String, JE.Value ) -> Cmd msg


main : TRN.TestProgram
main =
    TRN.run emit Tests.touchEventsTests
