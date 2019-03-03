module VisibleAssignment
  module ActionControllerExtension
    def view_assigns
      if VisibleAssignment.config.enable_instance_variables
        super.merge(all_view_assign_variables)
      else
        all_view_assign_variables
      end
    end

    def view_assign_variables=(variables)
      @_assign_variables = variables
    end

    def global_view_assign_variables=(variables)
      @_global_assign_variables = variables
    end

    def all_view_assign_variables
      @_assign_variables ||= {}
      @_global_assign_variables ||= {}
      @_global_assign_variables.merge(@_assign_variables)
    end
  end
end