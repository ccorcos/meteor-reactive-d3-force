Template.navbar.events({
    'click .nav.navbar-nav li a': function(event) {
        a = $(event.target);
        li = a.parent();
        li.parent('ul').children('li').not(li).removeClass('active');
        li.addClass('active');
    },
    'click a.navbar-brand': function(event) {
        $('ul.nav.navbar-nav').children('li').removeClass('active')
    }
});

Template.navbar.rendered = function() {
    $(document).on('click', '.navbar-collapse.in', function(e) {
        if ($(e.target).is('a')) {
            $(this).collapse('hide');
        }
    });
}