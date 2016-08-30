{-# LANGUAGE TemplateHaskell #-}
module Main where

import Foreign.C

$(return [])

main :: IO ()
main = sf_error_number 0 >>= peekCString >>= putStrLn

foreign import ccall unsafe
  sf_error_number :: CInt -> IO CString
