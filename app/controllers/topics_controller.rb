class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ]
  # load_and_authorize_resource

  # GET /topics or /topics.json
  def index
    if params[:search]
      @topics = Topic.where("title LIKE ?", "%#{params[:search]}%")
    else
      @topics = Topic.includes(:user).all
    end
  end

  # GET /topics/1 or /topics/1.json
  def show
    @topics=Topic.find(params[:id])
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    # authorize! :create, @topic
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics or /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = 1  # Set the user_id to 1

      if @topic.save
        flash[:success] = 'Topic was successfully created.'
        redirect_to topics_path
      else
        render 'new'
      end

  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: "Topic was successfully updated." }
        format.json { render :show, status: :ok, location: @topic }
      else
        # format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @topic.errors, status: :unprocessable_entity }
        flash[:alert] = "Topic update failed. Please check the form."
        render :edit
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url, notice: "Topic was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:title, :author, :user_id)
    end
end
