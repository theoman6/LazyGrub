$(document).ready(function(){
	var categories = ["boobs"];
	$("#order_cost").change(change_total);
	$("#order_tip").change(change_total);
	$("#order_restaurant_id").change(function() {
		var id = (this).options[(this).selectedIndex].value;
		$.getScript('/restaurants/' + id + '/items/list');
	});
	$(".item_quantities").change(function() {
		update_order_form();
	});
	$(".accordion").accordion({
		heightStyle: 'content',
		collapsible: true,
		autoHeight: false,
		active :false
	});
	$('.toolT').tooltip();
	update_order_form();

	$('#orders').dataTable({
		'aoColumns': [
			{ 'bSortable': false},
			null,
			{ 'bSortable': false},
			null,
			null, 
			{ 'bSortable': false},
			null,
			null,
			null
		],
		bJQueryUI: true
	});
});

function change_total(){
   var total = Number($('#order_cost').val()) + Number($('#order_tip').val());
   $('#order_total').val(total);
};

function update_order_form(){ 
	get_prices();
	get_headers();
};

function get_headers(){ 
	$('.tab-accordion').each(function() {
		var total = 0.0;
		$(this).find('input').each(function(){
			total += parseInt($(this).val());
		});
		h = $(this).prev('h3');
		h.text((h.attr('title') + ' (' + total + ')').toString());
	});
};

function get_prices(){
	var total = 0.0;
	$('.item_quantities').each(function() { 
		total += ($(this).val() * $(this).data('cost'));
	});
	$('#order_cost').val(total);
	change_total();
};
