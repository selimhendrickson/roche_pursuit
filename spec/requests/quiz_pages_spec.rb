require 'spec_helper'

describe "QuizPages" do

  subject { page }

  describe "index" do
    
    let(:admin) { FactoryGirl.create(:admin) }

    before(:each) do
      sign_in admin
      visit quizzes_path
    end

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:quiz) } }
      after(:all) { Quiz.delete_all }

      it{ should have_selector('div.pagination') }

      it "should list each quiz" do
        Quiz.paginate(page: 1).each do |quiz|
          expect(page).to have_selector('li', text: quiz.title)
        end
      end
    end
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

      before do
        sign_in admin
        visit quizzes_path
      end

      it { should have_link('Quizzes', href: quizzes_path )}

      it { should have_title('All quizzes') }
    end
  end
end
