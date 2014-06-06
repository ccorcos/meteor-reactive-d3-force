
bezierOn = ->
    bilinks = force.bilinks
    bilinks.splice(0,bilinks.length)
    links = force.links()

    newLinks = []
    _.each links, (link)->
        bezier = {name:"bezier", _id:link._id}
        link1 = 
            source: link.source
            target: bezier
        link2 = 
            source: bezier
            target: link.target
        
        bilink = [link1.source, bezier, link2.target]
        bilinks.push bilink
        # add the bezier intermediate
        force.nodes().push bezier
        # add the bezier links
        newLinks.push link1
        newLinks.push link2

    links.splice(0,bilinks.links)
    _.each newLinks, (link) -> links.push link

    # strength = Session.get "linkStrength"
    # Session.set "linkStrength", strength*2
    # force.linkStrength(strength*2);

    # data join
    dataJoinNodes()
    dataJoinLabels()
    dataJoinLinks()
    # enter the data
    enterNodes()
    enterLabels()
    enterLinks()
    # update the labels
    updateLabels()
    # remove
    exitRemoveLinks()
    return

bezierOff = ->
    bilinks = force.bilinks

    links = force.links()
    links = links.splice(0,links.length)

    bezierNodes = _.map bilinks, (bilink) -> bilink[1]
    nodes = _.filter(force.nodes(), (node) -> !_.contains bezierNodes, node)
    force.nodes(nodes)
    _.each bilinks, (bilink) ->
        link = 
            source: bilink[0]
            target: bilink[2]
        force.links().push link
    bilinks.splice(0,bilinks)

    # strength = Session.get "linkStrength"
    # Session.set "linkStrength", strength/2
    # force.linkStrength(strength/2);

     # data join
    dataJoinNodes()
    dataJoinLabels()
    dataJoinLinks()
    # enter the data
    enterNodes()
    enterLabels()
    enterLinks()
    # update the labels
    updateLabels()
    # remove
    exitRemoveLinks()
    exitRemoveNodes()
    exitRemoveLabels()
    return


Template.bezier.events
    'click input[value=bezier]': (e, t) ->
        bezier = e.target.checked
        force.stop()
        Session.set("bezier", bezier)
        if bezier
            bezierOn()
        else
            bezierOff()
        force.start()

# keep the UI up to date.
Template.bezier.rendered = ->
    Deps.autorun ->
        bezier = Session.get("bezier")
        if bezier
            $('input[value=bezier]').attr("checked", "checked")
        else 
            $('input[value=bezier]').attr("checked", false)
