class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @teams = Team.all
    render "index"
  end
  def show
    team_id = params[:id]
    @team = Team.find(team_id)
    @positions = Position.where("team_id = ?", params[:id])
  end
  def position
    position_id = params[:position_id]
    @position = Position.find(position_id)
    @employees  =  Employee.where("position_id = ?", position_id)
    @all_employees = []
    @all_teams = []
    all_employees = Employee.all
    all_teams = Team.all
    all_employees.each do |a_e|
      p_r = PositionRelationship.where("position_id = ? and entity_id = ? and relationship_type = 1 ", @position.id, a_e.id)
      e_r = Hash.new
      position = Position.find(a_e.position_id)
      team = Team.find(position.team_id)
      e_r["employee_name"] = a_e.name
      e_r["employee_id"] = a_e.id
      e_r["employee_position"] = team.name + "/" + position.name
      if p_r.empty?
        e_r["employee_select"] = 0
      else
        e_r["employee_select"] = 1
      end
      @all_employees.push(e_r)
    end
    all_teams.each do |a_t|
      p_r2 = PositionRelationship.where("position_id = ? and entity_id = ? and relationship_type = 2 ", @position.id, a_t.id)
      t_r = Hash.new
      t_r["team_name"] =  a_t.name
      t_r["team_id"] = a_t.id
      if p_r2.empty?
        t_r["team_select"] = 0
      else
        t_r["team_select"] = 1
      end
      @all_teams.push(t_r)
    end
    @licenses_team = License.where("license_type = 2 and position_id = ? and publish_status = 1", position_id)
    @licenses_employee = License.where("license_type = 1 and position_id = ? and publish_status = 1", position_id)
    render 'position'
  end
  def team_relation_save
    team_list = params[:team_selecteds]
    position_id = params[:position_id]
    PositionRelationship.where("position_id = ? and relationship_type = 2", position_id).delete_all
    team_list.each do |tl|
      position_relationship = PositionRelationship.new
      position_relationship.position_id = position_id
      position_relationship.relationship_type = 2
      position_relationship.entity_id = tl
      position_relationship.created_at = Time.now
      position_relationship.updated_at = Time.now
      position_relationship.save
    end
  end
  def employee_relation_save
    employee_list = params[:employee_selecteds]
    position_id = params[:position_id]
    PositionRelationship.where("position_id = ? and relationship_type = 1", position_id).delete_all
    employee_list.each do |el|
      position_relationship = PositionRelationship.new
      position_relationship.position_id = position_id
      position_relationship.relationship_type = 1
      position_relationship.entity_id = el
      position_relationship.created_at = Time.now
      position_relationship.updated_at = Time.now
      position_relationship.save
    end
  end
  def export_license
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => '青岛分公司密码条'
    line = 1
    teams = Team.all
    teams.each do |t|
      positions = Position.where("team_id = ?", t.id)
      if !(positions.empty?)
        positions.each do |p|
          licenses1 = License.where("position_id = ? and license_type = 1", p.id)
          if !(licenses1.empty?)
            sheet1[line,0] = t.name + p.name
            line = line + 1
            licenses1.each do |l1|
              sheet1[line,0] = "员工民主评议"
              sheet1[line,1] = "密码"
              sheet1[line,2] = "电脑端和手机端登录网址"
              sheet1[line,3] = "二维码扫描登录"
              line = line + 1
              sheet1[line,1] = l1.content
              sheet1[line,2] = "www.baidu.com"
              sheet1[line,3] = "扫描现场二维码"
              line = line + 1
            end
          end
          licenses2 = License.where("position_id = ? and license_type = 2", p.id)
          if !(licenses2.empty?)
            sheet1[line,0] = t.name + p.name
            line = line + 1
            licenses2.each do |l2|
              sheet1[line,0] = "部门民主评议"
              sheet1[line,1] = "密码"
              sheet1[line,2] = "电脑端和手机端登录网址"
              sheet1[line,3] = "二维码扫描登录"
              line = line + 1
              sheet1[line,1] = l2.content
              sheet1[line,2] = "www.baidu.com"
              sheet1[line,3] = "扫描现场二维码"
              line = line + 1
            end
          end
        end
      end
    end
    book.write 'public/download/excel-file.xls'
    send_file "#{Rails.root}/public/download/excel-file.xls"
  end
end
