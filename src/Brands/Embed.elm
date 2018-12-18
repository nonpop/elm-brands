module Brands.Embed exposing (Embed(..), embed, inj, prj, run)

import Brands exposing (..)


type Embed f a
    = Embed (App f a)


embed : App f a -> Embed f a
embed =
    Embed


run : Embed f a -> App f a
run (Embed x) =
    x


inj : a -> Embed f a
inj =
    embed << Brands.Unsafe.inj


prj : Embed f a -> a
prj =
    Brands.Unsafe.prj << run
