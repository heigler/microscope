if Posts.find().count() == 0
  now = new Date().getTime()

  # create two users
  tomId = Meteor.users.insert(
    profile:
      name: 'Tom Coleman'
  )
  tom = Meteor.users.findOne(tomId)
  sachaId = Meteor.users.insert(
    profile:
      name: 'Sacha Greif'
  )
  sacha = Meteor.users.findOne(sachaId)

  telescopeId = Posts.insert(
    title: 'Introducing Telescope'
    userId: sacha._id
    author: sacha.profile.name
    url: 'http://sachagreif.com/introducing-telescope/'
    submitted: now - 7 * 3600 * 1000
    commentsCount: 2
  )

  Comments.insert(
    postId: telescopeId
    userId: tom._id
    author: tom.profile.name
    submitted: now - 5 * 3600 * 1000
    body: 'Oi seu bosta'
  )

  Comments.insert(
    postId: telescopeId
    userId: sacha._id
    author: sacha.profile.name
    submitted: now - 3 * 3600 * 1000
    body: 'vai se fuder sua bicha, bbk! Você é gayzão rapaz'
  )

  Posts.insert(
    title: 'The Meteor Livro'
    userId: tom._id
    author: tom.profile.name
    url: 'http://themeteorbook.com'
    submitted: now - 12 * 3600 * 1000
    commentsCount: 0
  )
