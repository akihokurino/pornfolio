module TransformType
  extend ActiveSupport::Concern

  module ClassMethods
    def name_obj
      Hash[*all.map{ |i| [i.name, i.id]}.flatten].symbolize_keys
    end
  end

end