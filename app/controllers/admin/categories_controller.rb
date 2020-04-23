# frozen_string_literal: true
module Admin
  class CategoriesController < Admin::ResourcefulController

    protected

    def permitted_params
      super.permit!
    end

    def search_disabled
      true
    end
  end
end
