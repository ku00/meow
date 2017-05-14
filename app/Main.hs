module Main where

import Options.Applicative
import Data.Semigroup ((<>))

type Task = String
type Line = String

data Command
    = New Task
    | Add Task Line
    deriving (Show)

withInfo :: Parser a -> String -> ParserInfo a
withInfo opts desc = info (helper <*> opts) $ progDesc desc

parseNew :: Parser Command
parseNew = New <$> argument str (metavar "[TASK_NAME]")

parseAdd :: Parser Command
parseAdd = Add
    <$> argument str (metavar "[TARGET_TASK_NAME]")
    <*> argument str (metavar "[TASK_LINE]")

parseCommand :: Parser Command
parseCommand = subparser $
    command "new" (parseNew `withInfo` "Create a task") <>
    command "add" (parseAdd `withInfo` "Add a task line")

parseInfo :: ParserInfo Command
parseInfo = parseCommand `withInfo` "Meow is a command group management tool"

main :: IO ()
main = print =<< execParser parseInfo
