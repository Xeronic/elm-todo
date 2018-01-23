module Route exposing (..)

import Models.TodoList


type Route
    = Login
    | Home
    | TodoList Models.TodoList.TodoList
