var Atone,bind=function(t,e){return function(){return t.apply(e,arguments)}};Atone=function(){function t(){}var e,i;return i=null,e=function(){function t(){this.receive_message_control=bind(this.receive_message_control,this),this.start=bind(this.start,this),this.remove_viewport=bind(this.remove_viewport,this),this.add_viewport=bind(this.add_viewport,this),this.is_sp=bind(this.is_sp,this),this.config=bind(this.config,this),this.calc_modal_position=bind(this.calc_modal_position,this),this.init_post_message=bind(this.init_post_message,this),this.iframe_load=bind(this.iframe_load,this),this.jq_loaded=bind(this.jq_loaded,this),this.merge=bind(this.merge,this)}return t.prototype.merge=function(t){var e;t||(t={});for(e in t)if(t.hasOwnProperty(e))return void(this.options[e]=t[e])},t.prototype.jq_loaded=function(t){var e,i,n;return null==this.j?(e=document.getElementsByTagName("head")[0],n="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js",i=document.createElement("script"),i.setAttribute("src",n),e.appendChild(i),i.onload=function(e){return function(){if(e.j=jQuery.noConflict(!0),null!=t)return t()}}(this)):null!=t?t():void 0},t.prototype.iframe_load=function(){var t;return t=new this.j.Deferred,this.iframe=this.j("<iframe/>",{src:"https://it-auth.a-to-ne.jp/payment/#/",name:"authentication-form-iframe",id:"authentication-form-iframe",style:"width: 100%;height: 516px;",scrolling:"no",allowtransparency:"true",frameborder:"0"}),this.div=this.j("<div/>",{"class":"m-modalBox",style:"background: #fff;border-radius: 7px;overflow: hidden;position: absolute;top: 0;width: 340px;z-index: 9999;display:none;"}),this.iframe.on("angular_loaded",function(){return function(){return t.resolve()}}(this)),this.div.appendTo("body"),this.iframe.appendTo(this.div),this.receive_message_control(),t.promise()},t.prototype.init_post_message=function(){var t;return t={pub_key:this.options.pub_key,pre_token:this.options.pre_token,payment:this.options.payment},this.iframe[0].contentWindow.postMessage(t,"*")},t.prototype.calc_modal_position=function(){var t,e,i,n,o;return o=this.j(window).width(),i=this.j(window).height(),e=this.j(".m-modalBox").outerWidth(),t=this.j(".m-modalBox").outerHeight(),n=this.j(window).scrollTop(),t>i&&(i=t+60),this.j(".m-modalBox").css({left:(o-e)/2+"px",top:n+(i-t)/2+"px"})},t.prototype.config=function(t,e){return this.options=t,this.jq_loaded(function(t){return function(){var i,n;return t.iframe?e():(n=navigator.userAgent,n.indexOf("iPhone")>=0||n.indexOf("iPad")>=0||n.indexOf("Android")>=0?window.addEventListener("orientationchange",t.calc_modal_position):window.addEventListener("resize",t.calc_modal_position),i=t.iframe_load().then(t.init_post_message),null!=e?i.then(e):void 0)}}(this))},t.prototype.is_sp=function(){var t;return t=navigator.userAgent,t.indexOf("iPhone")>0||t.indexOf("Android")>0&&t.indexOf("mobile")},t.prototype.add_viewport=function(){var t;if(null!=this.is_sp()&&(this.org_viewport=this.j("meta[name='viewport']").attr("content"),null==this.org_viewport||""===("function"==typeof(t=this.org_viewport).trim?t.trim():void 0)))return this.j("head").append('<meta name="viewport" content="width=device-width,initial-scale=1">')},t.prototype.remove_viewport=function(){var t;if(null!=this.is_sp()&&(null==this.org_viewport||""===("function"==typeof(t=this.org_viewport).trim?t.trim():void 0)))return this.j("meta[name='viewport']").attr("content","")},t.prototype.start=function(){return this.add_viewport(),this.j("body").append("<div class='atone-c-overlay' style='background: rgba(0, 0, 0, 0.7);content: \"\";display: block;position: fixed;top: 0;left: 0;height: 100%;width: 100%;z-index: 9998;'></div>"),this.calc_modal_position(),this.div.fadeIn(300,function(t){return function(){return t.iframe[0].contentWindow.postMessage("start","*")}}(this))},t.prototype.receive_message_control=function(){return window.addEventListener("message",function(t){return function(e){var i,n;switch(e.data.msg){case"angular_loaded":return t.iframe.trigger("angular_loaded");case"link":return window.open(e.data.url,"_blank");case"cancelled":if(t.remove_viewport(),t.j(".atone-c-overlay, div.m-modalBox").fadeOut(300).promise().done(function(){return setTimeout(function(){t.j(".atone-c-overlay").remove()},450),t.init_post_message()}),null!=t.options.cancelled)return t.options.cancelled();break;case"authenticated":if(null!=t.options.authenticated)return i=e.data.authentication_token,t.options.authenticated(i);break;case"sign_out":return t.options.pre_token=null;case"failed":return t.remove_viewport(),t.j(".atone-c-overlay, div.m-modalBox").fadeOut(300).promise().done(function(){var i;if(setTimeout(function(){t.j(".atone-c-overlay").remove()},450),t.init_post_message(),null!=t.options.failed)return i=e.data.response,t.options.failed(i)});case"succeeded":return t.remove_viewport(),t.j(".atone-c-overlay, div.m-modalBox").fadeOut(300).promise().done(function(){var i;if(setTimeout(function(){t.j(".atone-c-overlay").remove()},450),t.init_post_message(),null!=t.options.succeeded)return i=e.data.response,t.options.succeeded(i)});case"box_height":if(n=e.data.box_height,n>0)return t.iframe.height(e.data.box_height)}}}(this),!1)},t}(),t.instance=function(){return null!=i?i:i=new e},t.config=function(e,i){return t.instance().config(e,i)},t.merge=function(e){return t.instance().merge(e)},t.start=function(){return t.instance().start()},t}();
// 支払い用のJavascriptオブジェクトデータ(JSON)



// Need to genarate
var data = {
    "amount": 12460, // 課金額:必須
    "shop_transaction_no": "shop-tran-no-015", // 加盟店取引ID:必須
    "sales_settled": true, // 売上確定
    "description_trans": "取引備考欄", //加盟店取引備考:任意
    "checksum": "Eba8b4JtD+inOc/zRON0D4RfODMfXwsz1hCdAmrq1CI=", // チェックサム
    "customer": { // 購入者:必須
        "customer_name": "注文太郎",
        "customer_family_name": "注文",
        "customer_given_name": "太郎",
        "customer_name_kana": "ちゅうもんたろう",
        "customer_family_name_kana": "ちゅうもん",
        "customer_given_name_kana": "たろう",
        "phone_number": "090-1111-1111",
        "birthday": "1990-01-01",
        "sex_division": "1",
        "company_name": "ネットプロテクションズ",
        "department": "セールス",
        "zip_code": "123-4567",
        "address": "東京都中央区銀座1-10ー6 銀座ファーストビル4階", "tel": "03-1234-1234",
        "email": "no@netprotections.co.jp",
        "total_purchase_count": 8,
        "total_purchase_amount": 2160
    },
    "dest_customers": [{ // サービス提供先
                       "dest_customer_name": "注文",
                       "dest_customer_name_kana": "ぎんざたろう",
                       "dest_company_name": "株式会社ネットプロテクションズ",
                       "dest_department": "システム部門",
                       "dest_zip_code": "123-1234",
                       "dest_address": "東京都中央区銀座1­1­6 銀座ファーストビル4階",
                       "dest_tel": "0312341234",
                       "dest_email": ""
                       }],
    "items": [ // 商品明細
              {
              "shop_item_id": "item-012", // 加盟店商品ID: 必須
              "item_name": "商品012", // 商品名: 必須
              "item_price": 1500, // 商品単価:必須
              "item_count": 1, // 個数: 必須
              "item_url": "https://atone.be/items/012/" // 商品URL: 必須
              },
              {
              "shop_item_id": "item-056",
              "item_name": "商品056",
              "item_price": 9800,
              "item_count": 1,
              "item_url": "https://atone.be/items/056/"
              },
              {
              "shop_item_id": "item-077",
              "item_name": "商品077",
              "item_price": 580,
              "item_count": 2,
              "item_url": "https://atone.be/items/077/"
              }
              ]
}
Atone.config({
             pre_token: "W2yAg_sHhOUbNdXTafe_f23B",
             pub_key: "7jqf-uzmxDnJoOwpw8smUQ",
             payment: data,
             // 認証が完了したタイミングで呼び出し
             authenticated: function(authentication_token) {
             window.webkit.messageHandlers.authenticated.postMessage(authentication_token);
             },
             // モーダルを閉じたタイミングで呼び出し
             cancelled: function() {
             window.webkit.messageHandlers.cancelled.postMessage('ングで呼び出し');
             },
             // 決済がNGとなった後、ボタンを押してフォームを閉じたタイミングで呼び出し
             failed: function(response) {
             window.webkit.messageHandlers.failed.postMessage(response);
             },
             // 決済がOKとなり自動でフォームが閉じたタイミングで呼び出し
             succeeded: function(response) {
             window.webkit.messageHandlers.succeeded.postMessage(response);
             }
             });
var button = document.getElementById("atone-button");
button.addEventListener("click", function(e) {
                        Atone.start(); // クリック時にモーダルを立ち上げる。
                        }, false)
var cancelButton = document.getElementById("cancel-button");
cancelButton.addEventListener("click", function(e) {
                              window.webkit.messageHandlers.dismiss.postMessage("dismiss");
                              }, false)
