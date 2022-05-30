require 'graphql/client'
require 'graphql/client/http'

module SpaceXAPI
  HTTP = GraphQL::Client::HTTP.new('https://api.spacex.land/graphql')
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

  HistoriesQuery = Client.parse <<~GRAPHQL
    query($limit: Int, $offset: Int) {
      histories(limit: $limit, offset: $offset) {
        id
        details
      }
    }
  GRAPHQL
  LandpadsQuery = Client.parse <<~GRAPHQL
    query($limit: Int, $offset: Int) {
      landpads(limit: $limit, offset: $offset) {
        id
        full_name
        details
      }
    }
  GRAPHQL
  LaunchesQuery = Client.parse <<~GRAPHQL
    query($limit: Int, $offset: Int) {
      launches(limit: $limit, offset: $offset) {
        id
        details
        mission_name
      }
    }
  GRAPHQL
  LaunchpadsQuery = Client.parse <<~GRAPHQL
    query($limit: Int, $offset: Int) {
      launchpads(limit: $limit, offset: $offset) {
        id
        name
        details
      }
    }
  GRAPHQL
  MissionsQuery = Client.parse <<~GRAPHQL
    query($limit: Int, $offset: Int) {
      missions(limit: $limit, offset: $offset) {
        id
        description
        name
      }
    }
  GRAPHQL
  RocketsQuery = Client.parse <<~GRAPHQL
    query($limit: Int, $offset: Int) {
      rockets(limit: $limit, offset: $offset) {
        id
        description
        name
      }
    }
  GRAPHQL
  ShipsQuery = Client.parse <<~GRAPHQL
    query($limit: Int, $offset: Int) {
      ships(limit: $limit, offset: $offset) {
        id
        name
      }
    }
  GRAPHQL

  QUERIES = [DragonsQuery, HistoriesQuery, LandpadsQuery, LaunchesQuery, LaunchpadsQuery, MissionsQuery, RocketsQuery,
             ShipsQuery].freeze
end
