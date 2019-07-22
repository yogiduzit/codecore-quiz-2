require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  describe "#home" do
    it "must render the home page" do 
      get :home

      expect(response).to render_template(:home)
    end
  end
  describe "#new" do
    it "must render the new page" do
      get :new

      expect(response).to render_template(:new)
    end

    it "must create a new instance variable of type Idea" do
      get :new

      expect(assigns(:idea)).to be_a_new(Idea)
    end
  end
  describe "#index" do
    it "must render the index page" do
      get(:index)

      expect(response).to render_template(:index)
    end

    it "must load all ideas" do 
      get :index

      assert_equal Idea.all, assigns(:ideas)
    end
  end

  describe "#create" do
    context "valid parameters" do
      def valid_request
        post(:create, params: {
          idea: FactoryBot.attributes_for(:idea)
        })
      end

      it "must create a new entry in the database" do
        before_create = Idea.count

        valid_request
        after_create = Idea.count

        expect(after_create).to eq(before_create + 1)
      end
      it "must redirect to the show page" do
        valid_request
        
        expect(response).to redirect_to(idea_path(Idea.last))
      end
    end
    context "invalid parameters" do
      def invalid_request
        post(:create, params: {
          idea: FactoryBot.attributes_for(:idea, title: nil)
        })
      end
      it "must not save an entry in the database" do
        before_create = Idea.count

        invalid_request
        after_create = Idea.count

        expect(after_create).to eq(before_create)
      end

      it "must assign an invalid variable" do
        invalid_request

        expect(assigns(:idea)).to be_a_new(Idea)
        expect(assigns(:idea).valid?).to be(false)
      end

      it "must render the new template" do
        invalid_request

        expect(response).to render_template(:new)
      end
    end
  end
  describe '#edit' do
    let!(:idea) { FactoryBot.create(:idea) } # This creates a variable that is accessible deep within

    def request 
      get(:edit, params: {
        id: idea["id"]
      })
    end
    it "must render the edit template" do
      request

      expect(response).to render_template(:edit)
    end
    it "must have an instance variable of type Idea" do
      request

      assert_equal idea, assigns(:idea)
    end
  end
  describe "#update" do
    context "valid parameters" do 
      def valid_request(idea)
        patch(:update, params: {
          idea: {
            title: "Hello world", 
            body: "Hahahaha"
          },
          id: idea.id
        })
      end

      it "must update the values of the current record" do
        idea = FactoryBot.create(:idea)

        valid_request(idea)

        expect(idea.reload.title).to eq("Hello world")
        expect(idea.reload.body).to eq("Hahahaha")

      end
      it "must redirect to show page" do
        idea = FactoryBot.create(:idea)

        valid_request(idea)

        expect(response).to redirect_to(idea_path(idea))
      end

    end
    context "invalid parameters" do
      def invalid_request(idea)
        patch(:update, params: {
          idea: {
            title: nil,
            body: nil
          },
          id: idea.id
        })
      end
      it "must not update the values of the record" do
        idea = FactoryBot.create(:idea)

        invalid_request(idea)

        expect(idea.reload.title).to be
        expect(idea.reload.body).to be
      end

      it "must render the edit page" do
        idea = FactoryBot.create(:idea)

        invalid_request(idea)

        expect(response).to render_template(:edit)
      end
    end
  end
  describe "#destroy" do
    def delete_request(idea)
      delete(:destroy, params: {
        id: idea.id
      })
    end
    it "must delete an entry from the database" do
      idea = FactoryBot.create(:idea)
      before_delete = Idea.count

      delete_request(idea)
      after_delete = Idea.count

      expect(Idea.find_by(id: idea.id)).to be(nil)
      expect(before_delete).to eq(after_delete + 1)
    end

    it "must redirect to index page" do
      idea = FactoryBot.create(:idea)

      delete_request(idea)

      expect(response).to redirect_to(ideas_path)
    end
  end
end
