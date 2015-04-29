module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
	  base_title = "DTAS Estimator"
	  if page_title.empty?
	    base_title
	  else
	    "#{page_title} | #{base_title}"
	  end
	end
	
	# Presenters
	def present(model, presenter_class = nil)
		klass ||= "#{model.class}Presenter".constantize
		presenter = klass.new(model, self)
		yield presenter if block_given?
		return presenter
	end
end
