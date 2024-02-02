class Api::V1::EventEnrollsController < ApplicationController
  skip_before_action :doorkeeper_authorize!

  def index
    participants = EventEnroll.all
     !participants ?
        (render json: {message: 'Not Any Participants', success: false}, status: 200)
      :
        (render json: {message: 'Participants List', participants: participants, success: true}, status: 200)
  end

  def create
    participant = EventEnroll.new(enroll_params)
    if participant.save
      render json: { message: 'SuccessFully Enroll', success: true }, status: 201
    else
      render json: { message: participant.errorsr.full_messages.join(','), success: false}, status: 200
    end
  end

  def update
    participant = EventEnroll.find_by_id(params[:id])
    if participant
      if participant.update(participant_params)
        render json: {message: 'Success', success: true }, status: 200
      else
        render json: {message: participant.errors.full_messages.join(','),  success: false }, status: 200
      end
    else
      render json: {message: participant.errors.full_messages.join(','),  success: false }, status: 200
    end
  end

  def scanne_qr
    if params[:qrcode_id].present?
      qr_code = ActiveStorage::Blob.find_by(id: params[:qrcode_id])
      if qr_code
        if qr_code.qr_scanned == false 
          render json: {message: 'Found Qr Code', qr_code: qr_code, success: true }, status: 200 
        else
          render json: {message: 'This QR Is Not Valid', success: false }, status: 200
        end
      else
        render json: {message: 'Not Found QR', success: false }, status: 200
      end
    end
  end
  private
  
  def enroll_params
    params.require(:event_enroll).permit(:user_id, :event_id, :present_at_event, :present_date, :present_time, enroll_date: [])
  end
end
