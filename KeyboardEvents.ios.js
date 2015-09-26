'use strict';

var {
  DeviceEventEmitter,
  NativeModules: {
    RNKeyboardEventsManager,
  },
} = require('react-native');
var EventEmitter = require('eventemitter3');

var KeyboardEventEmitter = new EventEmitter();
var events = [
  'WillShow',
  'DidShow',
  'WillHide',
  'DidHide',
  'WillChangeFrame',
  'DidChangeFrame',
].map((event) => 'Keyboard' + event);

events.forEach((eventKey) => {
  var event = RNKeyboardEventsManager[eventKey];
  DeviceEventEmitter.addListener(
    event,
    (frames) => {
      if (frames.startCoordinates) {
        frames.begin = frames.startCoordinates;
      }

      if (frames.endCoordinates) {
        frames.end = frames.endCoordinates;
      }

      KeyboardEventEmitter.emit(event, frames);
    }
  );
});

module.exports = events.reduce((carry, eventKey) => {
  carry[eventKey + 'Event'] = RNKeyboardEventsManager[eventKey];
  return carry;
},{
  Emitter: KeyboardEventEmitter
});
