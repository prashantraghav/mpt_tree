class <%= file_name.pluralize.camelize %>Controller < ApplicationController
  before_action :root_entry, :only=>[:index]
  before_action :set_<%= file_name %>, :only=>[:edit, :update, :destroy, :show]

  def index
    parent = <%= file_name.camelize %>.root 
    @<%= file_name.pluralize %> = parent.children
  end

  def show
    @parent = <%= file_name.camelize %>.find(params[:id])
    @<%= file_name.pluralize %> = @parent.children
  end

  def new
    @<%= file_name %> = <%= file_name.camelize %>.new
    @parent_id = params[:parent_id]
  end

  def edit
  end

  def create
    @<%= file_name %> = <%= file_name.camelize %>.new(<%= file_name %>_params)
    @<%= file_name %>.save
    parent_<%= file_name %> << @<%= file_name %>
    redirect_to <%= file_name %>_path(@<%= file_name %>), notice: '<%= file_name.camelize %> was successfully created.' 
  end

  def update
    @<%= file_name %>.update(<%= file_name %>_params)
    redirect_to <%= file_name %>_path(@<%= file_name %>), notice: '<%= file_name.camelize %> was successfully updated.' 
  end

  def destroy
  end

  private 
  def set_<%= file_name %>
    @<%= file_name %> = <%= file_name.camelize %>.find params[:id]
  end

  def <%= file_name %>_params 
    <% params = String.new %> <% @args.each_with_index do |arg, index| %> <% params += ":"+arg.split(':')[0] %> <% params += "," if index < @args.count-1 %> <% end %>
    params.require(:<%= file_name %>).permit(<%= params -%>)
  end

  def parent_<%= file_name %>
    parent_<%= file_name %>_id = (params.require(:<%= file_name %>).permit(:parent_id)[:parent_id])
    <%= file_name %> = (parent_<%= file_name %>_id.empty?) ? <%= file_name.camelize %>.root : <%= file_name.camelize %>.find(parent_<%= file_name %>_id)
  end

  def root_entry 
    <%= file_name.camelize %>.create(:title=>'root').make_it_root if !<%= file_name.camelize %>.first
  end
end
