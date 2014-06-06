Template.stickyNodes.events({
    'click input[value=stick]': function(e, t) {
        Session.set("stick", e.target.checked);
    }
});

Template.stickyNodes.rendered = function() {
    Deps.autorun(function() {
        var stick = Session.get("stick");
        if (stick) {
            $('input[value=stick]').attr("checked", "checked");
        } else {
            $('input[value=stick]').attr("checked", false);
            unstick();
        }
    });
};

// unstick all nodes
unstick = function() {
    d3.selectAll("circle.node").each(function(d) {
        var node = d3.select(this); // set bezier class
        d.fixed = false; // unfix on double click
        node.classed("fixed", false);
        force.resume();
    })
}