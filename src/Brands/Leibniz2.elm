module Leibniz2 exposing (Eq)


type App f a
    = App f a


type EqB
    = EqB


type alias Eq a b =
    App (App EqB a) b


type Leibniz f a b
    = Leibniz (App f a -> App f b)


coe : Leibniz f a b -> (App f a -> App f b)
coe (Leibniz f) =
    f


refl : Leibniz f a a
refl =
    Leibniz (\a -> a)


type Identity
    = Identity


identity : a -> App Identity a
identity a =
    App Identity a


unIdentity : App Identity a -> a
unIdentity (App _ a) =
    a


coerce : Leibniz f a b -> a -> b
coerce p a =
    unIdentity (coeP (identity a))


coeP : Leibniz f a b -> App f a -> App f b
coeP p =
    coe p



{-

   p : Leibniz f a b
   coe p : App f a -> App f b
   a : a
   identity a : App Identity a

-}
