$(document).ready(function(){
	$("#order_cost").change(change_total);

	$(".order-row").click(function() {
		var id = $(this).attr('id').split('_')[2];
		$("#order_" + id.toString() + "_details").modal('show');
	});

	$("#order_tip").change(change_total);

	$("#order_restaurant_id").change(function() {
		var id = (this).options[(this).selectedIndex].value;
		$.getScript('/restaurants/' + id + '/items/list');
	});

	$(".item_quantities").change(function() {
		update_order_form();
	});

	$(".filter-nav").click(function() { 
		$(this).button("toggle");
		button_filter();
		$(this).button("toggle");
	});

	$('.toolT').tooltip();

	var modal_open = document.URL.slice(-11) == '#order-form'

	$('#order-form').modal({
	        backdrop: true,
	        keyboard: true,
	        show: modal_open
	    }).css({
	       'width': function () { 
	           return (($(window).width() * .9) < 700 ? ($(window).width() * .9) : 700) + 'px';  
	       },

	       'margin-left': function () { 
	           return -($(this).width() / 2); 
	       }
	});

	table = $('#orders').dataTable({
  	"oLanguage": {
	  		"sZeroRecords": "<h2>Sorry, there are no such orders. <a href = '" + document.URL.slice(0, -7) + "#order-form'>Order Food!</a></h2>"
	  	},
		'aoColumns': [
			{'bVisible': false},
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
			{'bVisible': false},
			{'bVisible': false}

		],
		bJQueryUI: true,
	});

	$("#datatable-search").keyup(function(){
		table.fnFilter($(this).val());
	});

	$('#sort_by, #asc-desc').change(function() {
		table.fnSort([[$('#sort_by').val(), $('#asc-desc').val()]]);
	});
	
	update_order_form();
	button_filter();


});



function update_descriptions(){ 
	$('.item_quantities').each(function() {
		var quantity = $(this).val(); 
		var id = $(this).attr('id').split('_')[1];
		var span = $('#item_' + id.toString() + '_descriptions')
		var count = span.find('.order_item_description').length;
		if (count < quantity) {
			for (var i = 0; i < quantity - count; i++) {
				var text = "<div class='control-group text optional hidden' id = 'item_" + (id).toString() + "_description_" + (count + i).toString() + "'>";
				text += "<div class='controls'>";
				text += "<textarea name = 'order[item_descriptions][" + id.toString() + "][" + (count + i).toString() + "]' placeholder = 'Special Instructions' class='text optional order_item_description' id='item_" + (id).toString() + "_text_" + (count + i).toString() + "' rows='2'></textarea>";
				text += "</div></div>";
				span.append(text)
				$("#item_" + (id).toString() + "_description_" + (count + i).toString()).fadeIn();
			}
		}
		else if (count > quantity) { 
			for (var i = 0; i < count - quantity; i++) {
				var last = span.children("div:last")
				last.fadeOut(200, function(){
					$(this).remove();
				});
			}
		}
	});
}; 


function change_total(){
   var total = Number($('#order_cost').val()) + Number($('#order_tip').val());
   $('#order_total').val(total);
};

function update_order_form(){ 
	get_prices();
	get_headers();
	update_descriptions();
};

function button_filter(){
	var query = ''
	$(".btn..filter-nav.active").each(function() {
		query = query + ' ' + $(this).val();
	});
	table.fnFilter(query, 12);
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
