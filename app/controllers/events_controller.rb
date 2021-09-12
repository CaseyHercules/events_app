class EventsController < ApplicationController

    ### GET /events /stats /daily_stats
    # Takes all events recieved today and groups them
    # event_type and returns the count for each in JSON.
    # EXAMPLE: { "todays_stats" :[{"click" : 34}, {"view": 54}]}
    def index
        events = Event.all
        render json: events
    end


    ### POST /events
    # Requires 
    def create
        event = Event.new(name:params[:name],event_type:params[:event_type],data: data_params)
        if event.save
            render json: event, status: :created #201
        else
            render json: event.errors, status: :unprocessable_entity #422
        end
    end 



    private

    def data_params
        params.except(:name,:event_type,:controller,:action,:event).each{|key| "#{key}"}.to_h.to_a
    end
end
