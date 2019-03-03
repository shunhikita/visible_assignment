require "visible_assignment/version"

require 'active_support'
require 'visible_assignment/config'
require 'visible_assignment/action_controller_extension'

module VisibleAssignment
  class Error < StandardError; end

  ActiveSupport.on_load(:action_controller) do
    include ActionControllerExtension
  end
end
