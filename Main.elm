module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Models.Model exposing (..)
import Models.TodoList exposing (..)
import Pages.Home
import Pages.Login
import Pages.TodoList
import Requests.TodoList exposing (..)
import Route exposing (..)
import Update exposing (update)
import Views.Navbar


main : Program Flags Model Msg
main =
    Html.programWithFlags { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Flags =
    { authToken : Maybe String }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        config =
            case flags.authToken of
                Nothing ->
                    { route = Login, cmd = Cmd.none }

                Just token ->
                    { route = Home, cmd = Http.send GetLists (getTodoLists token decodeTodoLists) }
    in
        ( { route = config.route
          , authToken = flags.authToken
          , email = ""
          , newTodoName = ""
          , password = ""
          , loginError = Nothing
          , todoLists = []
          , navbarToggle = False
          , accountMenu = False
          }
        , config.cmd
        )


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div
        []
        [ Views.Navbar.view model
        , showBreadcrumb model
        , mainContent model
        ]


mainContent model =
    case model.route of
        Login ->
            Pages.Login.view model

        Home ->
            Pages.Home.view model

        TodoList int ->
            Pages.TodoList.view model


showBreadcrumb model =
    case model.route of
        Login ->
            text ""

        TodoList int ->
            ol [ class "breadcrumb" ]
                [ li [ onClick (ChangeRoute Home), class "breadcrumb-item" ] [ a [ href "#" ] [ text "Home" ] ]
                , li [ class "breadcrumb-item active" ] [ text "" ]
                ]

        _ ->
            ol [ class "breadcrumb" ]
                [ li [ class "breadcrumb-item active" ] [ text "Home" ]
                ]
