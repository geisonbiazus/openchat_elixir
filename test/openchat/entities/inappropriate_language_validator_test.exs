defmodule OpenChat.Entities.InappropriateLanguageValidatorTest do
  use ExUnit.Case, async: true

  alias OpenChat.Entities.InappropriateLanguageValidator

  describe "validate" do
    test "validates inappropriate words" do
      assert InappropriateLanguageValidator.validate("good text")
      refute InappropriateLanguageValidator.validate("orange")
      refute InappropriateLanguageValidator.validate("Orange")
      refute InappropriateLanguageValidator.validate("Ice Cream")
      refute InappropriateLanguageValidator.validate("ice cream")
      refute InappropriateLanguageValidator.validate("elephant")
      refute InappropriateLanguageValidator.validate("Elephant")
    end
  end
end
