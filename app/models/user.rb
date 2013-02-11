  $SUCCESS = 1
  $ERR_BAD_CREDENTIALS = -1
  $ERR_USER_EXISTS = -2
  $ERR_BAD_USERNAME = -3
  $ERR_BAD_PASSWORD = -4

class User < ActiveRecord::Base
  attr_accessible :count, :password, :username

  def self.add(u, pass)
    # check if the username is valid (non-empty, at most 128 characters)
    if u.to_s == "" or u.length > 128
      return $ERR_BAD_USERNAME


    # check if the username already exists in the database
    elsif User.exists?(:username => u)
      return $ERR_USER_EXISTS

    # check if the password is valid (at most 128 characters)
    elsif pass.length > 128
      return $ERR_BAD_PASSWORD

    else
        user = User.new(:username => u, :password => pass, :count => 1)
        user.save
        return user.count

    end
  end

  def self.login(u, pass)
    result = User.where("username = ? AND password = ?", u, pass)

    # the login and the password is not found, set errCode to $ERR_BAD_CREDENTIALS
    if result.length == 0
      return $ERR_BAD_CREDENTIALS
    else
      user = result.first
      user.count += 1
      user.save
      return user.count
    end

  end

  def self.TESTAPI_resetFixture
    User.delete_all
    return $SUCCESS
  end


end
