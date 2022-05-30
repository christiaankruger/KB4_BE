require "graphql/client"
require "graphql/client/http"

def with_find(fields)
  { fields: fields, has_find: true }
end

def without_find(fields)
  { fields: fields, has_find: false }
end

module SpaceXAPI
  SEARCHABLE_ENTITIES = {
    dragons: ([:name, :description]),
    histories: ([:details]),
    landpads: ([:full_name, :details]),
    launches: ([:details, :mission_name]),
    launchpads: ([:name, :details]),
    missions: ([:description, :name]),
    rockets: ([:name, :description]),
    ships: ([:name]),
  }
  HTTP = GraphQL::Client::HTTP.new("https://api.spacex.land/graphql")
  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

  DragonsQuery = Client.parse <<-GRAPHQL
    query($limit: Int, $offset: Int) {
      dragons(limit: $limit, offset: $offset) {
        id
        name
        description
      }
    }
  GRAPHQL

  def self.search

  end
end
