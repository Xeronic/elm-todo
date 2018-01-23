module Update exposing (update)

import Http
import Models.Model exposing (..)
import Models.TodoList exposing (..)
import Route exposing (..)
import Requests.Login exposing (postLogin)
import Requests.TodoList exposing (getTodoLists, addTodoList)
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddTodoList ->
            case model.authToken of
                Nothing ->
                    ( model, Cmd.none )

                Just token ->
                    ( model, Http.send AddTodoListDone (addTodoList token model.newTodoName) )

        AddTodoListDone (Ok string) ->
            ( model, Cmd.none )

        AddTodoListDone (Err _) ->
            ( model, Cmd.none )

        ChangeRoute route ->
            ( { model | route = route }, Cmd.none )

        Click ->
            ( model, Http.send LoadTokenData (postLogin model) )

        InputNewTodoList todoName ->
            ( { model | newTodoName = todoName }, Cmd.none )

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

        UpdateTodoLists ->
            case model.authToken of
                Nothing ->
                    ( model, Cmd.none )

                Just token ->
                    ( model, Http.send GetLists (getTodoLists token decodeTodoLists) )

        Logout ->
            ( { model | authToken = Nothing, route = Login, todoLists = [], accountMenu = False }, Ports.logout "logout" )

        ToggleNavbar ->
            ( { model | navbarToggle = not model.navbarToggle }, Cmd.none )

        ToggleAccountMenu ->
            ( { model | accountMenu = not model.accountMenu }, Cmd.none )
