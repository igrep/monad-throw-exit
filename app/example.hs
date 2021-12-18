{-# LANGUAGE LambdaCase #-}

import           System.Environment     (getArgs)
import           System.Exit.MonadThrow


main :: IO ()
main = getArgs >>= \case
  ["exitWith", code] -> exitWith . ExitFailure $ read code
  ["exitFailure"] -> exitFailure
  ["exitSuccess"] -> exitSuccess
  _ -> fail "Unknown command"
