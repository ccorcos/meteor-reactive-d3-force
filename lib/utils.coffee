@insertRandomNode = ->
    Nodes.insert({name:Fake.word()})

@insertRandomLink = ->
    all = Nodes.find().fetch()
    if all.length < 2 then return false
    nodes = _.sample(all, 2) 
    ids = _.pluck(nodes, "_id")
    exists = Links.findOne({source: {$in: ids}, target: {$in: ids}})
    if exists
        return false
    else
        Links.insert({source:ids[0], target:ids[1]})

@insertRandomLinkForNode = (nodeId) ->
    all = Nodes.find({_id: {$ne: nodeId}}).fetch()
    if all.length < 1 then return false
    node = _.sample(all)
    ids = [nodeId, node._id]
    exists = Links.findOne({source: {$in: ids}, target: {$in: ids}})
    if exists
        return false
    else
        Links.insert({source:ids[0], target:ids[1]})