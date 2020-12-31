# frozen_string_literal: true
module Admin
  class AdminUsersController < Admin::ResourcefulController

    def index_columns
      [
        { attr: :id, label: 'ID', sort: :id },
        { attr: :email, label: 'Email', sort: :email },
        { attr: :role, label: 'Role', sort: :role },
        { attr: :created_at, label: 'Created At', sort: :created_at },
        { attr: :updated_at, label: 'Updated At', sort: :updated_at }
      ]
    end

    def update
      authorize! :update, kind
      find_resource(params[:id])

      if permitted_params[:password].present?
        success = @resource.update_with_password(permitted_params)
      else
        success = @resource.update(permitted_params.except(:password,
                                                           :password_confirmation,
                                                           :current_password))
      end

      if success
        after_upsert(:update)
        redirect_to after_upsert_path,
                    notice: "#{kind_human_name} was successfully updated."
      else
        flash.now[:alert] = 'Please fix the problems below.'
        render :upsert
      end
    end

    protected

    def search_disabled
      true
    end

    def permitted_params
      super.permit!
    end
  end
end
