require "pg_party"

PgParty.configure do |c|
  c.create_template_tables = false
  c.create_with_primary_key = false
  c.schema_exclude_partitions = false
end
