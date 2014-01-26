/**
 * Created by Néstor Raúl Ogaz Romero on 21/01/14.
 * email raul260290@gmail.com
 */

var own_object = 0;
var tableize = 1;
var singularize = 2;
var owner_id = 3;

$(document).ready(function(){
    /*
    $(".container_nested_forms > h4 > i").click(function(){
        var down = $(this).parent().find('.icon-chevron-sign-down');
        var up = $(this).parent().find('.icon-chevron-sign-up');
        var items = $(this).parent().parent().find('.items');
        if (items.is(':visible')){
            items.fadeOut(200);
            items.parent().css('background-color', '#EEEEEE');
            up.hide();
            down.show();
        } else{
            items.fadeIn(500);
            items.parent().css('background-color', '#F9F9F9');
            up.show();
            down.hide();
        }
    });

    var ep = $("#ep");

    ep.on('click','.ep_checkbox',function() {
        var checkbox = $(this);

        if(checkbox.is(':checked')) {
            checkbox.parent().parent().find('.ep_form_end_date').hide();
        } else {
            checkbox.parent().parent().find('.ep_form_end_date').show();
        }
    });

    ep.on('click','.sei_radio_button',function() {
        var radiobutton = $(this);
        radiobutton.parent().parent().find('.sei_field_content').show();
        radiobutton.parent().parent().find('.organization_field_content').hide();
    });

    ep.on('click','.organization_radio_button',function() {
        var radiobutton = $(this);
        radiobutton.parent().parent().find('.sei_field_content').hide();
        radiobutton.parent().parent().find('.organization_field_content').show();
    });
    */

    var containers = ['#container_phones', '#container_user_contacts', '#container_evaluator_professional_experiences', '#container_evaluator_studies'];

    dynamic_destroy_link(containers);

    // No permiten ingresar espacios en blanco en los inputs.
    $("input#evaluator_user_attributes_login").on({
        keydown: function(e) {
            if (e.which === 32)
                return false;
        },
        change: function() {
            this.value = this.value.replace(/\s/g, "");
        }
    });

    $("input#evaluator_user_attributes_password").on({
        keydown: function(e) {
            if (e.which === 32)
                return false;
        },
        change: function() {
            this.value = this.value.replace(/\s/g, "");
        }
    });

    $("input#evaluator_user_attributes_password_confirmation").on({
        keydown: function(e) {
            if (e.which === 32)
                return false;
        },
        change: function() {
            this.value = this.value.replace(/\s/g, "");
        }
    });
});

function dynamic_destroy_link(containers){
    $.each(containers, function(){
        var container = $(''+this+'');
        var n = container.find('.item').length;
        if (n <= 1){
            container.find('.item').find('.icon-remove').parent().hide();
        } else{
            $.each(container.find('.item'), function(){
                $(this).find('.icon-remove').parent().show();
            });
        }
    });
}

function validate_evaluator_active(id){
    $.get('/evaluators/'+id+'/validate_evaluator_active.json', function(json){
        $("#evaluator_status_name").empty().append(json[1].name);
        if (json[0].length > 0){
            $("#errors_container").empty();
            var html = "";
            html += "<div id='error_explanation'><h2>"+json[1].name+"</h2><ul>";
            $.each(json[0], function(i, item){
                html += '<li>'+item+'</li>';
            });
            html += "</ul></div>";
            $("#errors_container").append(html);
        } else {
            $("#error_explanation").hide();
        }
    });
}

function destroy_record(class_name_tableize, object_id){
    var element = $("#object-js-" + class_name_tableize + "-" + object_id);

    if (confirm('¿Realmente desea eliminar?')){
        $.ajax({
            url: '/'+ class_name_tableize +'/'+ object_id,
            type: 'post',
            dataType: "json",
            data: {"_method":"delete"}
        }).done(function(){
            var time = 500;
            element.css('background-color', "#CCC").fadeOut(time);
            setTimeout(function(){ element.remove() }, time*2);
        });
    }
}

function new_record(class_record, owner_class, owner_id){
    var container_form_name = "container-form"
    var element = $("#" + container_form_name);
    show_loading_icon(container_form_name);
    $.get('/' + class_record + '/new.widget?' + owner_class + '_id=' + owner_id, function(html){
        hide_loading_icon();
        element.empty().append(html);
        element.find('form').append('<input type="hidden" name="parent_class" value="' + owner_class + '">');
    });
}

function edit_record(class_name_tableize, object_id, owner_class){
    var container_form_name = "container-form"
    var element = $("#" + container_form_name);
    show_loading_icon(container_form_name);
    $.get('/'+class_name_tableize+'/' + object_id + '/edit.widget', function(html){
        hide_loading_icon();
        element.empty().append(html);
        element.find('form').append('<input type="hidden" name="parent_class" value="' + owner_class + '">');
    });
}

function create_record(json){
    validate_evaluator_active(json[owner_id]);
    $.fancybox.close();
    var content = eval(json[singularize])(json);
    var icon_edit = "<a><i class='icon-edit fancybox' href='#container_forms' onclick='edit_record("+json[own_object].id+", \""+ json[tableize] +"\", \""+ json[singularize] +"\");'></i></a>";
    var icon_destroy = "<a><i class='icon-remove' onclick='destroy_record(event," + json[own_object].id +", \""+ json[tableize] +"\", \""+ json[singularize] +"\", \""+json[owner_id]+"\");'></i></a>";
    var html = "<div class='item' id='" + json[singularize] + "_" + json[own_object].id + "'>" + "<div class='options'>"
        + icon_edit + icon_destroy + "</div>" + content + "</div>";
    $("#container_"+json[tableize]).find(".items").append(html).find('.item:last-child').hide().fadeIn(1000);
    $("#container_forms").empty();
    var containers = ["#container_"+json[tableize]];
    dynamic_destroy_link(containers);
}

function update_record(json){
    validate_evaluator_active(json[owner_id]);
    $.fancybox.close();
    var container = $("#container_"+json[tableize]).find(".items").find('#'+json[singularize]+'_'+json[own_object].id);
    container.empty();
    $.fancybox.close();
    var content = eval(json[singularize])(json);
    var icon_edit = "<a><i class='icon-edit fancybox' href='#container_forms' onclick='edit_record("+json[own_object].id+", \""+ json[tableize] +"\", \""+ json[singularize] +"\");'></i></a>";
    var icon_destroy = "<a><i class='icon-remove' onclick='destroy_record(event," + json[own_object].id +", \""+ json[tableize] +"\", \""+ json[singularize] +"\", \""+json[owner_id]+"\");'></i></a>";
    var html = "<div class='options'>" + icon_edit + icon_destroy + "</div>" + content;
    container.append(html).hide().fadeIn(1000);
    $("#container_forms").empty();
    var containers = ["#container_"+json[tableize]];
    dynamic_destroy_link(containers);
}

function show_record_errors(json){
    var container_form = $("#container-form");
    var html = '<div id="error_explanation"><ul>';
    jQuery.each(json, function(){
        html += '<li>' + this + '</li>';
    });
    html += '</ul></div>';
    container_form.find("#error_explanation").remove();
    container_form.prepend(html);
    container_form.find("#error_explanation").hide().fadeIn(500);
}

function evaluator_study(json){
    content = "<p>"+
        "<b>"+json[4].description +"</b><br/>"+
        "Institución: "+ json[own_object].institution +"<br/>"+
        "Carrera: "+ json[own_object].career +"<br/>"+
        "Fecha de titulación: "+ json[own_object].titulation_date +
        "</p>";
    return content;
}

function evaluator_professional_experience(json){
    var organization_sei;
    var end_date = json[own_object].end_date;
    if (end_date == null){
        end_date = 'Actualidad';
    }
    if (json[own_object].sei == false)
        organization_sei = json[own_object].organization;
    else
        organization_sei = json[4].name;

    content = "<p>" +
        "<b>"+ organization_sei +"</b><br/>"+
        "Puesto: "+ json[own_object].job + "<br/>"+
        "["+ json[own_object].start_date + " - "+ end_date + "]"+
        "</p>";
    return content;
}

function evaluator_language(json){
    content = json[own_object].language +" ["+json[own_object].domain_percentage+"%]";
    return content;
}

function evaluator_item(json){
    content = "<p><b>["+json[4].description +"] "+ json[own_object].title +"</b>"+"</p>"+
        "<p>" + json[own_object].description + "</p>"+
        "<a href='#container_images' class='fancy_images' onclick='get_image_item("+ json[own_object].id +")'>Visualizar evidencia...</a>";
    return content;
}

function phone(json){
    content = "<p>"+
        "<b>Número " + json[4].description +"</b><br/>"+
        json[own_object].phone_number +"<br/>"+
        "</p>";
    return content;
}

function user_contact(json){
    content = "<p>"+
        "<b>" + json[4].description + " </b><br/>"+
        json[own_object].description + "<br/>"+
        "</p>";
    return content;
}

function show_loading_icon(container){
    $("#"+container).empty().append("<div id='loading-icon'><i class='fa fa-spinner fa-spin'></i> Cargando...</div>");
}

function hide_loading_icon(){
    var time = 800;
    $("#loading-icon").hide(time);
}

function get_image_item(id){
    show_loading_icon('container_images');
    $.get('/evaluator_items/'+id+'.json', function(json){
        hide_loading_icon();
        var html = '<img src="'+json[1]+'" />';
        $("#container_images").append(html);
    })
}
