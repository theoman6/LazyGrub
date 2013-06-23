$(document).ready(function(){
	var categories = ["boobs"];
	$("#order_cost").change(change_total);
	$("#order_tip").change(change_total);
	$("#order_restaurant_id").change(function() {
		var id = (this).options[(this).selectedIndex].value;
		$.getScript('/restaurants/' + id + '/items/list');
	});
	$(".item_quantities").change(function() {
		get_prices();
	});
	get_prices();
});

function change_total(){
   var total = Number($('#order_cost').val()) + Number($('#order_tip').val());
   $('#order_total').val(total);
};

function get_prices(){
	var total = 0.0;
	$('.item_quantities').each(function() { 
		console.log('q = ' + $(this).val());
		console.log('cost' + $(this).data('cost'));
		total += ($(this).val() * $(this).data('cost'));
	});
	console.log('total' + total)
	$('#order_cost').val(total);
	change_total();
};
