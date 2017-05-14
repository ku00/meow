module Main where

import Options.Applicative
import Data.Semigroup ((<>))

data NewCmd = NewCmd { newProject :: String } deriving (Show)

data AddCmd = AddCmd { targetProject :: String, task :: String } deriving (Show)

-- data RunCmd = RunCmd { runProject :: String } deriving (Show)

data Commands = Commands
    {
      newCmd :: NewCmd
    , addCmd :: AddCmd
    -- , runCmd :: RunCmd
    } deriving (Show)

commands :: Parser Commands
commands = Commands
    <$> subparser (command "new" new)
    <*> subparser (command "add" add)
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

addOpt :: Parser AddCmd
addOpt = AddCmd
    <$> projectNameOpt
    <*> taskStr
    where
        projectNameOpt :: Parser String
        projectNameOpt = strOption
            ( short 'p'
           <> long "TARGET"
           <> help "A target project" )

        taskStr :: Parser String
        taskStr = strOption
            ( short 't'
           <> long "task"
           <> help "Add a task line." )

add :: ParserInfo AddCmd
add = info (helper <*> addOpt)
    ( fullDesc
   <> progDesc "add desc"
   <> header "add header" )

-- run :: ParserInfo RunCmd

parseInfo :: ParserInfo Commands
parseInfo = info (helper <*> commands)
    ( fullDesc
   <> progDesc "main desc"
   <> header "main header" )

main = print =<< execParser parseInfo
