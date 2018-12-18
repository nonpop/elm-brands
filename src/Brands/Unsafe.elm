module Brands.Unsafe exposing (inj, prj)

import Brands exposing (..)



--import Native.Unsafe


inj : a -> App f b
inj =
    Debug.todo "Native.Unsafe.coerce"


prj : App f b -> a
prj =
    Debug.todo "Native.Unsafe.coerce"
