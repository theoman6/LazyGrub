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
				i << "<div class = 'accordion' id = 'restaurant-accordion'>"
				item_list.each_key do |category| 
					unless item_list[category].empty?
						i << "<div class = 'accordion-group'>"
						i << "<div class = 'accordion-heading'>"
						i << "<a data-atag = #{category} class = 'accordion-toggle' data-toggle = 'collapse' data-parent = '#restaurant-accordion' href = '##{category}'>#{category}</a>"
						i << "</div>"
						i << "<div class = 'accordion-body collapse' id = '#{category}'>"
						i << "<div class = 'accordion-inner'>"
            item_list[category].each do |item|
              i << "<div class = 'row-fluid'> "
              i << "<div class ='span6'>" + item.name.to_s + ' $' + item.cost.to_s + "</div>"
              i << '<div class ="span6">'
              i << '<input min = 0 type = "number" id = "item_' + item.id.to_s + '_quantity"' + 'class = "numeric integer item_quantities" name = "order[item_ids][' + item.id.to_s + ']" value = "0" data-cost = "' + item.cost.to_s + '"></input>'
							i << "</div>"
							i << "</div>"
						end
						i << '</div>'
						i << '</div>'
						i << '</div>' 
					end
				end
				i << '</div>'
			end
		end
	end
end
