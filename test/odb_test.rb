require File.dirname(__FILE__) + '/test_helper'
require 'base64'

context "Ribbit::Odb stuff" do
  setup do
    path = File.dirname(__FILE__) + '/fixtures/testrepo.git/objects'
    @odb = Ribbit::Odb.new(path)
  end

  test "can tell if an object exists or not" do
    assert @odb.exists("8496071c1b46c854b31185ea97743be6a8774479")
    assert @odb.exists("1385f264afb75a56a5bec74243be9b367ba4ca08")
    assert !@odb.exists("ce08fe4884650f067bd5703b6a59a8b3b3c99a09")
    assert !@odb.exists("8496071c1c46c854b31185ea97743be6a8774479")
  end

  test "can read an object from the db" do
    data, len, type = @odb.read("8496071c1b46c854b31185ea97743be6a8774479")
    assert_match 'tree 181037049a54a1eb5fab404658a3a250b44335d7', data
    assert_equal 172, len
    assert_equal "commit", type
  end

  test "returns false if an object is not there" do
    assert !@odb.read("a496071c1b46c854b31185ea97743be6a8774471")
  end


end