Template.postItem.helpers(
  domain: () ->
    a = document.createElement('a')
    # here the "this" hits at current iteration, an postsList object (each)
    a.href = this.url
    return a.hostname
)
