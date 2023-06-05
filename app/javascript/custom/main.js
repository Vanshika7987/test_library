$(document).ready(function () {
    $('.approve').on('click', function () {
        var that = this;
        $.ajax({
            url: '/librarians/' + this.parentElement.id + '/approve',
            type: 'GET'
        });
    });
});
$(document).ready(function () {
    $('.ignore').on('click', function () {
        $.ajax({
            url: '/librarians/' + this.parentElement.id + '/ignore',
            type: 'GET'
        });
    });
});
var country;
$(document).ready(function () {
    $('#user_country').on('change', function () {
        country = this.value
        $('#user_state').empty();
        $.ajax({
            url: '/users/state?country=' + this.value,
            type: 'GET'
        }).done(function (response) {
            $.each(response.states, function (key, value) {
                $('#user_state').append('<option value="' + key + '">' + value + '</option>')
            });
        });
    });
});

$(document).ready(function () {
    $('#user_state').on('change', function () {

        $('#user_city').empty();
        $.ajax({
            url: '/users/city?state=' + this.value + '&country=' + country,
            type: 'GET'
        }).done(function (response) {
            $.each(response.cities, function (key, value) {
                $('#user_city').append('<option value="' + key + '">' + value + '</option>')
            });
        });
    });
});

