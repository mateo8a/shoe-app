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

  def search_results
    setup_shoes_search
    date_received_search(search_params)
    date_due_search(search_params)
    type_of_payment_search(search_params)
    paid_for_search(search_params)
    delivered_search(search_params)
    id_search(search_params)
    phone_search(search_params)
    name_search(search_params)
    void_search(search_params)
    @shoes_search
  end

  private
  def setup_shoes_search
    @shoes_search = Shoe.where(organization_id: current_user.organization.id).order(created_at: :desc)
  end

  def search_params
    params[:search_options]
  end

  def date_received_search(search_params)
    if param_to_boolean(search_params[:date_received])
      date_received_from = extract_date_from_params(search_params, "date_received_from")
      date_received_to = extract_date_from_params(search_params, "date_received_to")
      @shoes_search = @shoes_search.where(date_received: date_received_from..date_received_to)
    end
    @shoes_search
  end

  def date_due_search(search_params)
    if param_to_boolean(search_params[:date_due])
      date_due_from = extract_date_from_params(search_params, "date_due_from")
      date_due_to = extract_date_from_params(search_params, "date_due_to")
      @shoes_search = @shoes_search.where(updated_date_due: date_due_from..date_due_to)
    end
    @shoes_search
  end

  def type_of_payment_search(search_params)
    if search_params[:type_of_payment]
      @shoes_search = @shoes_search.where(type_of_payment: search_params[:type_of_payment])
    end
    @shoes_search
  end

  def paid_for_search(search_params)
    if search_params[:paid_for]
      paid_for = param_to_boolean(search_params[:paid_for])
      @shoes_search = @shoes_search.where(paid_for: paid_for)
    end
    @shoes_search
  end

  def delivered_search(search_params)
    if search_params[:delivered]
      delivered = param_to_boolean(search_params[:delivered])
      @shoes_search = @shoes_search.where(delivered: delivered).order(created_at: :desc)
    end
    @shoes_search
  end

  def id_search(search_params)
    if !search_params[:id].blank?
      id_within_organization = search_params[:id].to_i
      @shoes_search = @shoes_search.where(id_within_organization: id_within_organization)
    end
    @shoes_search
  end

  def phone_search(search_params)
    if !search_params[:phone_number].blank?
      phone = search_params[:phone_number].to_i
      @shoes_search = @shoes_search.where(phone: phone)
    end
    @shoes_search
  end

  def name_search(search_params)
    if !search_params[:name].blank?
      search_name = search_params[:name]
      shoes_table = Shoe.arel_table
      @shoes_search = @shoes_search.where(shoes_table[:owner].matches("%#{search_name}%"))
    end
    @shoes_search
  end

  def void_search(search_params)
    if search_params[:void]
      void = param_to_boolean(search_params[:void])
      @shoes_search = @shoes_search.where(void: void)
    end
    @shoes_search
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
