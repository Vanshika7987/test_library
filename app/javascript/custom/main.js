$(document).ready(function(){
    $('.approve').on('click',function(){
        var that = this;
        $.ajax({
            url: '/librarians/' + this.parentElement.id + '/approve',
            type: 'GET'
        });
    });
});
$(document).ready(function(){
    $('.ignore').on('click',function(){
        $.ajax({
            url: '/librarians/' + this.parentElement.id + '/ignore',
            type: 'GET'
        });
    });
});