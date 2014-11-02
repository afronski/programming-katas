import Test.HUnit

firstTest = TestCase (assertEqual "Test will fail" (1) (2))
secondTest = TestCase (assertEqual "Test will succeed" (1) (1))

tests = TestList [
    TestLabel "First test" firstTest,
    TestLabel "Second test" secondTest
  ]

main = runTestTT tests