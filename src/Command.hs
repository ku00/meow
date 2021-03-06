module Command (execCommand) where

import Options.Applicative
import Data.Semigroup ((<>))

import Task

data Command
  = Init
  | New TaskName
  | Add TaskName TaskLine
  | Run TaskName
  deriving (Show)

parseInit :: Parser Command
parseInit = pure Init

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
  command "init" (parseInit `withInfo` "Create task file directories") <>
  command "new" (parseNew `withInfo` "Create a task") <>
  command "add" (parseAdd `withInfo` "Add a task line") <>
  command "run" (parseRun `withInfo` "Run a task")

parseInfo :: ParserInfo Command
parseInfo = parseCommand `withInfo` "Meow is the command group (task) management tool"

execCommand :: IO ()
execCommand = execParser parseInfo >>= run
  where run cmd = case cmd of
                    Init -> initialize
                    New t -> newTask t
                    Add t l -> addLine t l
                    Run t -> runTask t
