# frozen_string_literal: true
class Admin::ResourcefulController < Admin::BaseController
  before_action :load_attributes, except: %i[index destroy]

  helper_method :index_columns, :kind, :kind_human_name,
                :resource_link, :new_resource_link, :search_link,
                :upsert_action_link, :edit_resource_link, :sort_link,
                :default_sort, :show_attributes

  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def index
    authorize! :index, kind
    @q = scoped_collection.ransack(params[:q])
    @resources = params[:q].present? ? @q.result : scoped_collection.all
    @resources = @resources.order(sort_order).page(params[:page]).per(20)
    yield if block_given?
  end

  def show
    authorize! :show, kind
    find_resource(params[:id])
    yield if block_given?
  end

  def new
    authorize! :new, kind
    @resource = kind.new
    yield if block_given?
    render :upsert
  end

  def create
    authorize! :create, kind
    @resource = kind.new(process_params_for_upsert(permitted_params))
    yield if block_given?
    if @resource.save
      after_upsert(:create)
      redirect_to after_upsert_path,
                  notice: "#{kind_human_name} was successfully created."
    else
      flash.now[:alert] = 'Please fix the problems below.'
      render :upsert
    end
  end

  def edit
    authorize! :edit, kind
    find_resource(params[:id])
    yield if block_given?
    render :upsert
  end

  def update
    authorize! :update, kind
    find_resource(params[:id])
    yield if block_given?
    if @resource.update(process_params_for_upsert(permitted_params))
      after_upsert(:update)
      redirect_to after_upsert_path,
                  notice: "#{kind_human_name} was successfully updated."
    else
      flash.now[:alert] = 'Please fix the problems below.'
      render :upsert
    end
  end

  def destroy
    authorize! :destroy, kind
    find_resource(params[:id])
    @resource.destroy!
    redirect_to after_destroy_path,
                notice: "#{kind_human_name} was successfully destroyed."
  end

  protected

  def find_resource(id)
    @resource = kind.find(id)
  end

  def after_destroy_path
    polymorphic_path([:admin, kind])
  end

  def after_upsert(type)
  end

  def after_upsert_path
    polymorphic_path([:admin, @resource])
  end

  def new_resource_link
    new_polymorphic_path([:admin, kind]) rescue nil
  end

  def search_link
    polymorphic_path([:admin, kind])
  end

  def upsert_action_link
    polymorphic_path([:admin, @resource])
  end

  def edit_resource_link(resource)
    edit_polymorphic_path([:admin, resource]) rescue nil
  end

  def index_columns
    default_columns.map { |col| { attr: col, label: col.titleize, sort: col }}
  end

  def show_attributes
    default_columns.map { |col| { attr: col, label: col.titleize }}
  end

  def kind
    # Try to guess resource kind from controller name
    @kind ||= self.class.name.demodulize.sub('Controller', '').singularize.constantize
  end

  def kind_human_name
    kind.model_name.human
  end

  def permitted_params
    params.require(kind.model_name.singular)
  end

  def process_params_for_upsert(params)
    params
  end

  def load_attributes
    @resource_associations = kind.reflect_on_all_associations(:belongs_to)
    resource_attributes = (attribute_columns - @resource_associations.map(&:foreign_key))
    @resource_attributes_types = resource_attributes.map { |n| [n.to_sym, kind.type_for_attribute(n).type] }.to_h
  end

  def resource_link(resource)
    polymorphic_path([:admin, resource])
  end

  def sort_link(sort_attr)
    polymorphic_path([:admin, kind], { q: sort_link_params, sort_attr: sort_attr })
  end

  def default_sort
    "#{kind.table_name}.id-desc"
  end

  def scoped_collection
    kind
  end

  helper_method :search_sort_class
  def search_sort_class(sort_param, col)
    filter = sort_param.split('-')
    if filter.first == col
      filter.last == 'asc' ? 'sort-up' : 'sort-down'
    end
  end

  helper_method :index_column_link
  def index_column_link(column)
    prefix = "#{kind.table_name}.#{column[:sort]}-"
    asc = "#{prefix}asc"
    desc = "#{prefix}desc"
    sort_attr = params[:sort_attr] == asc ? desc : asc
    view_context.link_to column[:label], sort_link(sort_attr)
  end

  helper_method :search_disabled
  def search_disabled
    false
  end

  private

  def attribute_columns
    sanitized_columns - %w[id created_at updated_at]
  end

  def default_columns
    ['id'] + attribute_columns + kind.column_names.select { |c| c.in? %w[created_at updated_at] }
  end

  def sanitized_columns
    kind.column_names.reject { |c| c.ends_with?('password') }.sort
  end

  def sort_link_params
    params.require(:q).permit! if params[:q].present?
  end

  def resource_not_found
    redirect_to search_link,
                alert: "#{kind_human_name} with id #{params[:id]} was not found."
  end

  def sort_order
    case params[:sort_attr]
    when nil
      params[:sort_attr] = "#{kind.table_name}.id-desc"
      { id: :desc }
    else
      params[:sort_attr].tr('-', ' ')
    end
  end
end
