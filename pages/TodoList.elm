module Pages.TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


view model =
    div [ class "container" ]
        [ ul [ class "list-group" ]
            [ li [ class "list-group-item" ] [ text "hej" ]
            ]
        ]
