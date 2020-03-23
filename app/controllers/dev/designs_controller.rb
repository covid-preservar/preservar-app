class Dev::DesignsController < ApplicationController

  prepend_view_path "#{Rails.root}/doc/design/"

  def design_route
    if params[:layout] == 'false'
      render file:"#{params[:file]}", layout: nil
    else
      render file:"#{params[:file]}", layout: 'application'
    end
  end

  protected

end
