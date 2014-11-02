$(document).ready(function(){
    $.getJSON('json.jsp', function(data) {
        var html = '';
        $.each(data, function(entryIndex, entry) {
            html += '<div>';
            html += '<h3>' + entry.idx + '</h3>';
            html += '<span>' + entry.title + '</span>';
            html += '<p>' + entry.content + '</p>';
            html += '</div>';
        });
        $('#test').html(html);
    });
});