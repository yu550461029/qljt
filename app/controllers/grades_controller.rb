class GradesController < ApplicationController
  def grade
    render "grade", layout: "grade_layout"
  end
  def save_grade
  end
end
