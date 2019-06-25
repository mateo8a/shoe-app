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
      f.text_field :cost, disabled: "disabled"
    else
      f.text_field :cost
    end
  end

  private

  def payment_options_disabled?(shoe)
    Shoe.exists?(shoe.id) && shoe.paid_for?
  end
end
