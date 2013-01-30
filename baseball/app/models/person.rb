class Person < ActiveRecord::Base
  set_table_name(:master)
  set_primary_key(:lahmanID)

  has_many :playerships, :foreign_key => :playerID,
  :primary_key => :playerID
  has_many :teams, :through => :playerships

  has_many :pitching_lines, :foreign_key => :playerID,
  :primary_key => :playerID

  has_many :batting_lines, :foreign_key => :playerID,
  :primary_key => :playerID

  has_many :salaries, :foreign_key => :playerID,
  :primary_key => :playerID

  has_many :managerships, :foreign_key => :managerID,
    :primary_key => :managerID

  has_many :teams, :through => :managerships

  def self.best_playas
    self
      .select("master.nameFirst, master.nameLast, (batting.H / batting.AB)")
      .joins(:batting_lines)
      .where("(batting.H / batting.AB) > ? ", 0.300)
      .where("batting.AB > ?", 100)
      .group("master.playerID")
  end

  def self.most_experience
    self
      .select("master.*, (master.finalGame - master.debut)/24/365 as career_length")
      .where("master.finalGame is not null")
      .where("master.debut is not null")
      .where("master.playerID is not null")
      .order("career_length DESC")
      .limit(1)
  end

  def self.most_managed
    self
      .select("nameFirst, nameLast, appearances.playerID, teams.name,
        count(DISTINCT appearances.playerID) AS player_count")
      .joins(:managerships)
      .joins(:teams)
      .joins(:playerships)
      .group("managers.managerID")
      .order("player_count ASC")
      .limit(1)
  end

    # SELECT nameFirst, nameLast, appearances.playerID, teams.name,
    #   count(DISTINCT appearances.playerID) AS player_count
    # FROM master
    # JOIN managers ON master.managerID = managers.managerID
    # JOIN teams ON managers.teamID = teams.teamID
    #   AND managers.yearID = teams.yearID
    # JOIN appearances ON teams.teamID = appearances.teamID
    #   AND teams.yearID = appearances.yearID
    # GROUP BY managers.managerID
    # ORDER BY player_count DESC
    # LIMIT 1;

  #people who have beeen both a player and a manager
  def self.player_manager
    self
      .select("master.*")
      .where("playerID is not null")
      .where("managerID is not null")
  end

end













