module Partitioner
  module Model
    extend ActiveSupport::Concern

    included do
      before_destroy -> { partitions_manager.on_destroy }
      after_create_commit -> { partitions_manager.on_create }
    end

    def partition_postfix
      @partition_postfix ||= partitions_manager.postfix
    end

    protected

    def partitions_manager_class
      raise NotImplementedError, "#partition_manager_class"
    end

    def partitions_manager
      @partitions_manager ||= partitions_manager_class.new(self)
    end
  end
end
