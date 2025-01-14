class ChronicPingController < ActionController::Base
  def parse
    unless params[:q].blank?
      begin
        format = ChronicPing.config.formats[params[:f] || :default] || params[:f]
        ctx = params[:c].to_sym if params[:c].present?
        ctx ||= :past
        response = Chronic.parse(params[:q], context: ctx).strftime(format)

        render :json => { status: :success, response: response }
      rescue
        render :json => { status: :error, response: "" }
      end
    else
      render :json => { status: :incomplete_query, response: "" }
    end
  end
end
