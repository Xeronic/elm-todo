module Requests.Login exposing (..)

import Http
import Models.Model exposing (Model)
import Json.Decode as Decode
import Json.Encode as Encode


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


decodeToken : Decode.Decoder String
decodeToken =
    Decode.at [ "auth_token" ] Decode.string
