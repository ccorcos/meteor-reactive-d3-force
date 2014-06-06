UI.registerHelper('equals', (a, b...) -> _.contains(b, a))

UI.registerHelper('captialize', (a) -> _.capitalize(a))

UI.registerHelper "sessionVar", (string) -> Session.get string

UI.registerHelper "keyValues", (context, options) ->
    result = []
    _.each context, (value, key, list) ->
        result.push
            key: key
            value: value
    return result

UI.registerHelper "dateFromUTC", (utc) -> moment(utc).format('M-D-YYYY')

UI.registerHelper "first", (array) -> array[0]

UI.registerHelper "rest", (array) -> _.rest(array)

UI.registerHelper "keyVal", (doc, key) -> doc[key]


