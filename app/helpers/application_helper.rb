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
end
