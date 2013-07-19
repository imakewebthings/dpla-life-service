object @shelf

attributes :id, :name, :description, :user_id, :item_ids
node(:items) do
  @items.map {|item| item.to_h }
end