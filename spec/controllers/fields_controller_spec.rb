require 'spec_helper'

describe FieldsController do

  before :each do
    @user = User.make!
    sign_in @user
  end

  it 'can show a field' do
    field = Field.make!

    get :show, id: field

    assigns(:field).should == field
    response.should render_template(:show)
  end

  it 'can edit a field' do
    field = Field.make!

    get :edit, id: field

    assigns(:field).should == field
    response.should render_template(:edit)
  end

  it 'can update a field' do
    field = Field.make!

    put :update, id: field, field: { name: 'hello' }

    assigns(:field).should == field.reload
    field.name.should == 'hello'

    response.should redirect_to field_path(field)
  end

  it 'can destroy a field' do
    field = Field.make!

    delete :destroy, id: field

    response.should redirect_to fields_path
  end
end