$(document).ready(function(){
	var categories = ["boobs"];
	$("#order_cost").change(change_total);
	$("#order_tip").change(change_total);
	$("#order_restaurant_id").change(function() {
		var id = (this).options[(this).selectedIndex].value;
		$.getScript('/restaurants/' + id + '/items/list');
	});
	$(".check_boxes").change(function() {
		get_prices();
	});
});

function change_total(){
   var total = Number($('#order_cost').val()) + Number($('#order_tip').val());
   $('#order_total').val(total);
};

function get_prices(){
	var selected = new Array();
	$('input:checked').each(function() { 
		selected.push($(this).val());

	});
	var url = 'static_pages/prices?';
	for (var i = 0; i < selected.length; i++) { 
		if (url != 'static_pages/prices?') { 
			url +=  '&';
		}
		url += 'items[]=' + selected[i];
	}
	$.getScript(url);
};
