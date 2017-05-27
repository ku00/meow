module Task
    ( TaskName
    , TaskLine
    , newTask
    , addLine
    , runTask
    ) where

import System.Directory
import System.Process (callCommand)

type TaskName = String
type TaskLine = String

ext = ".meow"

generatePath :: String -> IO FilePath
generatePath fp = getHomeDirectory >>= \x -> return $ concat [x, "/.meow/tasks/", fp, ext]

initialize :: IO ()
initialize = do
    getHomeDirectory >>= setCurrentDirectory
    createDirectoryIfMissing True ".meow/tasks"

newTask :: TaskName -> IO ()
newTask fp = generatePath fp >>= flip writeFile ""

addLine :: TaskName -> TaskLine -> IO ()
addLine fp l = generatePath fp >>= flip appendFile (l ++ "\n")

runTask :: TaskName -> IO ()
runTask fp = generatePath fp >>= readFile >>= callCommand
