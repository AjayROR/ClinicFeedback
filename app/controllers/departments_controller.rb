class DepartmentsController < ApplicationController

  def index
    @departments  = Department.all #find(:all, :order => 'name')
    respond_to do |format|
               format.html #index.html.erb
              format.json { render json: @departments }
    end
  end

  def show
    @department = Department.find(params[:id])
    #@department = Department.paginate(:page => params[:page], :per_page => 5)
    @department_doctors = @department.users.paginate(:page => params[:page], :per_page => 5, :order => 'name ASC')

    respond_to do |format|
        format.html #show.html.erb
        format.js #show.js.erb
    end

  end

  def new
    @department = Department.new
  end

  
  def edit
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.create(params[:department])

      if @department.save
      redirect_to departments_path, notice: 'department was successfully created'
      else
        render action: "new"  
      end
  end
 
  def update
    @department = Department.find(params[:id])

      if @department.update_attributes(params[:department])
      redirect_to department_path, notice: 'Department was successfully updated.' 
      else
      render action: "edit"
      end
  end
  
  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to departments_url
  end
  end