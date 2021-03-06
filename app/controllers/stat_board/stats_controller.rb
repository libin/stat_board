require_dependency "stat_board/application_controller"

module StatBoard
  class StatsController < ApplicationController
    before_filter :basic_authenticate, :if => lambda { StatBoard.username && StatBoard.password }

    def index
      @reports = [
        Reports::OverallReport.new,
        Reports::MonthlyReport.new,
        Reports::WeeklyReport.new
      ]
    end

    private

    def basic_authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == StatBoard.username && password == StatBoard.password
      end
    end
  end
end
