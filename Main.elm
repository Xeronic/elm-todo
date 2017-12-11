module Main exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Html exposing (..)
import Html.Attributes exposing (class, type_, placeholder)
import Html.Events exposing (onClick, onWithOptions)


main : Program Never Model Msg
main =
    Html.program { init = ( 1, Cmd.none ), view = view, update = update, subscriptions = subscriptions }


type alias Model =
    Int


type Msg
    = Click
    | LoadTokenData (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ( model, Http.send LoadTokenData loginRequest )

        LoadTokenData (Ok string) ->
            ( model, Cmd.none )

        LoadTokenData (Err _) ->
            ( model, Cmd.none )


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


view : model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "login-form" ]
            [ div [ class "form-group" ]
                [ label [] [ text "Username" ]
                , input [ type_ "text", class "form-control" ] []
                ]
            , div [ class "form-group" ]
                [ label [] [ text "Password" ]
                , input [ type_ "password", class "form-control" ] []
                ]
            , button [ onClick Click, class "btn btn-primary float-right" ] [ text "Login" ]
            ]
        ]


loginRequest : Http.Request str
loginRequest str =
    let
        email =
            "jerry.ck.pedersen@gmail.com"

        password =
            "nisse123"
    in
        { verb = "POST"
        , headers =
            [ ( "Origin", "*" )
            , ( "Access-Control-Request-Method", "POST" )
            , ( "Access-Control-Request-Headers", "X-Custom-Header" )
            ]
        , url = "http://localhost:3000/auth/login/"
        , body =
            Http.jsonBody
                (Encode.object
                    [ ( "email", Encode.string email )
                    , ( "password", Encode.string password )
                    ]
                )
        }


decodeToken =
    Decode.at [ "data", "image_url" ] Decode.string
