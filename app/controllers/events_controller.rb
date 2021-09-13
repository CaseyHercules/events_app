class EventsController < ApplicationController

    ### GET /events /stats /daily_stats
    # Takes all events recieved today and groups them
    # event_type and returns the count for each in JSON.
    # EXAMPLE: { "todays_stats" :[{"click" : 34}, {"view": 54}]}
    def index
        stats_json = []
        Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).distinct.pluck(:event_type).each do |eT|
            stats_json << {eT => Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, event_type: eT).count}
        end
        render json: {"todays_stats":stats_json}
    end


    ### POST /events
    # Requires 
    def create
        event = Event.new(name:params[:name],event_type:params[:event_type],data: data_params)
        if event.save
            render json: render_post_output(event), status: :created #201
        else
            render json: event.errors, status: :unprocessable_entity #422
        end
    end 



    private

    def data_params
        params.except(:name,:event_type,:controller,:action,:event).each{|key| "#{key}"}.to_h.to_a
    end

    def render_post_output(event)
        responce_json = Hash.new
        responce_json[:id] = event.id
        responce_json[:name] = event.name
        responce_json[:event_type] = event.event_type
        event.data.each{|val| responce_json[val[0]] = val[1]}
        responce_json[:created_at] = event.created_at
        responce_json[:updated_at] = event.updated_at
        responce_json
    end
end
