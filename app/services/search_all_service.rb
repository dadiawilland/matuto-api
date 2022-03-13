class SearchAllService
    attr_accessor :search_params, :value_params, :model

    def initialize(search_params, value_params, model)
        @search_params = search_params
        @value_params = value_params
        @model = model
    end

    def execute
        return model.where(value_params.slice(*search_params).permit!) if search_params.any?
        return model.all
    end
end