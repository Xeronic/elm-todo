module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models.Model exposing (..)


{- Friend colors
   ,  red: dc443a
   ,  blue: 39bcec
   ,  yellow: edcb40
-}


redStyle =
    style [ ( "color", "#dc443a" ) ]


blueStyle =
    style [ ( "color", "#39bcec" ) ]


yellowStyle =
    style [ ( "color", "#edcb40" ) ]


view model =
    navbarView model


navbarView : Model -> Html Msg
navbarView model =
    nav [ class "navbar navbar-expand-lg sticky-top navbar-dark bg-dark" ]
        [ a [ class "navbar-brand", href "#" ]
            [ span [] [ text "E" ]
            , span [ redStyle ] [ text "•" ]
            , span [] [ text "l" ]
            , span [ blueStyle ] [ text "•" ]
            , span [] [ text "m" ]
            , span [ yellowStyle ] [ text "•" ]
            , span [] [ text "!" ]
            ]
        , button [ onClick ToggleNavbar, class "navbar-toggler", type_ "button" ] [ span [ class "navbar-toggler-icon" ] [] ]
        , div [ class "collapse navbar-collapse", classList [ ( "show", model.navbarToggle ) ] ]
            [ ul [ class "navbar-nav mr-auto mt-2 mt-lg-0" ]
                [ li [ class "nav-item active" ]
                    [ a [ onClick UpdateTodoLists, class "nav-link", href "#" ] [ text "Home" ]
                    ]
                , li [ class "navbar-nav mr-auto mt-2 mt-lg-0" ]
                    [ a [ class "nav-link", href "#" ] [ text "Central Perk" ]
                    ]
                ]
            , ul [ class "navbar-nav" ]
                [ li [ class "nav-item dropdown", classList [ ( "show", model.accountMenu ) ] ]
                    [ a [ onClick ToggleAccountMenu, class "nav-link dropdown-toggle", href "#" ] [ text "Account" ]
                    , div [ class "dropdown-menu", classList [ ( "show", model.accountMenu ) ] ]
                        [ a [ onClick Logout, class "dropdown-item" ] [ text "Logout" ] ]
                    ]
                ]
            ]
        ]
