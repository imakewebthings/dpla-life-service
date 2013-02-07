object @user

attributes :id, :email, :display_name
child(:shelves) {
  attribute :id, :name
}