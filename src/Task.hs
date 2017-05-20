module Task () where

import System.Directory
import System.Process

ext = ".meow"

generatePath :: String -> IO FilePath
generatePath fp = getHomeDirectory >>= \x -> return $ concat [x, "/.meow/tasks/", fp, ext]

initialize :: IO ()
initialize = do
    getHomeDirectory >>= setCurrentDirectory
    createDirectoryIfMissing True ".meow/tasks"

newTask :: String -> IO ()
newTask fp = generatePath fp >>= \x -> writeFile x ""

addLine :: String -> String -> IO ()
addLine fp l = generatePath fp >>= \x -> appendFile x (l ++ "\n")

runTask :: String -> IO ()
runTask fp = generatePath fp >>= readFile >>= callCommand
