module Requests.TodoList exposing (..)

import Http
import Json.Decode as Decode


getTodoLists : String -> Decode.Decoder a -> Http.Request (List a)
getTodoLists token decoder =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" token ]
        , url = "http://localhost:3000/todos"
        , body = Http.emptyBody
        , expect = Http.expectJson (Decode.list decoder)
        , timeout = Nothing
        , withCredentials = False
        }
