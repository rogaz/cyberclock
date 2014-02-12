class UtilsController < ApplicationController

  def manage_habtm
    @first_element = params[:first_class].camelize.constantize.find(params[:first_class_id])
    second_element = params[:second_class].camelize.constantize.find(params[:second_class_id])
    if params[:type] == 'add'
      @first_element.send("#{params[:second_class].tableize}") << second_element
    elsif params[:type] == 'delete'
      @first_element.send("#{params[:second_class].tableize}").delete(second_element)
    end

    #eval("'#{params[:first_class]}'.camelize.constantize.find(#{params[:first_class_id]}).#{params[:second_class].tableize} << ['#{params[:second_class]}'.camelize.constantize.find(#{params[:second_class_id]})]")
    #eval("'#{params[:first_class]}'.camelize.constantize.find(#{params[:first_class_id]}).#{params[:second_class].tableize}.delete['#{params[:second_class]}'.camelize.constantize.find(#{params[:second_class_id]})]")

    respond_to do |format|
      #format.js "#{params[:first_class].tableize}/union_habtm"
      format.js { render 'shared/union_habtm' }
    end
  end

end
