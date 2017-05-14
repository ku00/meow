module Main where

import Options.Applicative
import Data.Semigroup ((<>))

type Project = String

data Command = New Project deriving (Show)

withInfo :: Parser a -> String -> ParserInfo a
withInfo opts desc = info (helper <*> opts) $ progDesc desc

parseNew :: Parser Command
parseNew = New
    <$> argument str (metavar "PROJECT_NAME")

parseCommand :: Parser Command
parseCommand = subparser $
    command "new" (parseNew `withInfo` "Create a project.")

parseInfo :: ParserInfo Command
parseInfo = parseCommand `withInfo` "Meow is a command group management tool."

main :: IO ()
main = print =<< execParser parseInfo
