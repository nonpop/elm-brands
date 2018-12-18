module Brands.Html exposing (HtmlB(..), functor, inj, monoid, prj, semigroup)

import Brands exposing (..)
import Brands.Functor exposing (..)
import Brands.Monoid exposing (..)
import Brands.Semigroup exposing (..)
import Brands.Unsafe exposing (..)
import Html exposing (Html, div, text)


type HtmlB
    = HtmlB


functor : Functor HtmlB a b
functor =
    { map =
        \f ->
            inj << Html.map f << prj
    }


semigroup : Semigroup (Html a)
semigroup =
    { concat =
        \x y ->
            div [] [ x, y ]
    }


monoid : Monoid (Html a)
monoid =
    { concat = semigroup.concat
    , empty = text ""
    }


inj : Html a -> App HtmlB a
inj =
    Brands.Unsafe.inj


prj : App HtmlB a -> Html a
prj =
    Brands.Unsafe.prj
