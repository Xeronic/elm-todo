module Update exposing (update)

import Http
import Models.Model exposing (..)
import Models.TodoList exposing (..)
import Route exposing (..)
import Requests.Login exposing (postLogin)
import Requests.TodoList exposing (getTodoLists)
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeRoute route ->
            ( { model | route = route }, Cmd.none )

        Click ->
            ( model, Http.send LoadTokenData (postLogin model) )

        LoadTokenData (Ok string) ->
            ( { model | authToken = Just string, route = Home }
            , Cmd.batch
                [ Http.send GetLists (getTodoLists string decodeTodoLists), Ports.setAuthToken string ]
            )

        LoadTokenData (Err _) ->
            ( { model | loginError = Just "Incorrect username or password." }, Cmd.none )

        GetLists (Ok lists) ->
            ( { model | todoLists = lists }, Cmd.none )

        GetLists (Err _) ->
            ( model, Cmd.none )

        UpdateEmail string ->
            ( { model | email = string }, Cmd.none )

        UpdatePassword string ->
            ( { model | password = string }, Cmd.none )

        Logout ->
            ( { model | authToken = Nothing, route = Login, todoLists = [], accountMenu = False }, Ports.logout "logout" )

        ToggleNavbar ->
            ( { model | navbarToggle = not model.navbarToggle }, Cmd.none )

        ToggleAccountMenu ->
            ( { model | accountMenu = not model.accountMenu }, Cmd.none )
