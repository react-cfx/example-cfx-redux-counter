import dd from 'ddeyes'
import { getStore } from 'cfx.redux'
import { reducers } from '../src'

import taskConf from './testConf'

export default (t) ->

  tasks = taskConf.slice()

  store = getStore {
    appName: 'counterApp'
    reducers
    subscriber:
      sync: ->
        state = store.getState()
        task = tasks.shift()
        dd state
        t.deepEqual state
        , task.expected
        , task.msge
  }

  dd store.getState()

  for task in tasks.slice()
    store.dispatch task.actual.sync()

  store.onsubscribe()

  t.end()
