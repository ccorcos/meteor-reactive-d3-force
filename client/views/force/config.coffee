# Session.setDefault("bezier", true);

# force layout params
Session.setDefault "linkDistance", 1 
Session.setDefault "linkStrength", 0.2
Session.setDefault "friction", 0.8
Session.setDefault "charge", -256 
Session.setDefault "chargeDistance", Math.exp(2, 20)
Session.setDefault "theta", 0.6
Session.setDefault "gravity", 0.1

# display params
Session.setDefault "stick", true
Session.setDefault "hover", true
Session.setDefault "fontSize", 10
Session.setDefault "nodeRadius", 7
Session.setDefault "linkSize", 1

Session.setDefault "labelControl", "on" # "off", "select"

@printConfigs = ->
    console.log "linkDistance", Session.get "linkDistance"
    console.log "linkStrength", Session.get "linkStrength"
    console.log "friction", Session.get "friction"
    console.log "charge", Session.get "charge"
    console.log "chargeDistance", Session.get "chargeDistance"
    console.log "theta", Session.get "theta"
    console.log "gravity", Session.get "gravity"
    console.log "stick", Session.get "stick"
    console.log "hover", Session.get "hover"
    console.log "fontSize", Session.get "fontSize"
    console.log "nodeRadius", Session.get "nodeRadius"
    console.log "linkSize", Session.get "linkSize"
    console.log "labelControl", Session.get "labelControl"
