module Main exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Html exposing (..)
import Html.Attributes exposing (class, type_, placeholder)
import Html.Events exposing (onClick, onInput, onWithOptions)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Model =
    { authToken : Maybe String
    , email : String
    , password : String
    , loginError : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( Model Nothing "" "" Nothing, Cmd.none )


type Msg
    = Click
    | LoadTokenData (Result Http.Error String)
    | UpdateEmail String
    | UpdatePassword String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ( model, Http.send LoadTokenData (postLogin model) )

        LoadTokenData (Ok string) ->
            ( { model | authToken = Just string }, Cmd.none )

        LoadTokenData (Err _) ->
            ( { model | loginError = Just "Incorrect username or password." }, Cmd.none )

        UpdateEmail string ->
            ( { model | email = string }, Cmd.none )

        UpdatePassword string ->
            ( { model | password = string }, Cmd.none )


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    let
        errorText =
            case model.loginError of
                Just string ->
                    p [ class "alert alert-danger" ] [ text string ]

                Nothing ->
                    text ""
    in
        div [ class "container" ]
            [ div [ class "login-form" ]
                [ errorText
                , div [ class "form-group" ]
                    [ label [] [ text "Username" ]
                    , input [ onInput UpdateEmail, type_ "text", class "form-control" ] []
                    ]
                , div [ class "form-group" ]
                    [ label [] [ text "Password" ]
                    , input [ onInput UpdatePassword, type_ "password", class "form-control" ] []
                    ]
                , button [ onClick Click, class "btn btn-primary float-right" ] [ text "Login" ]
                ]
            ]


postLogin : Model -> Http.Request String
postLogin model =
    let
        url =
            "http://localhost:3000/auth/login/"

        body =
            Http.jsonBody
                (Encode.object
                    [ ( "email", Encode.string model.email )
                    , ( "password", Encode.string model.password )
                    ]
                )
    in
        Http.post url body decodeToken


decodeToken =
    Decode.at [ "auth_token" ] Decode.string
