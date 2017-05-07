{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

import Options.Generic

data SearchWord = SearchWord String deriving (Generic, Show)

instance ParseRecord SearchWord

main = do
    x <- getRecord "Find and display GIFs"
    print (x :: SearchWord)
