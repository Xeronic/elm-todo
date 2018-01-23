module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onMouseUp, onMouseDown, onWithOptions)
import Html.Attributes exposing (style)
import Json.Decode as Decode


main : Program Never Model Msg
main =
    Html.program { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Todo =
    { id : Int
    , task : String
    , listId : Int
    }


type alias TodoList =
    { id : Int, todos : List Todo }


type alias Model =
    { todoLists : List TodoList
    , activeTodo : Maybe Todo
    , actionMessage : String
    }


init : ( Model, Cmd msg )
init =
    ( { todoLists =
            [ TodoList 0 [ Todo 0 "Testing" 0 ]
            , TodoList 1 [ Todo 1 "Test2" 1 ]
            ]
      , activeTodo = Nothing
      , actionMessage = ""
      }
    , Cmd.none
    )


type Msg
    = MouseUp
    | SetActiveTodo Todo
    | OnMouseUp (Maybe Int)


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        MouseUp ->
            ( model, Cmd.none )

        SetActiveTodo todo ->
            let
                newLists =
                    List.map
                        (\list ->
                            if list.id == todo.listId then
                                { list | todos = (List.filter (\item -> item /= todo) list.todos) }
                            else
                                list
                        )
                        model.todoLists
            in
                ( { model | activeTodo = Just todo, todoLists = newLists }, Cmd.none )

        OnMouseUp Nothing ->
            let
                newLists =
                    List.map
                        (\list ->
                            case model.activeTodo of
                                Nothing ->
                                    list

                                Just todo ->
                                    if list.id == todo.listId then
                                        { list | todos = todo :: list.todos }
                                    else
                                        list
                        )
                        model.todoLists
            in
                ( { model | todoLists = newLists, activeTodo = Nothing, actionMessage = "Dropped outside" }, Cmd.none )

        OnMouseUp (Just n) ->
            let
                newTodoLists =
                    List.map
                        (\list ->
                            if list.id == n then
                                case model.activeTodo of
                                    Nothing ->
                                        list

                                    Just todo ->
                                        { list | todos = (Todo todo.id todo.task n) :: list.todos }
                            else
                                list
                        )
                        model.todoLists
            in
                ( { model | todoLists = newTodoLists, activeTodo = Nothing, actionMessage = "Dropped on list" }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ onMouseUp (OnMouseUp Nothing), style [ ( "height", "100vh" ), ( "width", "100%" ) ] ]
        [ p [] [ text model.actionMessage ]
        , div [] (List.map renderListView model.todoLists)
        , div [] [ text ("Active todo: " ++ (toString model.activeTodo)) ]
        ]


renderListView todoList =
    let
        todoListView =
            List.map (\todo -> li [ onMouseDown (SetActiveTodo todo) ] [ text todo.task ]) todoList.todos
    in
        ul
            [ onWithOptions
                "mouseup"
                { stopPropagation = True, preventDefault = True }
                (Decode.succeed <| OnMouseUp <| Just todoList.id)
            , style [ ( "min-height", "10px" ), ( "border", "1px dashed" ) ]
            ]
            todoListView


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none
