require "import/issues/version"

module Import
  module Issues
    module Services
      Class GitHub

        def initialize(username, password)
          @username = username
          @password = password
        end

        def perform
          client = Octokit::Client.new(:login => github_username, :password => github_password)
        end
      end
    end
  end
end
