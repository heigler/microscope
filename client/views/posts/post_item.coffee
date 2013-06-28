Template.postItem.helpers(
  ownPost: () ->
    this.userId == Meteor.userId()

  domain: () ->
    a = document.createElement('a')
    # here the "this" hits at current iteration, an postsList object (each)
    a.href = this.url
    a.hostname
)
