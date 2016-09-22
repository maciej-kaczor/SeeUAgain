class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :sign_up]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.owner_id = session[:user_id]
    respond_to do |format|
      if @event.save
        users = User.all
        users.each do |user|
          UserMailer.new_event_email(user, @event).deliver
        end 
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if @event.owner_id == session[:user_id] 
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to events_url, notice: 'You can only delete events you are the owner of.' }
    end
  end

  def sign_up
    if @event.max_participants - @event.users.length > 0
      begin
        user = User.find(session[:user_id])
        @event.users << user
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:alert] = "You already signed up to participate in this event"
      end
    else 
      flash[:notice] = "Sorry, this event already has a maximum number of participants"
    end
    redirect_to @event
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :place, :date, :max_participants)
    end
end
