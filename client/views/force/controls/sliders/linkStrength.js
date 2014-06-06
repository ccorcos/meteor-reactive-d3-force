initLinkStrengthSlider = function() {
    d3.select("#link-strength-slider")
        .call(d3.slider()
            .min(0)
            .max(1)
            .step(0.05)
            .value(Session.get("linkStrength"))
            .on("slide", function(evt, value) {
                Session.set("linkStrength", value);
                // force.stop();
                force = force.linkStrength(value);
                force.start();
            }));
}

Template.linkStrength.rendered = function() {
    initLinkStrengthSlider();
}