# Meteor.startup ->
#     if Nodes.find().count() is 0
#         for i in [1..20]
#             insertRandomNode()
#     if Links.find().count() is 0
#         for i in [1..50]
#             insertRandomLink()

Meteor.startup ->
    if Nodes.find().count() is 0
        console.log("loading fb friends")
        people = JSON.parse(Assets.getText("fb-friends.json"));
        _.each people, (person)->
            console.log(person.name)
            person = _.omit person, 'friends'
            Nodes.insert(person)
        _.each people, (person)->
            friends = person.friends
            node = Nodes.findOne({"id":person.id})
            _.each friends, (friend)->
                console.log(person.name + " -> " + friend.name)
                node2 = Nodes.findOne({"id":friend.id})
                Links.insert({source:node._id, target:node2._id})
        console.log("done loading db fb-friends")
        console.log(Nodes.find().count(), "friends")
        console.log(Links.find().count(), "connections")