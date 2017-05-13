module Main where

import Options.Applicative
import Data.Semigroup ((<>))

data NewCmd = NewCmd { newProject :: String } deriving (Show)

-- data AddCmd = AddCmd { targetProject :: String, task :: String } deriving (Show)
--
-- data RunCmd = RunCmd { runProject :: String } deriving (Show)

data Commands = Commands
    {
      newCmd :: NewCmd
    -- , addCmd :: AddCmd
    -- , runCmd :: RunCmd
    } deriving (Show)

commands :: Parser Commands
commands = Commands
    <$> subparser (command "new" new)
    -- <*> subparser (command "add" add)
    -- <*> subparser (command "run" run)

newOpt :: Parser NewCmd
newOpt = NewCmd
    <$> projectNameOpt
    where
      projectNameOpt :: Parser String
      projectNameOpt = strOption
          ( short 'p'
         <> long "PROJECT_NAME"
         <> help "A project name."
         <> metavar "[PROJECT_NAME]" )

new :: ParserInfo NewCmd
new = info (helper <*> newOpt)
    ( fullDesc
   <> progDesc "new desc"
   <> header "new header" )

-- add :: ParserInfo AddCmd
--
-- run :: ParserInfo RunCmd

parseInfo :: ParserInfo Commands
parseInfo = info (helper <*> commands)
    ( fullDesc
   <> progDesc "main desc"
   <> header "main header" )

main = print =<< execParser parseInfo
