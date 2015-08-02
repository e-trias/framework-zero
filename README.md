framework-zero
==============

Lightweight framework for single purpose apps

I created this for tiny cf apps that do mostly one thing and need all the speed they can get while also having some shared convenience functions.

## To use the framework:

1. copy zero.cfc to you app or create a mapping to it.
1. create an Application.cfc and extend this framework.

### Example:

Application.cfc

```cfml
component extends="framework.zero"{
}
```

If you need to manipulate stuff in `onApplicationStart` or `onRequestStart`, call the `super.`-method first.

## Features

- config managment
- application flow
- helper methods (right now, just nil() to return null)
