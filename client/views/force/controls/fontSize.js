Template.fontSize.events({
    'input input#font-size': function(e, t) {
        Session.set("fontSize", e.target.valueAsNumber);
    }
});

Template.fontSize.rendered = function() {
    // initialize the font size
    $("#font-size").attr("value", Session.get("fontSize"));
    // autorun font size
    Deps.autorun(function() {
        var fontSize = Session.get("fontSize");
        // change the font size of the title elements
        $.rule('.title').append('font-size:' + fontSize + 'px;');
    })
}