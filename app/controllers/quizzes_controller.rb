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
      if questions_file[:file] 
        file = questions_file[:file]
        import(file)
      end
      flash[:success] = "Quiz created!"
      redirect_to quizzes_path
    else
      render 'new'
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions.paginate(page: params[:page])
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


  def import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      @quiz.questions.create! row.to_hash
    end
  end


  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


  private
   
    def quiz_params
      params.require(:quiz).permit(:title)
    end 

    def questions_file
      params.require(:quiz).permit(:file)
    end 
    #Before filters

    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
