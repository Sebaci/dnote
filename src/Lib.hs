{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Lib
  ( startApp,
    app,
  )
where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

type API =
  "notes" :> Get '[JSON] [Note]

data Note = Note
  { id :: Int,
    author :: String,
    content :: String
  }
  deriving (Eq, Show)

$(deriveJSON defaultOptions ''Note)

notes :: [Note]
notes =
  [ Note 1 "First" "Sample note",
    Note 2 "Second" "Another note"
  ]

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server =
  return notes