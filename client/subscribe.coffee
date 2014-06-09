Session.setDefault "nodesReady", false
Session.setDefault "linksReady", false
Session.setDefault "ready", false

Meteor.subscribe "nodes", -> 
    console.log "nodes subscription ready"
    Session.set "nodesReady", true
    if Session.get "linksReady" then Session.set "ready", true
Meteor.subscribe "links", -> 
    console.log "links subscription ready"
    Session.set "linksReady", true
    if Session.get "nodesReady" then Session.set "ready", true


# Deps.autorun ->
#     ready = Session.get("nodesReady") and Session.get("linksReady")
#     if ready
#         console.log "subscriptions ready"
#         Session.set "ready", ready
#         computation.stop();