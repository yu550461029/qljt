class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
    @emps = []
    @employees.each do |employee|
      emp = Hash.new
      emp["id"] = employee.id
      emp_position = Position.find(employee.position_id)
      emp_team = Team.find(emp_position.team_id)
      emp["name"] = employee.name
      emp["team_name"] = emp_team.name
      emp["desc"] = employee.desc
      emp["level"] = employee.level
      emp["position_name"] = emp_position.name
      emp["score"] = employee.score
      @emps.push(emp)
    end
    render 'index'
  end
  def upload
    require 'roo'
    uploaded_io = params[:excel]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    xlsx_file = './public/uploads/'+ uploaded_io.original_filename
    xlsx = Roo::Excelx.new(xlsx_file)
    xlsx.sheet(0).each_with_index do |row, index|
      if index >0
        employee = Employee.new
        employee.name = row[2]
        employee.desc = row[4]
        employee.publish_status = 1
        employee.created_at = Time.now
        employee.updated_at = Time.now
        employee.identification = row[9]
        employee.gender = row[3]
        employee.level = row[5]
        employee.age = row[8]
        team_name = row[1]
        team = Team.where("name = ?", team_name)
        if team.empty?
          team = Team.new
          team.name = team_name
          team.publish_status = 1
          team.team_type = 2
          team.created_at = Time.now
          team.updated_at = Time.now
          team.save
          position = Position.new
          position.team_id = team.id
          position.name = row[6]
          position.publish_status = 1
          if row[6].eql?("经营层")
            position.position_type = 1
            position.position_weight = 0.2
            position.employee_weight = 0.2
          elsif row[6].eql?("中层")
            position.position_type = 2
            position.position_weight = 0.2
            position.employee_weight = 0.2
          elsif row[6].eql?("一般员工")
            position.position_type = 3
            position.position_weight = 0.2
            position.employee_weight = 0.2
          else
            position.position_type = 4
            position.position_weight = 0.2
            position.employee_weight = 0.2
          end
          position.created_at = Time.now
          position.updated_at = Time.now
          position.save
          employee.position_id = position.id
          employee.save
        else
          position = Position.where("name = ? and team_id = ? ", row[6], team.first.id)
          if position.empty?
            position = Position.new
            position.team_id = team.first.id
            position.name = row[6]
            position.publish_status = 1
            if row[6].eql?("经营层")
              position.position_type = 1
              position.position_weight = 0.2
              position.employee_weight = 0.2
            elsif row[6].eql?("中层")
              position.position_type = 2
              position.position_weight = 0.2
              position.employee_weight = 0.2
            elsif row[6].eql?("一般员工")
              position.position_type = 3
              position.position_weight = 0.2
              position.employee_weight = 0.2
            else
              position.position_type = 4
              position.position_weight = 0.2
              position.employee_weight = 0.2
            end
            position.created_at = Time.now
            position.updated_at = Time.now
            position.save
            employee.position_id = position.id
            employee.save
          else
            employee.position_id = position.first.id
            employee.save
          end
        end
      end
    end
    render 'index'
  end
end
