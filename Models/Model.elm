module Models.Model exposing (..)

import Http
import Route exposing (..)
import Models.TodoList exposing (..)


type alias Model =
    { route : Route
    , authToken : Maybe String
    , email : String
    , password : String
    , loginError : Maybe String
    , todoLists : List TodoList
    , navbarToggle : Bool
    , newTodoName : String
    , accountMenu : Bool
    }


type Msg
    = ChangeRoute Route
    | Click
    | LoadTokenData (Result Http.Error String)
    | GetLists (Result Http.Error (List TodoList))
    | UpdateEmail String
    | UpdatePassword String
    | Logout
    | ToggleNavbar
    | ToggleAccountMenu
    | InputNewTodoList String
    | AddTodoList
    | AddTodoListDone (Result Http.Error String)
    | UpdateTodoLists


type TestMsg
    = Testit
