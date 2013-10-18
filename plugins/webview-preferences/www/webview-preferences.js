/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/

var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');
   
var WebViewPreferences = function() {
};

WebViewPreferences.enableViewportScale = function(b) {
    exec(null, null, "WebViewPreferences", "enableViewportScale", [b]);
};

WebViewPreferences.mediaPlaybackRequiresUserAction = function(b) {
    exec(null, null, "WebViewPreferences", "mediaPlaybackRequiresUserAction", [b]);
};

WebViewPreferences.allowInlineMediaPlayback = function(b) {
    exec(null, null, "WebViewPreferences", "allowInlineMediaPlayback", [b]);
};

WebViewPreferences.keyboardDisplayRequiresUserAction = function(b) {
    exec(null, null, "WebViewPreferences", "keyboardDisplayRequiresUserAction", [b]);
};

WebViewPreferences.suppressesIncrementalRendering = function(b) {
    exec(null, null, "WebViewPreferences", "suppressesIncrementalRendering", [b]);
};

WebViewPreferences.disallowOverscroll = function(b) {
    exec(null, null, "WebViewPreferences", "disallowOverscroll", [b]);
};

WebViewPreferences.gapBetweenPages = function(f) {
    exec(null, null, "WebViewPreferences", "gapBetweenPages", [f]);
};

WebViewPreferences.pageLength = function(f) {
    exec(null, null, "WebViewPreferences", "pageLength", [f]);
};

WebViewPreferences.paginationBreakingMode = function(s) {
    exec(null, null, "WebViewPreferences", "paginationBreakingMode", [s]);
};

WebViewPreferences.paginationMode = function(s) {
    exec(null, null, "WebViewPreferences", "paginationMode", [s]);
};

module.exports = WebViewPreferences;
