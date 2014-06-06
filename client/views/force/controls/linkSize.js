Template.linkSize.events({
    'input input#link-size': function(e, t) {
        Session.set("linkSize", e.target.valueAsNumber);
    }
})

Template.linkSize.rendered = function() {
    // initialize link size
    $("#link-size").attr("value", Session.get("linkSize"));
    // autorun
    Deps.autorun(function() {
        var linkSize = Session.get("linkSize");
        $.rule('.link').append('stroke-width:' + linkSize + 'px;');
    })
}