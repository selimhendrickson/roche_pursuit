class TakesController < ApplicationController

  def index
    @quizzes = Quiz.order('title').paginate(page: params[:page], :per_page => 10)
  end

  def new
    @quiz = Quiz.find(params[:quiz_id])
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
      @given_answer = params[:answer]
      @given_answer.strip!
      @answer = @quiz.questions[session[:index]].answer
      @answer.strip!
      if @answer.casecmp(@given_answer) == 0 then session[:score] += 1 end
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
