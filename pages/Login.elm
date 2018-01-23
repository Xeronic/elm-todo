module Pages.Login exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Models.Model exposing (..)
import Views.Navbar exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ (loginView model)
        ]


loginView : Model -> Html Msg
loginView model =
    let
        errorText =
            case model.loginError of
                Just string ->
                    p [ class "alert alert-danger" ] [ text string ]

                Nothing ->
                    text ""
    in
        div [ class "login-container" ]
            [ Html.form [ onSubmit Click, class "login-form" ]
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
