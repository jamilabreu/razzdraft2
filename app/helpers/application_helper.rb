module ApplicationHelper
	def impact(x, t1, t2, t3)
		x.zero? ? "zero" : x >= t1 ? "best" : x >= t2 ? "good" : x >= t3 ? "average" : "poor"
	end

	def impact_inverse(x, t1, t2, t3)
		x.zero? ? "zero" : x <= t1 ? "best" : x <= t2 ? "good" : x <= t3 ? "average" : "poor"
	end
end
