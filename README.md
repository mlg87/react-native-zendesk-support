# react-native-zendesk-support
React Native bridge to ZenDesk Support SDK on iOS and Android. This currently only supports using the out of the box views the ZenDesk Support SDK provides. At the moment, only anonymous authentication is supported.

## React Native Version Support

This has only been tested to work with React Native 0.47, probably works in earlier versions.

## Getting started

Follow the instructions to install the ZenDesk Support SDK for [iOS](https://developer.zendesk.com/embeddables/docs/ios/integrate_sdk) and [Android](https://developer.zendesk.com/embeddables/docs/android/integrate_sdk).

Don't forget to link the npm to React Native!
```
react-native link
```

## Usage

Import the module
```js
import ZenDeskSupport from 'react-native-zendesk-support';
```

### Support Tickets

File a ticket
```js
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
```js
const identity = {
  customerEmail: 'foo@bar.com',
  customerName: 'Foo Bar'
}
ZenDeskSupport.supportHistory(identity)
```

### Help Center

Show help center
```js
ZenDeskSupport.showHelpCenter()
```

Show categories, e.g., FAQ
```js
ZenDeskSupport.showCategories(['categoryId'])
```

Show sections, e.g., Account Questions
```js
ZenDeskSupport.showSections(['sectionId'])
```

Show labels, e.g., tacocat
```js
ZenDeskSupport.showLabels(['tacocat'])
```

#### Options
The Help Center functions above support a second parameter, an object of options.
```js
const options = {
hideContactSupport: true,
withContactUsButtonVisibility: "OFF"
}

ZenDeskSupport.showHelpCenterWithOptions({ options })
ZenDeskSupport.showCategoriesWithOptions(['categoryId'], { options })
ZenDeskSupport.showSectionsWithOptions(['sectionId'], { options })
ZenDeskSupport.showLabelsWithOptions(['tacocat'], { options })
```

```
hideContactSupport: true || false // iOS only (appears on empty search results)
showConversationsMenuButton: true || false // android only (top right menu button)
withContactUsButtonVisibility: "OFF" || "ARTICLE_LIST_ONLY" || "ARTICLE_LIST_AND_ARTICLE" // android only (floating action button)
```

## Known bugs
* Disappearing section headers on android

## Upcoming Features

* Authenticate using JWT endpoint
* Theme support
* Show article by id
* Hiding "Contact us" on iOS from article and list view
