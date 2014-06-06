Template.hover.events({
    'click input[value=hover]': function(e, t) {
        Session.set("hover", e.target.checked);
    }
});

// keep the UI up to date.
Template.hover.rendered = function() {
    Deps.autorun(function() {
        var hover = Session.get("hover");
        if (hover) {
            $('input[value=hover]').attr("checked", "checked");
        } else {
            $('input[value=hover]').attr("checked", false);
        }
    });
};