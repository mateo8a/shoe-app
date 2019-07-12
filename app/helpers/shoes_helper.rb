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

  def date_received_search(search_params, shoes)
    if param_to_boolean(search_params[:date_received])
      date_received_from = Date.new(search_params["date_received_from(1i)"].to_i, search_params["date_received_from(2i)"].to_i, search_params["date_received_from(3i)"].to_i)
      date_received_to = Date.new(search_params["date_received_to(1i)"].to_i, search_params["date_received_to(2i)"].to_i, search_params["date_received_to(3i)"].to_i)
      shoes = shoes.where(date_received: date_received_from..date_received_to)
    end
    shoes
  end

  def date_due_search(search_params, shoes)
    if param_to_boolean(search_params[:date_due])
      date_due_from = Date.new(search_params["date_due_from(1i)"].to_i, search_params["date_due_from(2i)"].to_i, search_params["date_due_from(3i)"].to_i)
      date_due_to = Date.new(search_params["date_due_to(1i)"].to_i, search_params["date_due_to(2i)"].to_i, search_params["date_due_to(3i)"].to_i)
      shoes = shoes.where(date_due: date_due_from..date_due_to)
    end
    shoes
  end

  private
  def param_to_boolean(param)
    ActiveRecord::Type::Boolean.new.deserialize(param)
  end

  def payment_options_disabled?(shoe)
    Shoe.exists?(shoe.id) && shoe.paid_for?
  end
end
