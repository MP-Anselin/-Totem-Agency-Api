class Api::V1::Requests::Tables::UsersController < Api::V1::FirebaseRequests::FirestoreManager


  def initialize
    super

    @db_users = @firestore.col "users"
    @result = []

  end

  # GET /users
  def index
    @db_users.get do |user|
      user_list = []
      user_list.push(id: user.document_id, user_information: user.data)
      @result.push(user_list)
    end

    render json: {data: @result}
  end

  # GET /user/1
  def show
    render json: {test: 'get spec ok'}
  end

  # POST /users
  def create

    render json: {test: 'post ok'}
    #if
    # render json: @basic_test, status: :created, location: @basic_test
    #else
    # render json: @basic_test.errors, status: :unprocessable_entity
    #end
  end

  # PATCH/PUT /users/1
  def update

    render json: {test: 'put ok'}
    #if @basic_test.update(basic_test_params)
    #render json: @basic_test
    #else
    #render json: @basic_test.errors, status: :unprocessable_entity
    #end
  end

  # DELETE /users/1
  def destroy
    render json: {test: 'delete ok'}
    #
  end

end
