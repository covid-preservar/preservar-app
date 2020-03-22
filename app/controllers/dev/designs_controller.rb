class Dev::DesignsController < ApplicationController

  prepend_view_path "#{Rails.root}/doc/design/"

  def design_route
      render file:"#{params[:file]}", layout: 'application'
  end

  protected

end
