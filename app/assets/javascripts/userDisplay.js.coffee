clio = angular.module('clio')

clio.factory('currentUser', ['$http', ($http)->
  return {
    get: ->
      $http.get('/users/get_current_user.json')
      .then((response)->
        return response.data)
      .catch((data)->
        console.log "Error in currentUserFactory"
        return false)
    }])

clio.directive('statusStream', ->
  restrict: 'E'
  replace: true
  scope: 
    data: '='
  controller: ['$scope', '$rootScope', ($scope, $rootScope)->
    vm = $scope
    vm.source = new EventSource(vm.data.url)
    vm.source.addEventListener 'users.in', (e)->
      vm.userId = $.parseJSON(e.data).userId
      $rootScope.$emit('users', {userId: vm.userId, event: 'in'})
    vm.source.addEventListener 'users.out', (e)->
      vm.userId = $.parseJSON(e.data).userId
      $rootScope.$emit('users', {userId: vm.userId, event: 'out'})
    ])

clio.directive('usersDisplay', ['Users','currentUser', (Users, currentUser)->
  restrict: 'E'
  replace: true
  template: """
    <div>
      <div class="user-status is-{{data.currentUser.status}}" data-id={{data.currentUser.id}}> 
        <a class="name" href="/users/{{data.currentUser.id}}">{{data.currentUser.full_name}}</a>
        <span class="status">{{data.currentUser.status}}</span>
          <a class="update-link" href="/users/{{data.currentUser.id}}/edit">Edit</a>   
      </div>
      <div id="users-container">
        <div ng-repeat="user in data.users track by $index" class="user-status is-{{data.users[$index].status}}" data-id={{data.users[$index].id}}> 
          <a class="name" href="/users/{{data.users[$index].id}}">{{data.users[$index].full_name}}</a>
          <span class="status">{{data.users[$index].status}}</span>
        </div>
      </div>
      <status-stream data="{url: 'users/events'}">
    </div>
    """
  controller: ['$scope', '$rootScope', ($scope, $rootScope)->
    vm = $scope
    vm.data = {
      currentUser: {}
      users: {}
    }
    $rootScope.$on('users', (event, data)->
      user = _.find(vm.data.users, (user)->
        user.id == data.userId)
      index = vm.data.users.indexOf(user)
      $scope.$apply( ->
        vm.data.users[index].status = data.event
        )
      )
    currentUser.get()
    .then((data)->
      console.log data
      vm.data.currentUser = data.user)
    .catch((data)->
      console.log 'Error in userDisplay'
      console.log data)

    Users.get()
    .then( (data) ->
      console.log data
      vm.data.users = data.users)
    .catch((data)->
      console.log 'Error in userDisplay directive')
    ]])