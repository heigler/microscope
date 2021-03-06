Template.postEdit.helpers(
  'post': () ->
    Posts.findOne(Session.get('currentPostId'))
)

Template.postEdit.events(
  'submit form': (e) ->
    e.preventDefault()

    currentPostId = Session.get('currentPostId')

    postProperties =
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()

    Posts.update(currentPostId, {$set: postProperties}, (error) ->
      if error
        alert(error.reason)
      else
        Meteor.Router.to('postPage', currentPostId)
    )

  'click .delete': (e) ->
    e.preventDefault()

    if confirm('Delete this post?')
      currentPostId = Session.get('currentPostId')
      Posts.remove(currentPostId)
      Meteor.Router.to('postsList')
)
