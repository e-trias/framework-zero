/*
  Framework Zero
  Lightweight framework for single purpose apps.
  Version 0.1

  The MIT License (MIT)

  Copyright (c) 2015 Mingo Hagen

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

component{
  this.version = 0.5;
  this.name = hash( getBaseTemplatePath() );
  this.root = cleanPath( getDirectoryFromPath( getBaseTemplatePath() ) );
  this.mappings[ '/root' ] = this.root;
  this.configFiles = this.root & 'config';
  this.defaultConfig = { 'nukescript' = 'populate.sql' };

  public void function onApplicationStart() {
    var mstng = createObject( 'mustang-staging.base' ).init( {} );
    application.config = mstng.readConfig();
  }

  public void function onRequestStart() {
    for ( var kv in url ) {
      if ( kv contains ';' ) {
        url[ kv.listRest( ';' ) ] = url[ kv ];
        url.delete( kv );
      }
    };

    request.reset = structKeyExists( url, 'reload' );

    if ( request.reset ) {
      onApplicationStart();
    }

    request.config = application.config;
  }

  private string function cleanPath( string input, boolean addTrailingSlash = true ) {
    var result = [];

    if ( server.os.name contains 'windows' ) {
      var driveLetter = input.listFirst( ':' );
      input = input.listRest( ':' );
    }

    var path = input.listToArray( '/\' );

    for ( var item in path ) {
      switch ( item ) {
        case '.':
          continue;

        case '..':
          var pathLength = result.len();
          if ( pathLength > 0 ) {
            result.deleteAt( pathLength );
          }
          continue;

        default:
          result.append( item );
      }
    }

    return ( isNull( driveLetter ) ? '' : driveLetter & ':' ) & '/' & result.toList( '/' ) & ( addTrailingSlash ? '/' : '' );
  }

  private void function nil() {
  }
}