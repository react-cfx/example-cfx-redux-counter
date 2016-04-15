#!/usr/bin/env coffee
test = require 'tape'
ReducersSyncTest = require './ReducersSyncTest'
SagasAsyncTest = require './SagasAsyncTest'


test 'Sync Reducers Test'
, ReducersSyncTest

test 'Async Sagas Test'
, SagasAsyncTest
