object @user

attributes :id, :email, :token, :display_name
child(:shelves) {
  attribute :id, :name
}