class EventsController < ApplicationController

    #GET /all
    def debug
        @events = Event.all
        render json: @events
    end

    #POST /events
    def createEvent
        @event = event.new(event_params)
        if @event.save
            render json: @event
        else
            render error: {error: 'Unable to create User, Need... TODO'}, status: 422
        end
    end 
end
