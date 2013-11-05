class QuizzesController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user

  def index
    @quizzes = Quiz.order('title').paginate(page: params[:page], :per_page => 10)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.create(quiz_params)
    if @quiz.save
      flash[:success] = "Quiz created!"
      redirect_to quizzes_path
    else
      render 'new'
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update_attributes(quiz_params)
      flash[:success] = "Quiz updated"
      redirect_to quizzes_path
    else
      render 'edit'
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    flash[:success] = "Quiz destroyed!"
    redirect_to quizzes_path
  end

  private
   
    def quiz_params
      params.require(:quiz).permit(:title)
    end 
    #Before filters

    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
