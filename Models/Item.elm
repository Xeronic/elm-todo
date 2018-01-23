module Models.Item exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline


type alias Item =
    { id : Int
    , name : String
    , done : Bool
    }


decodeItem : Decode.Decoder Item
decodeItem =
    Json.Decode.Pipeline.decode Item
        |> Json.Decode.Pipeline.required "id" Decode.int
        |> Json.Decode.Pipeline.required "name" Decode.string
        |> Json.Decode.Pipeline.required "done" Decode.bool
