module ApplicationHelper
		def full_title(title)
			base_title = "Snackage" 
			if title.empty?
				base_title
			else "#{base_title} | #{title}"
			end
		end

		def items_collection(order, items_list)
			"".tap do |i| 
				simple_form_for(order) do |f|
					i << f.association(:items, collection: items_list, as: :check_boxes, :wrapper_html => {:id => 'items-list'})
				end
			end
		end
end
