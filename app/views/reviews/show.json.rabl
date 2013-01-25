object @review

attributes :id, :book_id, :rating, :comment
child :user do
  attributes :id, :display_name
end