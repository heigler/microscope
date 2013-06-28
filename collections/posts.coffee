@Posts = new Meteor.Collection('posts')
Posts.allow(
  update: ownsDocument
  remove: ownsDocument
)
Posts.deny(
  update: (userId, post, fieldNames) ->
    _.without(fieldNames, 'url', 'title').length > 0
)

Meteor.methods(
  post: (postAttributes) ->
    user = Meteor.user()
    postWithSameLink = Posts.findOne({url: postAttributes.url})

    # ensure the user is logged in
    if !user
      throw new Meteor.Error(401, 'You need to login to post new stories')

    # ensure the post has a title
    if !postAttributes.title
      throw new Meteor.Error(422, 'Please fill in a headline')

    # check that there are no previus posts with the same link
    if postAttributes.url and postWithSameLink
      throw new Meteor.Error(302,
        'this link has already been posted',
        postWithSameLink._id
      )

    # pick up the whitelisted keys
    post = _.extend(_.pick(postAttributes, 'url', 'title', 'message'),
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
      commentsCount: 0
    )

    postId = Posts.insert(post)

    postId
)
