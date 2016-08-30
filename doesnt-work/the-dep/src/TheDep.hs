module TheDep where

import Foreign.C

foreign import ccall unsafe
  sf_error_number :: CInt -> IO CString
