Template.errors.helpers(
  errors: () ->
    Errors.find()
)

# the error was rendereized, so we use defer (after all or 1 ms+)
Template.error.rendered = () ->
  error = this.data
  Meteor.defer(
    () ->
      Errors.update(error._id, {$set: {seen: true}})
  )
