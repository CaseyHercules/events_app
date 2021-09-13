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
        render json: {"todays_stats":stats_json}, status: :ok #200
    end


    ### POST /events
    # Runs data_params and render_post_output to orginize and give a useful responce
    # Also Sends error if name or event_type is null or absent
    def create
        event = Event.new(name:params[:event][:name],event_type:params[:event][:event_type],data: data_params)
        if event.save
            render json: {"event":render_post_output(event)}, status: :created #201
        else
            render json: event.errors, status: :unprocessable_entity #422
        end
    end 



    private

    #Strips out all non-constant json keys
    #Then places them into an array for storage within pg database
    def data_params
        params.except(:name,:event_type,:controller,:action,:event).each{|key| "#{key}"}.to_h.to_a
    end

    #Instead of default json output
    #This formats the json so that the extra data key values pairs arn't under an extra "data" json key
    #But is on the same level as all of the other key value pairs.
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
