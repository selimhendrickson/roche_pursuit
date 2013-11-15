require 'spec_helper'

describe "QuizPages" do

  subject { page }

  before(:all) { 30.times { FactoryGirl.create(:quiz) } }
  after(:all) { Quiz.delete_all }

  describe "index" do
    
    let(:admin) { FactoryGirl.create(:admin) }

    before(:each) do
      sign_in admin
      visit quizzes_path
    end

    describe "pagination" do


      it { should have_selector('div.pagination') }
      it { should have_link('Add new quiz') }

      it "should list each quiz" do
        Quiz.paginate(page: 1).each do |quiz|
          expect(page).to have_selector('li', text: quiz.title)
        end
      end
    end
  end
  
  describe "new" do
    let(:admin) { FactoryGirl.create(:admin) }

    before(:each) do
      sign_in admin
      visit new_quiz_path
    end

    it { should have_content(:title)}
    it { should have_content("New Quiz")}
    it { should have_field("quiz_title")}
    it { should have_field("quiz_questions")}
    it { should have_button("Create quiz")}
  end

  describe "authorization" do

    describe "for non-signed-in users" do

      it { should_not have_link('Quizzes') }

      describe "requesting quizzes page" do
        before { get quizzes_path }
        specify { expect(response).to redirect_to(signin_path) }
      end
    end

    describe "for non-admin users" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user, no_capybara: true }

      it { should_not have_link('Quizzes', href: quizzes_path )}
      describe "requesting quizzes page" do
        before { get quizzes_path }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      let(:button) { "Add new quiz" }

      before do
        sign_in admin
        visit quizzes_path
      end

      it { should have_link('Quizzes', href: quizzes_path) }
      it { should have_title('All quizzes') }
      it { should have_selector(:link_or_button, button) }
      it { should have_link('delete', href: quiz_path(Quiz.first)) }
      it "should be able to delete a quiz" do
        expect do
          click_link('delete', match: :first)
        end.to change(Quiz, :count).by(-1)
      end
    end
  end
end
