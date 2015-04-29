class BasePresenter < SimpleDelegator
    def initialize(model, view)
        @model, @view = model, view
        super(@model)
    end
    
    def self.presents(name)
       define_method(name) do
           @model
       end
    end
       
    def h 
        @view
    end
    
    def method_missing(*args, &block)
        @view.send(*args, &block)
    end
end