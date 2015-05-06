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
	def present(object, klass = nil)
		klass ||= "#{object.class}Presenter".constantize
		presenter = klass.new(object, self)
		yield presenter if block_given?
		presenter
	end
end
