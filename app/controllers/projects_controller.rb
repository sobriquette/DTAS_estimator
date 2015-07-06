class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    task = @project.tasks.build
    task.task_tags.build.build_tag

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :flash => { :success => 'Project was successfully created.'}) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    params[:project][:tag_ids] ||= []

    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to(@project, :flash => { :success => 'Project was successfully updated.'}) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(projects_url, :flash => { :success => 'Project deleted'}) }
      format.xml  { head :ok }
    end
  end

  def show_est_time
    avg_time = Tag.est_time(params[:tag_id])
    puts "this is the average: #{avg_time}"
    complexity_id = params[:complexity_id]
    puts "this is the select: #{complexity_id}"
    # mapping = Task.complexities[params[:complexity_id]]
    # puts "this is the enum mapping: #{mapping}"
    if avg_time == 1
        @time_text = 10
    else
      @time_text = avg_time * Task.complexities[params[:complexity_id]]
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :owner_id,
                                      tasks_attributes: [:id, :_destroy, :name, :description, :done, :complexity, :actual_time, :est_time,
                           	                             {sub_tasks_attributes: [:id, :_destroy, :name, :description]},
                           	                             {task_tags_attributes: [:id, :_destroy, :tag_id, 
                              	                           {tag_attributes: [:id, :_destroy, :name]}
                                                         ], :tag_ids => []}
                                      ], people_attributes: [:id, :_destroy, :name]
    )
  end
end
