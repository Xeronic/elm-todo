port module Ports exposing (..)

import Models.Model exposing (..)


port setAuthToken : String -> Cmd msg


port logout : String -> Cmd msg
