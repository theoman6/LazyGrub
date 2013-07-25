$(document).ready(function(){
	$("#order_cost").change(change_total);

	$("#order_tip").change(change_total);

	$("#order_restaurant_id").change(function() {
		var id = (this).options[(this).selectedIndex].value;
		$.getScript('/restaurants/' + id + '/items/list');
	});

	$(".item_quantities").change(function() {
		update_order_form();
	});

	$('.toolT').tooltip();

	update_order_form();

	$('#order-form').modal({
	        backdrop: true,
	        keyboard: true,
	        show: false
	    }).css({
	       'width': function () { 
	           return (($(window).width() * .9) < 700 ? ($(window).width() * .9) : 700) + 'px';  
	       },

	       'margin-left': function () { 
	           return -($(this).width() / 2); 
	       }
	});

	var table = $('#orders').dataTable({
		'aoColumns': [
			{'bSortable': false},
			null,
			{'bSortable': false},
			null,
			null,
			{'bVisible': false}, 
			{'bSortable': false},
			null,
			{'bVisible': false},
			null,
			null,
			{'bVisible': false}
		],
		bJQueryUI: true
	});

	$("#datatable-search").keyup(function(){
		table.fnFilter($(this).val());
	});

	$('#sort_by, #asc-desc').change(function() {
		table.fnSort([[$('#sort_by').val(), $('#asc-desc').val()]]);
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
	$('.accordion-body').each(function() {
		var total = 0.0;
		$(this).find('input').each(function(){
			total += parseInt($(this).val());
		});
		header = $(this).prev().find('a').first();
		header.text((header.data('atag') + ' (' + total + ')').toString());
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
