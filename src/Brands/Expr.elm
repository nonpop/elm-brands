module Brands.Expr exposing (Expr(..), add, boolean, else_, eq, eval, if_, pretty, then_, val)

import Brands.Leibniz exposing (..)


type Expr a
    = Val Int (Eq Int a)
    | Boolean Bool (Eq Bool a)
    | Add (Expr Int) (Expr Int) (Eq Int a)
    | Eq (Expr Int) (Expr Int) (Eq Bool a)
    | If (Expr Bool) (Expr a) (Expr a) (Eq a a)


val : Int -> Expr Int
val n =
    Val n refl


boolean : Bool -> Expr Bool
boolean b =
    Boolean b refl


add : Expr Int -> Expr Int -> Expr Int
add e1 e2 =
    Add e1 e2 refl


eq : Expr Int -> Expr Int -> Expr Bool
eq e1 e2 =
    Eq e1 e2 refl


if_ : Expr Bool -> b -> Expr a -> b -> Expr a -> Expr a
if_ b _ true _ false =
    If b true false refl


then_ : ()
then_ =
    ()


else_ : ()
else_ =
    ()


eval : Expr a -> a
eval expr =
    case expr of
        Val n prf ->
            cast prf n

        Boolean b prf ->
            cast prf b

        Add e1 e2 prf ->
            cast prf (eval_ e1 + eval_ e2)

        Eq e1 e2 prf ->
            cast prf (eval_ e1 == eval_ e2)

        If b true false prf ->
            cast prf
                (if eval_ b then
                    eval true

                 else
                    eval false
                )


eval_ : Expr a -> a
eval_ =
    eval


pretty : Expr a -> String
pretty expr =
    case expr of
        Val n prf ->
            String.fromInt n

        Boolean b prf ->
            case b of
                True ->
                    "True"

                False ->
                    "False"

        Add e1 e2 _ ->
            "(" ++ pretty_ e1 ++ " + " ++ pretty_ e2 ++ ")"

        Eq e1 e2 _ ->
            "(" ++ pretty_ e1 ++ " == " ++ pretty_ e2 ++ ")"

        If b true false _ ->
            "if " ++ pretty_ b ++ " then " ++ pretty true ++ " else " ++ pretty false


pretty_ : Expr a -> String
pretty_ =
    pretty
