## react-native-keyboardevents

Keyboard events for react-native

## Example

```javascript
// require the module
var KeyboardEvents = require('react-native-keyboardevents');

// Now get a handle on the event emitter and add your callbacks
// to the desired events.
var KeyboardEventEmitter = KeyboardEvents.Emitter;
KeyboardEventEmitter.on(KeyboardEvents.KeyboardWillShowEvent, () => {
  console.log('will show');
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardDidShowEvent, (size) => {
  console.log('did show', size);
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardWillHideEvent, () => {
  console.log('will hide');
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardDidHideEvent, () => {
  console.log('did hide');
});
```
