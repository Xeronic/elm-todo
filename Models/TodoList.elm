module Models.TodoList exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline
import Models.Item exposing (..)


type alias TodoList =
    { id : Int
    , title : String
    , items : List Item
    }


decodeTodoLists : Decode.Decoder TodoList
decodeTodoLists =
    Json.Decode.Pipeline.decode TodoList
        |> Json.Decode.Pipeline.required "id" Decode.int
        |> Json.Decode.Pipeline.required "title" Decode.string
        |> Json.Decode.Pipeline.required "items" (Decode.list decodeItem)
