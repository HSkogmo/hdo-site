require 'spec_helper'

describe PartiesController do
  let(:party) { Party.make! }

  describe "GET #index" do
    it 'populates an array of parties' do
      parties = [party]
      get :index
      assigns(:parties).should == parties
    end

    it 'renders the :index view' do
      get :index
      response.should have_rendered(:index)
    end
  end

  describe "GET #show" do
    it 'assigns the requested party to @party' do
      get :show, id: party

      assigns(:party).should == party
    end

    it 'fetches the latest published issues' do
      t1 = Issue.make! :published => true
      t2 = Issue.make! :published => true
      t3 = Issue.make! :published => false

      t1.vote_connections.map { |e| e.vote.update_attributes!(:time => 3.days.ago) }
      t2.vote_connections.map { |e| e.vote.update_attributes!(:time => 2.days.ago) }
      t3.vote_connections.map { |e| e.vote.update_attributes!(:time => 1.days.ago) }

      get :show, id: party

      assigns(:issues).should == [t2, t1]
    end

    it 'renders the :show template' do
      get :show, id: party
      response.should have_rendered(:show)
    end
  end
end
