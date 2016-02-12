module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp
import Signal exposing (Address)
import Characters exposing (characterList)
import Maybe
import List


-- # Main


main =
    StartApp.start { model = model, view = view, update = update }



-- # Model


type alias Model =
    { name : String
    , match : String
    }


model : Model
model =
    { name = ""
    , match = ""
    }



-- # Actions


update : Action -> Model -> Model
update action model =
    case action of
        NoOp ->
            model

        UpdateName str ->
            { model | name = str }

        GenMatch ->
            { model | match = Maybe.withDefault "Nobody, sorry" (List.head characterList) }



-- # View


type Action
    = UpdateName String
    | GenMatch
    | NoOp


topBar =
    div
        [ class "navbar-inverse navbar" ]
        [ div
            [ class "navbar-header" ]
            [ div [ class "navbar-brand" ] [ text "THE LOVE MAKER" ] ]
        ]


view : Address Action -> Model -> Html
view address model =
    div
        [ class "container form-inline" ]
        [ topBar
        , input
            [ type' "text"
            , value model.name
            , class "form-control"
            , on "input" targetValue (\str -> Signal.message address (UpdateName str))
            ]
            []
        , button
            [ class "btn btn-primary"
            , onClick address GenMatch
            ]
            [ text "WHO DO I MATCH wiTH???" ]
        , div [] [ text ("You match with: " ++ model.match) ]
        ]
