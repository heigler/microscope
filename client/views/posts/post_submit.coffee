Template.postSubmit.events(
  'submit form': (event) ->
    event.preventDefault()

    post =
      url: $(event.target).find('[name=url]').val()
      title: $(event.target).find('[name=title]').val()
      message: $(event.target).find('[name=message]').val()

    Meteor.call('post', post, (error, id) ->
      if error
        # display the error to the user
        throwError(error.reason)
        if error.error == 302
          Meteor.Router.to('postPage', error.details)
      else
        Meteor.Router.to('postPage', id)
    )
)
