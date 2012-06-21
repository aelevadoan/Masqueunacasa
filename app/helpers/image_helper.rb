module ImageHelper
  def fake_img(width, height, options = {}) 
    options.reverse_merge! class: 'responsive', text: ''
    text = options.delete(:text)
    placeholder_image_tag({width: width, height: height, 
                          text: text}, options)
  end

  def fake_img_fixed(width, height, options = {})
    options.reverse_merge! class: 'fixed'
    fake_img(width, height, options)
  end

  def avatar_image(model, options = {})
    options.reverse_merge! class: 'responsive', size: 'normal'

    size = options[:size] == :small ? 40 : 140

    if model.avatar_image? 
      url = options[:size] == :small ? model.avatar_image_url(:mini) : model.avatar_image_url
      image_tag(url, alt: model.name, class: options[:class], width: size, height: size)
    else
      placeholder_image_tag(text: 'A', width: size, height: size, class: options[:class])
    end
  end

  def avatar_link(model, options = {})
    link_to avatar_image(model, options), model
  end


end