-- | Functions to exit the program anywhere in MonadThrow monads.
module System.Exit.MonadThrow
  ( exitWith
  , exitFailure
  , exitSuccess
  -- * Re-export from the original @System.Exit@ module.
  , ExitCode (ExitSuccess, ExitFailure)
  ) where


import           Control.Monad.Catch (MonadThrow, throwM)
import           GHC.IO.Exception    (IOErrorType (InvalidArgument),
                                      IOException (IOError))
import           System.Exit         (ExitCode (ExitFailure, ExitSuccess))


-- | A version of 'System.Exit.exitWith' available in any 'MonadThrow' context.
--   See 'System.Exit.exitWith' for details
exitWith :: MonadThrow m => ExitCode -> m a
exitWith ExitSuccess = throwM ExitSuccess
exitWith code@(ExitFailure n)
  | n /= 0 = throwM code
  | otherwise = throwM (IOError Nothing InvalidArgument "exitWith" "ExitFailure 0" Nothing Nothing)


-- | A version of 'System.Exit.exitFailure' available in any 'MonadThrow' context.
--   See 'System.Exit.exitFailure' for details
exitFailure :: MonadThrow m => m a
exitFailure = exitWith (ExitFailure 1)


-- | A version of 'System.Exit.exitSuccess' available in any 'MonadThrow' context.
--   See 'System.Exit.exitSuccess' for details
exitSuccess :: MonadThrow m => m a
exitSuccess = exitWith ExitSuccess
