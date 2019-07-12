module ShoesHelper
  def paid_for_checkbox(f, shoe)
    if payment_options_disabled?(shoe)
      f.check_box :paid_for, disabled: "disabled"
    else
      f.check_box :paid_for
    end
  end

  def payment_options_button(f, shoe, payment_type)
    if payment_options_disabled?(shoe)
      f.radio_button :type_of_payment, payment_type, disabled: "disabled"
    else
      f.radio_button :type_of_payment, payment_type
    end
  end

  def cost_input_field(f, shoe)
    if payment_options_disabled?(shoe)
      f.number_field :cost, disabled: "disabled"
    else
      f.number_field :cost, min: 0, step: ".01"
    end
  end

  def search_results(shoes)
    search_params = params[:search_options]
    shoes = date_received_search(search_params, shoes)
    shoes = date_due_search(search_params, shoes)
    shoes = type_of_payment_search(search_params, shoes)
    shoes
  end

  private
  def date_received_search(search_params, shoes)
    if param_to_boolean(search_params[:date_received])
      date_received_from = extract_date_from_params(search_params, "date_received_from")
      date_received_to = extract_date_from_params(search_params, "date_received_to")
      shoes = shoes.where(date_received: date_received_from..date_received_to)
    end
    shoes
  end

  def date_due_search(search_params, shoes)
    if param_to_boolean(search_params[:date_due])
      date_due_from = extract_date_from_params(search_params, "date_due_from")
      date_due_to = extract_date_from_params(search_params, "date_due_to")
      shoes = shoes.where(date_due: date_due_from..date_due_to)
    end
    shoes
  end

  def type_of_payment_search(search_params, shoes)
    if search_params[:type_of_payment]
      shoes = shoes.where(type_of_payment: search_params[:type_of_payment])
    end
    shoes
  end

  def extract_date_from_params(search_params, param)
    date_values = ["1", "2", "3"].map do |j|
      search_params["#{param}(#{j}i)"].to_i
    end
    Date.new(*date_values)
  end

  def param_to_boolean(param)
    ActiveRecord::Type::Boolean.new.deserialize(param)
  end

  def payment_options_disabled?(shoe)
    Shoe.exists?(shoe.id) && shoe.paid_for?
  end
end
