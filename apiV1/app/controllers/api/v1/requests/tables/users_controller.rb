class Api::V1::Requests::Tables::UsersController < Api::V1::FirebaseRequests::FirestoreManager
  before_action only: [:show, :update, :destroy]

  def initialize
    super

    @db_users = @firestore.col "users"
    @information = []
    @error_info = {:status => 500, :error => 'Internal Server Error'}
  end

  # GET /users
  def index

    @db_users.get do |user|
      @information.push(id: user.document_id, user_information: user.data)
    end

    render json: {data: @information}
  end

  # GET /user/1
  def show
    info = {}
    id = params[:id]
    user = @db_users.doc(id).get.data
    unless id.nil? || user.nil?
      info['id'] = id
      user.each { |key, value|
        info[key] = value
      }
      render json: {data: info, status: "success", code: 200}
    else
      @error_info[:status] = 404
      @error_info[:error] = 'Not Found'
      render json: @error_info
    end
  end

  def hasDuplicate(fields)
    check_duplicate = @db_users.where("email", "=", "#{fields[:email]}")
    if check_duplicate.get() do |user|
      unless user.document_id.nil?
        return 1
      end
    end
    end
    return 0
  end

  # POST /users
  def create

    fields = {first_name: params[:first_name], last_name: params[:last_name],
              email: params[:email] }
    isValid = 0

    fields.each do |key, value|
      if value.nil? || value.blank? || value.empty?
        isValid = 1
      end
    end

    if isValid == 1
      @error_info[:status] = 400
      @error_info[:error] = 'Bad request'
      render json: @error_info
    elsif hasDuplicate(fields) == 1
      @error_info[:status] = 409
      @error_info[:error] = 'Conflict'
      render json: @error_info
    else
      new_user = @db_users.add(fields)
      if new_user.document_id.nil?
        @error_info[:status] = 503
        @error_info[:error] = 'Service Unavailable'
        render json: @error_info
      end

      render json: {status: "Created", code: 201}
    end
  end

  # PATCH/PUT /users/1
  def update
    render json: {status: "update ok", code: 204}
  end

  # DELETE /users/1
  def destroy
    id = params[:id]
    isExisted = @db_users.doc(id).get.data
    if isExisted.nil?
      @error_info[:status] = 204
      @error_info[:error] = 'No Content'
      render json: @error_info
    else
      @db_users.doc(id).delete
      check_delete = @db_users.doc(id).get.data
      if check_delete.nil?
        render json: {status: "Document deleted", code: 200}
      else
        @error_info[:status] = 406
        @error_info[:error] = 'Not Acceptable'
        render json: @error_info
      end
    end
  end

end
