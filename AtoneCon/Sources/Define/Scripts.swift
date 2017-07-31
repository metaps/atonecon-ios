//
//  Script.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/21/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Define {
    internal struct Scripts {
        static let atoneJS =
            "\nAtone.config({" +
                "pre_token: \"%@\"," +
                "pub_key: \"%@\"," +
                "payment: data," +
                "authenticated: function(authentication_token) { " +
                    "window.webkit.messageHandlers.authenticated.postMessage(authentication_token);" +
                "}," +
                "cancelled: function() { " +
                    "window.webkit.messageHandlers.cancelled.postMessage(\'ングで呼び出し\');" +
                "}," +
                "failed: function(response) { " +
                    "window.webkit.messageHandlers.failed.postMessage(response);" +
                "}," +
                "succeeded: function(response) { " +
                    "window.webkit.messageHandlers.succeeded.postMessage(response);" +
                "}" +
            "});" +
            "function startAtone() { Atone.start();}\n"

        static let atoneHTML =
            "<!DOCTYPE html>" +
            "<html lang=\"ja\">" +
                "<head>" +
                    "<meta charset=\"UTF-8\">" +
                    "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">" +
                    "<meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,width=device-width,user-scalable=0\">" +
                    "<link rel=\"stylesheet\" href=\"https://www.w3schools.com/w3css/4/w3mobile.css\">" +
                    "<script>" +
                        "var Atone,bind=function(t,e){return function(){return t.apply(e,arguments)}};Atone=function(){function t(){}var e,i;return i=null,e=function(){function t(){this.receive_message_control=bind(this.receive_message_control,this),this.start=bind(this.start,this),this.remove_viewport=bind(this.remove_viewport,this),this.add_viewport=bind(this.add_viewport,this),this.is_sp=bind(this.is_sp,this),this.config=bind(this.config,this),this.calc_modal_position=bind(this.calc_modal_position,this),this.init_post_message=bind(this.init_post_message,this),this.iframe_load=bind(this.iframe_load,this),this.jq_loaded=bind(this.jq_loaded,this),this.merge=bind(this.merge,this)}return t.prototype.merge=function(t){var e;t||(t={});for(e in t)if(t.hasOwnProperty(e))return void(this.options[e]=t[e])},t.prototype.jq_loaded=function(t){var e,i,n;return null==this.j?(e=document.getElementsByTagName(\"head\")[0],n=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js\",i=document.createElement(\"script\"),i.setAttribute(\"src\",n),e.appendChild(i),i.onload=function(e){return function(){if(e.j=jQuery.noConflict(!0),null!=t)return t()}}(this)):null!=t?t():void 0},t.prototype.iframe_load=function(){var t;return t=new this.j.Deferred,this.iframe=this.j(\"<iframe/>\",{src:\"https://it-auth.a-to-ne.jp/payment/#/\",name:\"authentication-form-iframe\",id:\"authentication-form-iframe\",style:\"width: 100%;height: 516px;\",scrolling:\"no\",allowtransparency:\"true\",frameborder:\"0\"}),this.div=this.j(\"<div/>\",{\"class\":\"m-modalBox\",style:\"background: #fff;border-radius: 7px;overflow: hidden;position: absolute;top: 0;width: 340px;z-index: 9999;display:none;\"}),this.iframe.on(\"angular_loaded\",function(){return function(){return t.resolve()}}(this)),this.div.appendTo(\"body\"),this.iframe.appendTo(this.div),this.receive_message_control(),t.promise()},t.prototype.init_post_message=function(){var t;return t={pub_key:this.options.pub_key,pre_token:this.options.pre_token,payment:this.options.payment},this.iframe[0].contentWindow.postMessage(t,\"*\")},t.prototype.calc_modal_position=function(){var t,e,i,n,o;return o=this.j(window).width(),i=this.j(window).height(),e=this.j(\".m-modalBox\").outerWidth(),t=this.j(\".m-modalBox\").outerHeight(),n=this.j(window).scrollTop(),t>i&&(i=t+60),this.j(\".m-modalBox\").css({left:(o-e)/2+\"px\",top:n+(i-t)/2+\"px\"})},t.prototype.config=function(t,e){return this.options=t,this.jq_loaded(function(t){return function(){var i,n;return t.iframe?e():(n=navigator.userAgent,n.indexOf(\"iPhone\")>=0||n.indexOf(\"iPad\")>=0||n.indexOf(\"Android\")>=0?window.addEventListener(\"orientationchange\",t.calc_modal_position):window.addEventListener(\"resize\",t.calc_modal_position),i=t.iframe_load().then(t.init_post_message),null!=e?i.then(e):void 0)}}(this))},t.prototype.is_sp=function(){var t;return t=navigator.userAgent,t.indexOf(\"iPhone\")>0||t.indexOf(\"Android\")>0&&t.indexOf(\"mobile\")},t.prototype.add_viewport=function(){var t;if(null!=this.is_sp()&&(this.org_viewport=this.j(\"meta[name=\'viewport\']\").attr(\"content\"),null==this.org_viewport||\"\"===(\"function\"==typeof(t=this.org_viewport).trim?t.trim():void 0)))return this.j(\"head\").append(\'<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">\')},t.prototype.remove_viewport=function(){var t;if(null!=this.is_sp()&&(null==this.org_viewport||\"\"===(\"function\"==typeof(t=this.org_viewport).trim?t.trim():void 0)))return this.j(\"meta[name=\'viewport\']\").attr(\"content\",\"\")},t.prototype.start=function(){return this.add_viewport(),this.j(\"body\").append(\"<div class=\'atone-c-overlay\' style=\'background: rgba(0, 0, 0, 0.3);content: /\"/\";display: block;position: fixed;top: 0;left: 0;height: 100%;width: 100%;z-index: 9998;\'></div>\"),this.calc_modal_position(),this.div.fadeIn(300,function(t){return function(){return t.iframe[0].contentWindow.postMessage(\"start\",\"*\")}}(this))},t.prototype.receive_message_control=function(){return window.addEventListener(\"message\",function(t){return function(e){var i,n;switch(e.data.msg){case\"angular_loaded\":return t.iframe.trigger(\"angular_loaded\");case\"link\":return window.open(e.data.url,\"_blank\");case\"cancelled\":if(t.remove_viewport(),t.j(\".atone-c-overlay, div.m-modalBox\").fadeOut(300).promise().done(function(){return setTimeout(function(){t.j(\".atone-c-overlay\").remove()},450),t.init_post_message()}),null!=t.options.cancelled)return t.options.cancelled();break;case\"authenticated\":if(null!=t.options.authenticated)return i=e.data.authentication_token,t.options.authenticated(i);break;case\"sign_out\":return t.options.pre_token=null;case\"failed\":return t.remove_viewport(),t.j(\".atone-c-overlay, div.m-modalBox\").fadeOut(300).promise().done(function(){var i;if(setTimeout(function(){t.j(\".atone-c-overlay\").remove()},450),t.init_post_message(),null!=t.options.failed)return i=e.data.response,t.options.failed(i)});case\"succeeded\":return t.remove_viewport(),t.j(\".atone-c-overlay, div.m-modalBox\").fadeOut(300).promise().done(function(){var i;if(setTimeout(function(){t.j(\".atone-c-overlay\").remove()},450),t.init_post_message(),null!=t.options.succeeded)return i=e.data.response,t.options.succeeded(i)});case\"box_height\":if(n=e.data.box_height,n>0)return t.iframe.height(e.data.box_height)}}}(this),!1)},t}(),t.instance=function(){return null!=i?i:i=new e},t.config=function(e,i){return t.instance().config(e,i)},t.merge=function(e){return t.instance().merge(e)},t.start=function(){return t.instance().start()},t}();" +
                    "</script>" +
                "</head>" +
                "<title>ページタイトル</title>" +
                "<body style=\"background-color:rgba(0, 0, 0, 0.3);\">" +
                "</body>" +
            "</html>"
    }
}
