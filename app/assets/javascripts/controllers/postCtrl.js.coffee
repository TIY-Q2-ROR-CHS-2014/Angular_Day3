@PostCtrl = ($scope, $location, $routeParams, postData, $q) ->
  $scope.data = 
    postData: postData.data
    currentPost:
      title: "Loading..."
      content: ""

  $scope.data.postId = $routeParams.postId
  $scope.title = "My Blog"

  $scope.returnHome = ->
    console.log "Hey Kevin"
    $location.url("/")

  $scope.findPostById = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.content = post.content

  $scope.editPost = ->
    $location.url("/posts/#{$scope.data.postId}/edit")

  $scope.deletePost = ->
    postData.deletePost($scope.data.postId)
    $location.url("/")


  @deferred = $q.defer()
  @deferred.promise.then($scope.findPostById)
  postData.loadPosts(@deferred)






