<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <title>縮網址</title>

    <script async src="https://www.googletagmanager.com/gtag/js?id=G-2P7M7D2TJH"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        // 載入您的 GA ID
        gtag('config', 'G-2P7M7D2TJH');
    </script>

    <script>
        // 1. 使用陣列紀錄「參數」與「目標網址」的對應關係
        const redirectList = [
            { id: 'wish3fbig', url: 'https://www.appsheet.com/start/a155238b-5fb0-4408-8b39-51801882d1c1#control=Survey&defaults={%22source%22:%22fb-ig%22}&v=20260426' },
            { id: 'wish3th',     url: 'https://www.appsheet.com/start/a155238b-5fb0-4408-8b39-51801882d1c1#control=Survey&defaults={%22source%22:%22threads%22}&v=20260426' },
			{ id: 'wish3thre',     url: 'https://www.appsheet.com/start/a155238b-5fb0-4408-8b39-51801882d1c1#control=Survey&defaults={%22source%22:%22threads-reply%22}&v=20260426' },
        ];

        window.onload = function() {
            // 2. 取得網址列 ? 後面的參數
            const param = window.location.search.substring(1);

            // 3. 在陣列中尋找符合該參數的物件
            const targetObj = redirectList.find(item => item.id === param);

            if (targetObj) {
                // 如果有找到對應的網址
                const targetUrl = targetObj.url;

                // 4. 發送自訂的 GA 事件，紀錄「短網址來源」與「目標網址」
                gtag('event', 'shortlink_click', {
                    'source_id': param,       // 對應到您在 GA4 後台設定的自訂維度
                    'target_url': targetUrl
                });

                // 5. 延遲轉址以確保 GA 有足夠時間發送數據
                setTimeout(function() {
                    window.location.replace(targetUrl);
                }, 500);

            } else {
                // 如果找不到對應的參數，或是沒有輸入參數
                document.getElementById('message').innerText = '找不到指定的連結，或該連結已失效。';
                
                // 紀錄失敗的點擊（只在使用者有輸入無效參數時紀錄）
                if (param) {
                    gtag('event', 'shortlink_error', {
                        'attempted_param': param
                    });
                }
            }
        };
    </script>
    
    <style>
        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        .container {
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 id="message">正在為您導向目標網頁，請稍候...</h2>
    </div>
</body>
</html>
