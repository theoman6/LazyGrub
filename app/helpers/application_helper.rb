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
					i << "<div class = 'accordion'>"
					item_list.each_key do |category| 
						unless item_list[category].empty?
							i << " <h3 title = #{category}> #{category} </h3><div class = 'tab-accordion'>"
              item_list[category].each do |item|
                i << "<div class='control-group integer order_items_quantities> <div class = 'controls'> <div class = 'row-fluid'> "
                i << "<div class ='span6'>" + item.name.to_s + ' $' + item.cost.to_s + "</div>"
                i << '<div class ="span6"> <input min = 0 type = "number" id = "item_' + item.id.to_s + '_quantity"' + 'class = "numeric integer item_quantities" name = "order[item_ids][' + item.id.to_s + ']" value = "0" data-cost = "' + item.cost.to_s + '">' 
								i << "</input></div></div></div>"
							end
						i << '</div>'
						end
					end
					i << '</div>'
				end
			end
		end
end
