namespace ProgrammingKata

open System
open NUnit.Framework

[<TestFixture>]
type Test() = 
        [<Test>]
        abstract TestCase : unit -> unit

        [<Test>]
        default this.TestCase  () =
            ()