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
        event = Event.new(event_params)
        if event.save
            render json: event, status: :created #201
        else
            #render json: {error: 'Unable to create User, Missing:'+event.errors}, status: :unprocessable_entity #422
            render json: event.errors, status: :unprocessable_entity #422
        end
    end 



    private

    def event_params
        params.require(:event)
    end
end
