module Main where

import Command

main :: IO ()
main = print =<< execCommand
