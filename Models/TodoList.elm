module Models.TodoList exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline


type alias TodoList =
    { id : Int
    , title : String
    }


type alias Todo =
    { id : Int }


decodeTodoLists : Decode.Decoder TodoList
decodeTodoLists =
    Json.Decode.Pipeline.decode TodoList
        |> Json.Decode.Pipeline.required "id" Decode.int
        |> Json.Decode.Pipeline.required "title" Decode.string
