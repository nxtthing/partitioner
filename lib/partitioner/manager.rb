module Partitioner
  class Manager
    def initialize(object)
      @object = object
    end

    delegate :transaction, to: :connection

    def on_create
      transaction do
        create_partitions
        add_partition_indexes
        add_partition_foreign_keys
        yield if block_given?
      end
    end

    def on_destroy
      transaction do
        drop_partitions
      end
    end

    def postfix
      raise NotImplementedError, "#postfix"
    end

    protected

    def partitioned_models
      []
    end

    def partitioned_tables
      partitioned_models.map(&:table_name)
    end

    def create_partitions
      partitioned_tables.each do |table_name|
        connection.create_list_partition_of table_name, name: "#{table_name}_#{postfix}", values: @object.id
      end
    end

    def add_partition_indexes
      # DO NOTHING by default
    end

    def add_partition_foreign_keys
      # DO NOTHING by default
    end

    def drop_partitions
      partitioned_tables.reverse.each do |table_name|
        connection.detach_partition table_name, "#{table_name}_#{postfix}"
        connection.drop_table "#{table_name}_#{postfix}"
      end
    end

    def connection
      @object.class.connection
    end
  end
end
