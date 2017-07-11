module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = model
        , update = update
        , view = view
        }


type alias Model =
    { selectedImg : String }


model : Model
model =
    Model "https://source.unsplash.com/3Z70SDuYs5g/800x600"


type Msg
    = NoOp
    | SelectImg String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        SelectImg url ->
            { model | selectedImg = url }


view : Model -> Html Msg
view model =
    div [ class "main-container" ]
        [ h1 [] [ text "Photo Gallery" ]
        , renderSelectedImg model.selectedImg
        , renderThumbnail
        ]


renderSelectedImg : String -> Html Msg
renderSelectedImg url =
    div [ class "selected-img" ]
        [ renderImg
            url
        ]


renderThumbnail : Html Msg
renderThumbnail =
    div [ class "grid" ]
        (imgUrls
            |> List.map renderImg
        )


renderImg : String -> Html Msg
renderImg url =
    div [ class "grid-item" ]
        [ img
            [ src url
            , onClick (SelectImg url)
            ]
            []
        ]


imgUrls : List String
imgUrls =
    [ "https://source.unsplash.com/3Z70SDuYs5g/800x600"
    , "https://source.unsplash.com/01vFmYAOqQ0/800x600"
    , "https://source.unsplash.com/2Bjq3A7rGn4/800x600"
    , "https://source.unsplash.com/t20pc32VbrU/800x600"
    ]
