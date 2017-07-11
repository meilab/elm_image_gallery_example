module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onInput, onClick)
import Json.Decode as JD
import Http


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { selectedImg : String
    , topic : String
    , urls : List String
    }


initModel : Model
initModel =
    { selectedImg = "https://source.unsplash.com/3Z70SDuYs5g/800x600"
    , topic = "cat"
    , urls = []
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, getRandomPicCmd )


type Msg
    = NoOp
    | SelectImg String
    | TopicChange String
    | GetPics
    | NewPics (Result Http.Error (List String))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SelectImg url ->
            ( { model | selectedImg = url }, Cmd.none )

        TopicChange topic ->
            ( { model | topic = topic }, Cmd.none )

        GetPics ->
            ( model, getPictureCmd model.topic )

        NewPics (Err error) ->
            ( model, Cmd.none )

        NewPics (Ok ids) ->
            let
                urls =
                    ids
                        |> List.map (\id -> "https://source.unsplash.com/" ++ id ++ "/800x600")
            in
                ( { model | urls = urls }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


client_id : String
client_id =
    "430384107c5613959082cc50ae297ef99801bfe565cfc399d5d0ab743fa1fb81"


getPictureCmd : String -> Cmd Msg
getPictureCmd topic =
    let
        url =
            "https://api.unsplash.com/search/photos/"
                ++ "?query="
                ++ topic
                ++ "&client_id="
                ++ client_id
    in
        Http.send NewPics (Http.get url picsDecoder)


picsDecoder : JD.Decoder (List String)
picsDecoder =
    JD.at [ "results" ] (JD.list itemDecoder)


getRandomPicCmd : Cmd Msg
getRandomPicCmd =
    let
        url =
            "https://api.unsplash.com/photos/random/"
                ++ "?count=10"
                ++ "&client_id="
                ++ client_id
    in
        Http.send NewPics (Http.get url randomPicDecoder)


randomPicDecoder : JD.Decoder (List String)
randomPicDecoder =
    JD.list itemDecoder


itemDecoder : JD.Decoder String
itemDecoder =
    JD.at [ "id" ] JD.string


view : Model -> Html Msg
view model =
    div [ class "main-container" ]
        [ h1 [] [ text "Photo Gallery" ]
        , topicSelector
        , renderSelectedImg model.selectedImg
        , renderThumbnail model
        ]


topicSelector : Html Msg
topicSelector =
    div [ class "topic-selector" ]
        [ label [] [ text "主题" ]
        , input [ onInput TopicChange ] []
        , button [ onClick GetPics ] [ text "搜索" ]
        ]


renderSelectedImg : String -> Html Msg
renderSelectedImg url =
    div [ class "selected-img" ]
        [ renderImg
            url
        ]


renderThumbnail : Model -> Html Msg
renderThumbnail model =
    div [ class "grid" ]
        (model.urls
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
