class ScoresController < ApplicationController
  layout "grade_layout"
  def index
  end
  def show
    redirect_to scores_url
  end
  def get_score_list
    license_key = params[:license]
    #这个地方需要把密码条放到session里面
    license = License.where("content = ? and is_used = 0", license_key)
    if license.empty?
        @msg = "密码条已使用或无效密码条"
        redirect_to scores_url, notice: '密码条已使用或无效密码条'
    else
      @license_key = license.first.content
      if license.first.license_type == 1
        @employee_list = []
        employee_relation = PositionRelationship.where("position_id = ? and relationship_type = 1", license.first.position_id)
        employee_relation.each do |er|
          employee = Employee.find(er.entity_id)
          position = Position.find(employee.position_id)
          team = Team.find(position.team_id)
          em_hash = Hash.new
          em_hash["employee_name"] = employee.name
          em_hash["employee_id"] = employee.id
          em_hash["employee_team"] = team.name
          @employee_list.push(em_hash)
        end
        render "employee"
      else
        @team_list = []
        team_relation = PositionRelationship.where("position_id = ? and relationship_type = 2", license.first.position_id)
        team_relation.each do |tr|
          team = Team.find(tr.entity_id)
          tr_hash = Hash.new
          tr_hash["team_name"] = team.name
          tr_hash["team_id"] = team.id
          @team_list.push(tr_hash)
        end
        render "team"
      end
    end
  end
  def post_employee
  end
  def post_team_socre
  end
  def save_employee_score
    employee_data = JSON::parse(params["employee_data"])
    license = License.where("content = ? and is_used = 0", params["license_key"])
    save_flag = 1
    if license.empty?
      @msg = "密码条已使用或无效密码条"
      redirect_to scores_url, notice: '密码条已使用或无效密码条'
    else
      employee_data.each do |td|
        td_new = eval(td)
        position_relationship = PositionRelationship.where("position_id = ? and relationship_type = 1 and entity_id = ?",license.first.position_id, td_new[:employee_id])
        if position_relationship.empty?
          save_flag = 0
          break
        end
      end
    end
    if save_flag == 1
      employee_data.each do |td|
        td_new = eval(td)
        score = Score.new
        score.position_id = license.first.position_id
        score.score = td_new[:employee_score]
        score.entity_type = 1
        score.entity_id = td_new[:employee_id]
        score.license_id = license.first.id
        score.save
      end
      license.first.is_used = 1
      license.first.save
      redirect_to success_scores_url
    else
      @msg = "密码条已使用或无效密码条"
      redirect_to scores_url, notice: '密码条已使用或无效密码条'
    end
  end
  def save_team_score
    team_data = JSON::parse(params["team_data"])
    license = License.where("content = ? and is_used = 0", params["license_key"])
    save_flag = 1
    if license.empty?
      @msg = "密码条已使用或无效密码条"
      redirect_to scores_url, notice: '密码条已使用或无效密码条'
    else
      team_data.each do |td|
        td_new = eval(td)
        position_relationship = PositionRelationship.where("position_id = ? and relationship_type = 2 and entity_id = ?",license.first.position_id, td_new[:team_id])
        if position_relationship.empty?
          save_flag = 0
          break
        end
      end
    end
    if save_flag == 1
      team_data.each do |td|
        td_new = eval(td)
        score = Score.new
        score.position_id = license.first.position_id
        score.score = td_new[:team_score]
        score.entity_type = 2
        score.entity_id = td_new[:team_id]
        score.license_id = license.first.id
        score.save
      end
      license.first.is_used = 1
      license.first.save
      redirect_to success_scores_url
    else
      @msg = "密码条已使用或无效密码条"
      redirect_to scores_url, notice: '密码条已使用或无效密码条'
    end
  end
  def get_success
    render "success", layout: false
  end
end
