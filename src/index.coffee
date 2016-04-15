CounterApp =
  types: (
    require './constants/index'
  ).types
  actions: require './actions/index'
  reducers: require './reducers/index'
  sagas: require './sagas/index'

module.exports = CounterApp
