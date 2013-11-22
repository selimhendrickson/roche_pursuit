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
    if session[:index] == -1
      render :js => "window.location.href = ('#{takes_path}');"
    else
      @quiz = Quiz.find(session[:quiz_id])
      if params[:answer].eql? @quiz.questions[session[:index]].answer
        session[:score] += 1
      end
      unless @quiz.questions.length == session[:index] + 1
        session[:index] = session[:index] + 1
        @question = @quiz.questions[session[:index]]
        respond_to do |format|
          format.html { render 'new'}
          format.js
        end
      else
        render :js => "window.location.href = ('#{complete_path}');"
      end
    end
  end

  def complete
    session[:index] = -1 
  end
end
