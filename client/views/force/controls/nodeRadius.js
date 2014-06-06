Template.nodeRadius.events({
    'input input#node-radius': function(e, t) {
        Session.set("nodeRadius", e.target.valueAsNumber);
    }
});

Template.nodeRadius.rendered = function() {
    $("#node-radius").attr("value", Session.get("nodeRadius"));
    Deps.autorun(function() {
        var nodeRadius = Session.get("nodeRadius");
        d3.selectAll("circle.node").attr("r", nodeRadius);
    })
}