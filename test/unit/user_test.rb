require 'test_helper'

$SUCCESS = 1
$ERR_BAD_CREDENTIALS = -1
$ERR_USER_EXISTS = -2
$ERR_BAD_USERNAME = -3
$ERR_BAD_PASSWORD = -4

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    test "add user" do
        User.TESTAPI_resetFixture
        result = User.add("jimmy", "password")
        assert result == $SUCCESS, "Adding new user failed"
    end

    test "add user with empty password" do
        User.TESTAPI_resetFixture
        assert User.add("jimmy", "") == $SUCCESS, "Adding new user with empty password failed"
    end

    test "add not valid with username over 128 characters" do
        User.TESTAPI_resetFixture
        assert User.add("a"*129, "pass") == $ERR_BAD_USERNAME, "Adding new user with empty username does not return proper error code"
    end

    test "add not valid with password over 128 characters" do
        User.TESTAPI_resetFixture
        assert User.add("b", "b"*129) == $ERR_BAD_PASSWORD
    end

    test "add not valid with empty username" do
        User.TESTAPI_resetFixture
        assert User.add("", "qwerty123") == $ERR_BAD_USERNAME
    end

    test "add not valid with exisiting username" do
        User.TESTAPI_resetFixture
        assert User.add("jimmy", "password") == $SUCCESS
        assert User.add("jimmy", "password") == $ERR_USER_EXISTS
    end

    test "add two users" do
        User.TESTAPI_resetFixture
        assert User.add("jimmy", "password") == $SUCCESS
        assert User.add("jimmy1", "password") == $SUCCESS
    end

    test "add and then login" do
        User.TESTAPI_resetFixture
        assert User.add("user", "pass") == 1
        assert User.login("user", "pass") == 2
    end

    test "login with bad credentials" do
        User.TESTAPI_resetFixture
        assert User.login("random", "password") == $ERR_BAD_CREDENTIALS
    end

    test "TESTAPI_resetFixture" do
        User.TESTAPI_resetFixture
        assert User.TESTAPI_resetFixture == $SUCCESS
    end

end
