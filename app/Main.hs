module Main where

import Options.Applicative
import Data.Semigroup ((<>))

type Task = String
type Line = String

data Command
    = New Task
    | Add Task Line
    | Run Task
    deriving (Show)

parseNew :: Parser Command
parseNew = New <$> argument str (metavar "[TASK_NAME]")

parseAdd :: Parser Command
parseAdd = Add
    <$> argument str (metavar "[TARGET_TASK_NAME]")
    <*> argument str (metavar "[TASK_LINE]")

parseRun :: Parser Command
parseRun = Run <$> argument str (metavar "[TARGET_TASK_NAME]")

withInfo :: Parser a -> String -> ParserInfo a
withInfo opts desc = info (helper <*> opts) $ progDesc desc

parseCommand :: Parser Command
parseCommand = subparser $
    command "new" (parseNew `withInfo` "Create a task") <>
    command "add" (parseAdd `withInfo` "Add a task line") <>
    command "run" (parseRun `withInfo` "Run a task")

parseInfo :: ParserInfo Command
parseInfo = parseCommand `withInfo` "Meow is a command group management tool"

main :: IO ()
main = print =<< execParser parseInfo
