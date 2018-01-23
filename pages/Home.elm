module Pages.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models.TodoList exposing (..)
import Models.Model exposing (..)
import Route exposing (..)
import Views.Navbar


view : Model -> Html Msg
view model =
    div []
        [ div [ class "container" ]
            [ div [ class "row" ]
                [ div [ class "col" ]
                    [ Html.form []
                        [ div [ class "input-group mb-3" ]
                            [ input [ class "form-control", placeholder "Name of your todo list" ] []
                            , div [ class "input-group-append" ] [ button [ class "btn btn-outline-secondary" ] [ text "Create todo list" ] ]
                            ]
                        ]
                    ]
                ]
            , div [ class "row" ] [ div [ class "col" ] [ h3 [] [ text "Your lists: " ] ] ]
            , div [ class "row" ]
                [ div [ class "col" ]
                    [ ul [ class "list-group" ] (List.map todoListView model.todoLists)
                    ]
                ]
            ]
        ]


todoListView : TodoList -> Html Msg
todoListView todoList =
    li [ onClick (ChangeRoute (Route.TodoList todoList)), class "list-group-item" ] [ text (toString todoList.id ++ todoList.title) ]
