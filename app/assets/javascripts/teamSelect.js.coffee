clio = angular.module('clio', ['ngAnimate', 'gs.preloaded']);

clio.factory('Teams', ['$http', ($http, $preloaded) ->
  return {
    addUser: (user) ->
      teamId = $('#team-id').data('team-id')
      $http.post("/teams/#{teamId}/add_user", {user: user})
    get: ->
      teamId = $('#team-id').data('team-id')
      $http.get("/teams/#{teamId}.json")
      .then((response)->
        return response.data)
      .catch((data)->
        console.log 'Error getting Team'
        console.log data)
    }])


clio.factory('Users', ['$http','$preloaded','makePromise', ($http, $preloaded, makePromise) ->
  return {
    get: (all = false)->
      if $preloaded.users
        console.log "$preloaded users"
        users = _.map($preloaded.users, (user)->
          user.full_name = "#{user.first_name} #{user.last_name}"
          return user
          )
        return makePromise.call({users: users})
      else
      $http({method: 'GET', url: '/users.json', params: {all: all}})
        .then((response)->
          return response.data)
        .catch((data)->
          console.log 'Error #{data}'
          return data)    
    }])

clio.factory('makePromise', ['$q', ($q)->
  return {
    call: (data)->
      deferred = $q.defer()
      deferred.resolve(data)
      return deferred.promise
    }])

clio.directive('teamMemberDisplay', ['Teams','Users', (Teams, Users)->
  restrict: 'E'
  replace: true
  template: """
    <div>
      <div>
        <h3>Team Members</h3>
        <ul>
          <li ng-repeat="user in data.team.users">
            <a href="/users/{{user.id}}">
              {{user.full_name}}
            </a>
          </li>
        </ul>
      </div>
      <div> 
        <h3>
          Add users to this team
        </h3>
        <form ng-submit="submitUser()">
          <select ng-model="data.user" ng-options="user as user.full_name for user in data.usersForSelect">
          <input type="submit" value="Add to team"/>
        </form>
      </div>
    </div>
  """
  controller: ['$scope', ($scope)->
    vm = $scope
    vm.data = {
      user: {}
      team: {}
      usersForSelect: []
    }

    Teams.get()
    .then((data)->
      vm.data.team = data.team
      Users.get(true)
      .then( (data) ->
        console.log data.users
        names = _.map(vm.data.team.users, (user)-> 
          user.full_name)

        vm.data.usersForSelect = _.compact(_.map(data.users, (user)->
          if _.contains(names, user.full_name)
            return false
          else
            return user))
        console.log vm.data.usersForSelect)
      .catch((data)->
        console.log 'Catch in addUser'))
    .catch((data)->
      console.log 'Error in Teams.get')

    vm.submitUser = ->
      Teams.addUser(vm.data.user)
      .then((data) ->
        console.log('Team updated')
        vm.data.team.users.push(vm.data.user)
        index = vm.data.usersForSelect.indexOf(vm.data.user)
        vm.data.usersForSelect.splice(index, 1)
        vm.data.user = {})
      .catch((data)->
        console.log(data))

    ]])