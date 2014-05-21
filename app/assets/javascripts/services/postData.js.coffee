angular.module("Blog").factory("postData", ['$http', ($http) ->
  postData = 
    data:
      posts: [
        {
          title: "Loading...",
          content: ""
        }
      ]
    isLoaded: false

  postData.loadPosts = (deferred) ->
    if postData.isLoaded == false
      $http.get('/posts.json').success( (data) ->
        postData.data.posts = data
        postData.isLoaded = true
        console.log "Successfully received posts."
        if deferred
          deferred.resolve()
      ).error( ->
        console.log "Failed to load posts."
        if deferred
          deferred.reject "Failed to load posts."
      )
    else
      if deferred
        deferred.resolve()

  postData.createPost = (formData) ->
    data = 
      post: 
        title: formData.newPostTitle
        content: formData.newPostContent

    $http.post('/posts.json', data).success( (data) ->
      postData.data.posts.push(data)
      console.log("Successfully created post.")
    ).error( ->
      console.log("Failed to create post.")
    )

    return true

  postData.updatePost = (formData) ->
    console.log "Hey Roger. WElcome back!"
    data =
      post:
        title: formData.editPostTitle
        content: formData.editPostContent

    $http.put("/posts/#{formData.editPostId}.json", data).success( (data) ->
      console.log("Successfully edited post.")
      # postData.data.posts.push(data)
      # find the post we are editing via the edit post id
      post = _.findWhere( postData.data.posts, { id: parseInt(formData.editPostId)})
      post.title = data.title
      post.content = data.content
      #   change the title data
      #   change the content data
    ).error( ->
      console.log("Failde to edit post.")
    )

  postData.deletePost = (postId) ->
    $http.delete("/posts/#{postId}.json").success( (data) ->
      console.log("Successfully deleted post.")
      post = _.findWhere( postData.data.posts, { id: parseInt(postId)})
      postData.data.posts = _.without(postData.data.posts, post)
    ).error(
      console.log("Failde to delete post.")
    )

  postData.findPostById = (postId) ->
    console.log postId
    console.log postData.data.posts
    test = _.findWhere(postData.data.posts, { id: parseInt(postId) })
    console.log(test)
    return test

  console.log "Post data is HEREEEEEEEEEEEEEE"

  return postData
])