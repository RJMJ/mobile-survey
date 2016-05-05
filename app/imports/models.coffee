exports.Survey = Parse.Object.extend 'Survey',
  getForms: (returnMeteorCollection, collection) ->
    query = @relation('forms').query()
    query.find().then (forms) ->
      if returnMeteorCollection and forms
        formCollection = collection or new Meteor.Collection null
        _.each forms, (form) ->
          props = _.extend {}, form.attributes
          props.parseId = form.id
          formCollection.insert props
        formCollection
      else
        forms

exports.Form = Parse.Object.extend 'Form',
  getQuestions: (returnMeteorCollection, collection) ->
    query = @relation('questions').query()
    query.find().then (questions) ->
      if returnMeteorCollection and questions
        questionCollection = collection or new Meteor.Collection(null)
        _.each questions, (question) ->
          props = _.extend {}, question.attributes
          props.parseId = question.id
          questionCollection.insert props
        questionCollection
      else
        questions

  getLastQuestionOrder: ->
    query = @relation('questions').query()
    query.descending 'order'
    query.select 'order'
    query.first().then (lastQuestion) ->
      lastQuestion?.get('order')

exports.Question = Parse.Object.extend 'Question'
