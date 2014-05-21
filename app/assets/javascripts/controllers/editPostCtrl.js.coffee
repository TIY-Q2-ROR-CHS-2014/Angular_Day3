@EditPostCtrl = ($scope, $routeParams, postData, $q, $location) ->
  console.log "Hey Preston"

  $scope.data =
    postData: postData.data
    currentPost:
      title: "Loading..."
      content: ""

  $scope.data.postId = $routeParams.postId

  $scope.formData =
    editPostTitle: ""
    editPostContent: ""
    editPostId: $routeParams.postId

  $scope.findPostById = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId)})
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.content = post.content
    $scope.formData.editPostTitle = post.title
    $scope.formData.editPostContent = post.content

  $scope.editPost = ->
    console.log "edit post"
    postData.updatePost($scope.formData)
    $scope.returnHome()


  $scope.returnHome = ->
    $location.url '/'

  @deferred = $q.defer()
  @deferred.promise.then($scope.findPostById)
  postData.loadPosts(@deferred)



