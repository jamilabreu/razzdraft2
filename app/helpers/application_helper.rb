module ApplicationHelper
	def impact(x, t1, t2, t3)
		x.zero? ? "zero" : x >= t1 ? "best" : x >= t2 ? "good" : x >= t3 ? "average" : "poor"
	end

	def impact_inverse(x, t1, t2, t3)
		x.zero? ? "zero" : x <= t1 ? "best" : x <= t2 ? "good" : x <= t3 ? "average" : "poor"
	end

	def header_class(stat)
		params[:sort] == stat.to_s ? 'selected' : nil
	end

	def header_path(stat, direction)
		root_path(position: params[:position], sort: stat, direction: direction)
	end
  def position_name(abbrev)
    if abbrev == "C"
      "catcher"
    elsif abbrev == "1B"
      "first_base"
    elsif abbrev == "2B"
      "second_base"
    elsif abbrev == "SS"
      "shortstop"
    elsif abbrev == "3B"
      "third_base"
    elsif abbrev == "OF"
      "outfield"
    elsif abbrev == "UTIL"
      "util"
    elsif abbrev == "SP"
      "starter"
    elsif abbrev == "RP"
      "reliever"
    elsif abbrev == "MI"
      "middle_infielder"
    elsif abbrev == "CI"
      "corner_infielder"
    end
  end
end
