class UsersController < ApplicationController
  # GET /users
  # GET /users.json



  # ----------------------- HOMEPAGE ---------------------------

  def home
    @users = User.all

    respond_to do |format|
      format.html # home.html.erb
    end
  end

  # ---------------------- ADD ---------------------------------

  def add

    u = params[:user]
    pass = params[:password]

    code = User.add(u, pass)

    # check if the login was successful to determine what to send back
    if code > 0
      render :json => {:errCode => $SUCCESS, :count => code}

    else
      render :json => {:errCode => code}

    end

  end

  # ------------------------- LOGIN ----------------------------

  def login

    # Default to Success
    errCode = $SUCCESS

    u = params[:user]
    pass = params[:password]
    code = User.login(u, pass)


    # check if the login was successful to determine what to send back
    if code > 0
      render :json => {:errCode => $SUCCESS, :count => code}
    else
      render :json => {:errCode => code}
    end
  end

  # ------------------------- TESTAPI_resetFixture -----------------

  def TESTAPI_resetFixture
    code = User.TESTAPI_resetFixture

    render :json => {:errCode => code}

  end

  # ------------------------- TESTAPI_unitTests --------------------

  def TESTAPI_unitTests

    # execute shell command, save output as value

    begin
      output = `ruby -Itest test/unit/user_test.rb`
      value = output.split(/\r?\n/)

      # status = ..............
      # . = Success, F = Failure
      status = value[2]

      totalTests = status.count "."
      failedTests = status.count "F"

      render :json => {:totalTests => totalTests, :nrFailed => failedTests, :output => output}

    rescue Exception
      render :json => {:output => "ERROR OCCURED"}

    end

  end

end