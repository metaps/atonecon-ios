
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
        "address": "東京都中央区銀座1-10ー6 銀座ファーストビル4階",
        "tel": "03-1234-1234",
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
             pub_key: "bB2uNvcOP2o8fJzHpWUumA",
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

function startAtone() {
    Atone.start();
}