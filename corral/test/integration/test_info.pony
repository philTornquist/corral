use "files"
use "ponytest"
use ".."
use "../../util"

class TestInfo is UnitTest
  fun name(): String => "integration/info"
  fun apply(h: TestHelper) ? =>
    h.long_test(2_000_000_000)
    Execute(h,
      recover [
        "info"
        "--bundle_dir"; Data(h, "empty-deps")?.path
      ] end,
      {(h: TestHelper, ar: ActionResult) =>
        h.assert_eq[I32](0, ar.exit_code())
        h.assert_true(ar.stdout.contains("info: {}"))
        h.complete(ar.exit_code() == 0)
      })

class TestInfoWithoutBundle is UnitTest
  fun name(): String => "integration/info/without-bundle"
  fun apply(h: TestHelper) =>
    h.long_test(2_000_000_000)
    Execute(h,
      recover [
        "info"
        "--bundle_dir"; "nonexistant!"
      ] end,
      {(h: TestHelper, ar: ActionResult) =>
        h.assert_eq[I32](1, ar.exit_code())
        h.complete(ar.exit_code() == 1)
      })
