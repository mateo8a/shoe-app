json.extract! shoe, :id, :color, :date_received, :date_due, :owner, :phone, :type_of_payment, :cost, :created_at, :updated_at
json.url shoe_url(shoe, format: :json)
