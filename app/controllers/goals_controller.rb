class GoalsController < ApplicationController
  def index
    @goals = Goal.all

    respond_to do |format|
      format.html
      format.json { render :json => @goals }
    end
  end

  def show
    @goal = Goal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @goal }
    end
  end

  def new
    @goal = Goal.new

    respond_to do |format|
      format.htm
      format.json { render :json => @goal }
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def create
    @goal = Goal.new(params[:goal])

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, :notice => 'Goal was successfully created.' }
        format.json { render :json => @goal, :status => :created, :location => @goal }
      else
        format.html { render :action => "new" }
        format.json { render :json => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @goal = Goal.find(params[:id])

    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to @goal, :notice => 'Goal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to goals_url }
      format.json { head :ok }
    end
  end
end
