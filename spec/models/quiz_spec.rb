require 'spec_helper'

describe Quiz do

  before do
    @quiz = Quiz.new(title: "Lorem Ipsum")
  end

  subject { @quiz }

  it { should respond_to(:title) }

  describe "with blank title" do
    before { @quiz.title = "" }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @quiz.title = "a" * 101 }
    it { should_not be_valid }
  end

end
