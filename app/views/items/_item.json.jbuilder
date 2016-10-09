json.extract! item, :id, :description, :url, :price, :itemtype, :offered_by, :created_at, :updated_at
json.url item_url(item, format: :json)