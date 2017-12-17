class LicensesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def reset_license
    License.update_all "publish_status = 0"
    positions = Position.where("publish_status = 1")
    positions.each do |p|
      employees = Employee.where("position_id = ?", p.id)
      if  employees.length>0 && employees.length<5
        for i in 0..employees.length+2
          key1 = SecureRandom.hex(4)
          key2 = SecureRandom.hex(4)
          license_team = License.new
          license_team.content = key1
          license_team.position_id = p.id
          license_team.license_type = 2
          license_team.is_used = 0
          license_team.created_at = Time.now
          license_team.updated_at = Time.now
          license_team.publish_status = 1
          license_team.save
          license_employee = License.new
          license_employee.content = key2
          license_employee.position_id = p.id
          license_employee.license_type = 1
          license_employee.is_used = 0
          license_employee.created_at = Time.now
          license_employee.updated_at = Time.now
          license_employee.publish_status = 1
          license_employee.save
        end
      elsif employees.length>5
        for i in 0..employees.length+5
          key1 = SecureRandom.hex(4)
          key2 = SecureRandom.hex(4)
          license_team = License.new
          license_team.content = key1
          license_team.position_id = p.id
          license_team.license_type = 2
          license_team.is_used = 0
          license_team.created_at = Time.now
          license_team.updated_at = Time.now
          license_team.publish_status = 1
          license_team.save
          license_employee = License.new
          license_employee.content = key2 
          license_employee.position_id = p.id
          license_employee.license_type = 1
          license_employee.is_used = 0
          license_employee.created_at = Time.now
          license_employee.updated_at = Time.now
          license_employee.publish_status = 1
          license_employee.save
        end
      end
    end
  end
end
