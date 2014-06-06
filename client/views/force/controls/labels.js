Template.labelControl.rendered = function() {
    $('input[name="labelControl"][value="' + Session.get("labelControl") + '"]').prop('checked', true);
    Deps.autorun(function() {
        labelControl = Session.get("labelControl");
        // console.log(labelControl)
        d3.selectAll("text.label")
            .classed("on", labelControl == "on")
            .classed("off", labelControl == "off")
            .classed("select", labelControl == "select");
    })

}

Template.labelControl.events({
    'change input[name="labelControl"]': function(event, template) {
        // console.log(event.target.value)
        Session.set("labelControl", event.target.value)
    }
});