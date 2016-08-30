{-# LANGUAGE TemplateHaskell #-}
module Main where

import Foreign.C
import TheDep

$(return [])

main :: IO ()
main = sf_error_number 0 >>= peekCString >>= putStrLn
