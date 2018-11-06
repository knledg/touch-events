port module Main exposing (main)

import Console.Text exposing (UseColor(..))
import Json.Encode as JE
import Test.Reporter.Reporter exposing (Report(..))
import Test.Runner.Node as TRN
import Tests


main : TRN.TestProgram
main =
    TRN.run
        { seed = 1
        , runs = Nothing
        , report = ConsoleReport UseColor
        , paths = []
        , processes = 1
        }
        Tests.touchEventsTests
