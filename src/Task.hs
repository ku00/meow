module Task
    ( newTask
    , addLine
    , runTask
    ) where

import System.Directory
import System.Process (callCommand)

ext = ".meow"

generatePath :: String -> IO FilePath
generatePath fp = getHomeDirectory >>= \x -> return $ concat [x, "/.meow/tasks/", fp, ext]

initialize :: IO ()
initialize = do
    getHomeDirectory >>= setCurrentDirectory
    createDirectoryIfMissing True ".meow/tasks"

newTask :: String -> IO ()
newTask fp = generatePath fp >>= flip writeFile ""

addLine :: String -> String -> IO ()
addLine fp l = generatePath fp >>= flip appendFile (l ++ "\n")

runTask :: String -> IO ()
runTask fp = generatePath fp >>= readFile >>= callCommand
