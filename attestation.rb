module Attester
  def included(base)
    base.include :InstanceMethods
  end

  module InstanceMethods
    def valid?
      valid!
      true
    rescue RuntimeError
      false
    end
  end
end