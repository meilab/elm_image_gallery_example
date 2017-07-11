module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, class)


main : Html msg
main =
    div [ class "main-container" ]
        [ h1 [] [ text "Photo Gallery" ]
        , renderSelectedImg "https://source.unsplash.com/3Z70SDuYs5g/800x600"
        , renderThumbnail
        ]


renderSelectedImg : String -> Html msg
renderSelectedImg url =
    div [ class "selected-img" ]
        [ renderImg
            url
        ]


renderThumbnail : Html msg
renderThumbnail =
    div [ class "grid" ]
        (imgUrls
            |> List.map renderImg
        )


renderImg : String -> Html msg
renderImg url =
    div [ class "grid-item" ]
        [ img
            [ src url ]
            []
        ]


imgUrls : List String
imgUrls =
    [ "https://source.unsplash.com/3Z70SDuYs5g/800x600"
    , "https://source.unsplash.com/01vFmYAOqQ0/800x600"
    , "https://source.unsplash.com/2Bjq3A7rGn4/800x600"
    , "https://source.unsplash.com/t20pc32VbrU/800x600"
    ]
