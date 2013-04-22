class ApplicationController < ActionController::Base
  protect_from_forgery

    def boblog (*args)
    response = args.map(&:inspect).join("\n\n:=>\n\n")
    logger.debug "\n\n========== BOB ==========\n\n:=> \n\n#{response}\n\n=========================\n\n"

    logger.debug ApplicationController.instance_method(:boblog).parameters
  end
  helper_method :boblog

end
