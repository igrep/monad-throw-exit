import           System.Exit          (ExitCode (ExitFailure, ExitSuccess))
import qualified System.Process.Typed as P
import           Test.Hspec
import           Test.QuickCheck      (NonZero (getNonZero), property)


main :: IO ()
main = hspec $ do
  describe "exitWith" $
    it "exit with the given exit code" . property $ \code0 -> do
      let code = getNonZero code0
      result <- P.runProcess $ P.proc "monad-throw-exit-example-command" ["exitWith", show code]
      result `shouldBe` ExitFailure code

  describe "exitSuccess" $
    it "exit with the successfull exit code" $ do
      result <- P.runProcess $ P.proc "monad-throw-exit-example-command" ["exitSuccess"]
      result `shouldBe` ExitSuccess

  describe "exitFailure" $
    it "exit with the exit code 1" $ do
      result <- P.runProcess $ P.proc "monad-throw-exit-example-command" ["exitFailure"]
      result `shouldBe` ExitFailure 1
