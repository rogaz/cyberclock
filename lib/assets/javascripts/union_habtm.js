/**
 * Created by Néstor Raúl Ogaz Romero on 04/02/14.
 * email raul260290@gmail.com
 */



function union_habtm(e, first_class, first_class_id, second_class, second_class_id, add){
    $.post('/union_habtm/' + first_class + '/' + first_class_id + '/' + second_class + '/' + second_class_id + '/' + add + '.js');
    if (add == 'false'){
        $('#' + second_class + 's-unassigned').show();
    }
}

function manage_unassigned_elements(type){
    var element = $('#' + type + '-unassigned');
    if (element.is(':visible'))
        element.hide('fast');
    else
        element.show('fast');
}

$('.union-habtm').on('mouseenter', '.item', function(){
    var element = $(this);
    element.find('.add-item').show('fast');
});

$('.union-habtm').on('mouseleave', '.item', function(){
    var element = $(this);
    element.find('.add-item').hide('fast');
    //setTimeout(function(){ element.find('.add-item').hide('fast'); }, 500)
});
