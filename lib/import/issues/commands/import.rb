# frozen_string_literal: true

require_relative '../command'

require 'net/http'
require 'uri'
require 'json'
require 'octokit'

module Import
  module Issues
    module Commands
      class Import < Import::Issues::Command
        def initialize(options)
          @options = options
          @trello_api_uri = "https://api.trello.com/1/"
        end

        def execute(input: $stdin, output: $stdout)
          # Command logic goes here ...
          output.puts "You will need your GitHub username/password and a Trello key & token. You can get these here: https://trello.com/app-key"
          open_cards, completed_cards = trello_process

          client = github_login
        
          repos = client.repos

          choices = client.repos.map{ |x| x["name"] }
          selected_repo = prompt.enum_select("Select a repo to add issues to: ", choices)

          repo = client.repos.find{ |repo| repo["name"] == selected_repo }

          open_cards.each do |card|
            client.create_issue(repo['id'], card['name'], card['desc'])
          end

          completed_cards.each do |card|
            issue = client.create_issue(repo['id'], card['name'], card['desc'], {"state" => "closed"})
            client.close_issue(repo['id'], issue['number'])
          end

          output.puts "Successfully moved cards from Trello to GitHub"

        end

        private

        def github_login
          github_username = prompt.ask('What is your GitHub username?', required: true)
          github_password = prompt.mask('What is your GitHub password?', required: true) 
          Octokit::Client.new(:login => github_username, :password => github_password)
        end

        def trello_process
          @trello_key = prompt.ask('What is your Trello key?', required: true) 
          @trello_token = prompt.ask('What is your Trello token?', required: true) 
          @key_param = "#{@trello_key}&token=#{@trello_token}"

          boards = trello_boards
          board_choices = boards.map{ |x| x["name"] }

          selected_board = prompt.enum_select("Select a Trello board to move issues from: ", board_choices)
          board = boards.find{ |board| board["name"] == selected_board }
          lists = trello_lists(board['id'])

          list_choices = lists.map{ |x| x["name"] }

          issue_list = prompt.enum_select("Select a list to import as open issues: ", list_choices)
          issue_list = lists.find{ |list| list["name"] == issue_list }
          open_cards = trello_cards(issue_list['id'])

          completed_list = prompt.enum_select("Select a list to import as completed issues: ", list_choices)
          completed_list = lists.find{ |list| list["name"] == completed_list }
          completed_cards = trello_cards(completed_list['id'])

          return open_cards, completed_cards
        end

        def trello_boards
          uri = URI.parse("#{@trello_api_uri}members/me/boards?key=#{@key_param}")
          response = trello_request(uri)
          boards = JSON.parse(response.body)
        end

        def trello_lists(id)
          uri = URI.parse("#{@trello_api_uri}boards/#{id}/lists?key=#{@key_param}")
          response = trello_request(uri)
          lists = JSON.parse(response.body)
        end

        def trello_cards(id)
          uri = URI.parse("#{@trello_api_uri}lists/#{id}/cards?key=#{@key_param}")
          response = trello_request(uri)
          cards = JSON.parse(response.body)
        end

        def trello_request(uri)
          request = Net::HTTP::Get.new(uri)
          req_options = {
            use_ssl: uri.scheme == "https",
          }

          response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
          end
          return response
        end

      end
    end
  end
end
