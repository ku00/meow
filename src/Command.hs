module Command (execCommand) where

import Options.Applicative
import Data.Semigroup ((<>))

import Task

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

run :: Command -> IO ()
run cmd = case cmd of
              New t -> newTask t
              Add t l -> addLine t l
              Run t -> runTask t

execCommand :: IO ()
execCommand = execParser parseInfo >>= run
