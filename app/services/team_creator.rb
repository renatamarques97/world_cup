class TeamCreator
  attr_reader :team_params

  def initialize(team_params:)
    @team_params = team_params
  end

  def created?
    team = Team.new(team_params[:team])
    team.save
  end
end
