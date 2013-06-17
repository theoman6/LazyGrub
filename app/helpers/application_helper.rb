module ApplicationHelper
		def full_title(title)
			base_title = "Snackage" 
			if title.empty?
				base_title
			else "#{base_title} | #{title}"
			end
		end

		def items_collection(order, rest)
			item_list = {}
    	rest.categories.each do |category|
   		item_list[category[:name]] = category.items
     	end
			"".tap do |i| 
				simple_form_for(order) do |f|
					item_list.each_key do |category| 
						unless item_list[category].empty?
							i << "<h4> #{category} </h4>"
							i << f.association(:items, collection: item_list[category], as: :check_boxes, :label => false)
						end
					end
				end
			end
		end
end
