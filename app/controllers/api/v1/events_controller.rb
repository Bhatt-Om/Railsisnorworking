class Api::V1::EventsController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  def index
    events = Event.all
    if events
      (render json: { message: 'List Of All Events Details', events: , success: true }, status: 200)
    else
      (render json: { message: 'There Is Not Aany Event',events: , success: false }, status: 200)
    end
  end

  def show
    event = Event.find_by(id: params[:id])
    render json: { message: 'Event Details', event: , success: true }, status: 200
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: { message: 'Event Details', event: , success: true }, status: 201
    else
      render json: { message: event.erros.full_messages.join(',') , success: false }, status: 422
    end
  end

  def update
    event = Event.find_by(id: params[:id])
    if event.update(event_params)
      render json: { message: 'Event Details', event: , success: true }, status: 200
    else
      render json: { message: event.erros.full_messages.join(',') , success: false }, status: 422
    end
  end

  def dstroy
    event = Event.find_by(id: params[:id])
    event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :discription, :starting_date, :ending_date)
  end
end
