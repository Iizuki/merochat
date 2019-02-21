module Main where

import Prelude (($), bind)

import Effect.Console as C
import HTTPure as H
import Response as R
import HTTPure(ServerM)
import Template.Landing as L
import Configuration as CF
import Effect.Class as E

--TODO config files

main :: ServerM
main = do
        config <- CF.readConfiguration
        H.serve 8000 router $ C.log "Server now up on port 8000"
        where router { path : [] } = do
                      html <- E.liftEffect L.landing
                      R.html html
              router _ = H.notFound