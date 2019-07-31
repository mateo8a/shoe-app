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

  def filter_delivered
    if search_params && param_to_boolean(search_params[:search_by_delivered]) && search_params[:delivered]
      show_all_items = param_to_boolean(search_params[:delivered])
      if show_all_items
        shoes = Shoe.where(organization_id: current_user.organization.id).order(created_at: :desc)
      else
        shoes = Shoe.where(organization_id: current_user.organization.id, delivered: true).order(created_at: :desc)
      end
    else
      shoes = Shoe.where(organization_id: current_user.organization.id, delivered: false).order(created_at: :desc)
    end
    shoes
  end

  def search_results(shoes)
    shoes = date_received_search(search_params, shoes)
    shoes = date_due_search(search_params, shoes)
    shoes = type_of_payment_search(search_params, shoes)
    shoes = paid_for_search(search_params, shoes)
    shoes
  end

  private
  def search_params
    params[:search_options]
  end

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
    if param_to_boolean(search_params[:search_by_type_of_payment]) && search_params[:type_of_payment]
      shoes = shoes.where(type_of_payment: search_params[:type_of_payment])
    end
    shoes
  end

  def paid_for_search(search_params, shoes)
    if param_to_boolean(search_params[:search_by_paid_for]) && search_params[:paid_for]
      paid_for = param_to_boolean(search_params[:paid_for])
      shoes = shoes.where(paid_for: paid_for)
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
    Shoe.exists?(shoe.id) && shoe.paid_for? && !shoe.paid_for_changed?
  end
end
