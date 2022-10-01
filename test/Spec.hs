{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Main (main) where

import Lib (app)
import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.JSON

main :: IO ()
main = hspec spec

spec :: Spec
spec = with (return app) $ do
  describe "GET /notes" $ do
    it "responds with 200" $ do
      get "/notes" `shouldRespondWith` 200
    it "responds with [note]" $ do
      let notes = "[{\"id\":1,\"author\":\"First\",\"content\":\"Sample note\"},{\"id\":2,\"author\":\"Second\",\"content\":\"Another note\"}]"
      get "/notes" `shouldRespondWith` notes
