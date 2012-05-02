module LayoutHelper
  def corner_span(css_class, color = :colored, &block)
    content = capture(&block)
    raw "<div class='#{css_class}'><div class='corner #{color}'></div><div class='content'>#{content}</div></div>"
  end

  def submit_button(form, text = 'Enviar', color = 'negro')
    raw "<div class='submit-wrapper #{color}'>
           #{form.button :submit, value: text}
           <div class='side-right'></div>
         </div>"
  end
end
