module ApplicationHelper

  def validate_if_nil(object_envoy, methods_for_object)
    all_methods = methods_for_object.split('.')
    string_of_methods = ""
    flag = false

    all_methods.each do |method|
      string_of_methods += ".send('#{method.to_s}')"
      if eval("object_envoy#{string_of_methods}.nil?")
        flag = true
        break
      else
        flag = false
      end
    end

    unless flag
      eval("object_envoy#{string_of_methods}")
    else
      'No disponible'
    end
  end

end
