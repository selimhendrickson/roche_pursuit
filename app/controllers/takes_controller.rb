class TakesController < ApplicationController

  def index
  end

  def new
    @quiz = Quiz.find(:first)
    session[:quiz_id] = @quiz.id
    @question = @quiz.questions[0]
    session[:index] = 0
    session[:score] = 0
  end

  def answer
    @quiz = Quiz.find(session[:quiz_id])
    if params[:answer].eql? @quiz.questions[session[:index]].answer
      session[:score] += 1
    end
    unless @quiz.questions.length == session[:index] + 1
      session[:index] = session[:index] + 1
      @question = @quiz.questions[session[:index]]
      render 'new'
    else
      redirect_to :complete
    end
  end

  def complete
  end
end
