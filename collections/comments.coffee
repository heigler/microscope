@Comments = new Meteor.Collection('comments')

Meteor.methods(
  comment: (commentAttributes) ->
    user = Meteor.user()
    post = Posts.findOne(commentAttributes.postId)

    if !user
      throw new Meteor.Error(401, 'You need to login to make comments')
    if !commentAttributes.body
      throw new Meteor.Error(422, 'Please write some content')
    if !commentAttributes.postId
      throw new Meteor.error(422, 'You must comment on a post')
    
    comment = _.extend(_.pick(commentAttributes, 'postId', 'body'), {
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
    })

    # update the post with the number of comments
    Posts.update(comment.postId, {$inc: {commentsCount: 1}})

    # create the comment, save id
    comment._id = Comments.insert(comment)
    # create a notification for the post owner
    createCommentNotification(comment)
    return comment._id
)
