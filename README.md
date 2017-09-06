# react-native-zendesk-support
React Native bridge to ZenDesk Support SDK on iOS and Android. This currently only supports using the out of the box views the ZenDesk Support SDK provides. At the moment, only anonymous authentication is supported.

## React Native Version Support

This has only been tested to work with React Native 0.47

## Getting started

Follow the instructions to install the ZenDesk Support SDK for [iOS](https://developer.zendesk.com/embeddables/docs/ios/integrate_sdk) and [Android](https://developer.zendesk.com/embeddables/docs/android/integrate_sdk).

Don't forget to link the npm to React Native!
```
react-native link
```

## Usage

In your code add `import ZenDeskSupport from 'react-native-zendesk-support';`.

File a ticket
```
const identity = {
  customerEmail: 'foo@bar.com',
  customerName: 'Foo Bar'
}

const customFields = {
  customFieldId: 'Custom Field Value'
}
ZenDeskSupport.callSupport(identity, customFields)
```

Bring up ticket history
```
const identity = {
  customerEmail: 'foo@bar.com',
  customerName: 'Foo Bar'
}
ZenDeskSupport.supportHistory(identity)
```

## TODO

* Authenticate using JWT endpoint
