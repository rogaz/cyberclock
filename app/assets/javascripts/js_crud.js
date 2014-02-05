/**
 * Created by Néstor Raúl Ogaz Romero on 21/01/14.
 * email raul260290@gmail.com
 */


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
        var title = element.find('form').find('input[type=submit]').attr('value');
        element.parent().find('.modal-title').text(title);
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
        var title = element.find('form').find('input[type=submit]').attr('value');
        element.parent().find('.modal-title').text(title);
    });
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

function show_loading_icon(container){
    $("#"+container).empty().append("<div id='loading-icon'><i class='fa fa-spinner fa-spin'></i> Cargando...</div>");
}

function hide_loading_icon(){
    var time = 800;
    $("#loading-icon").hide(time);
}
