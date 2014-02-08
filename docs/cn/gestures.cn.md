自動化移動設備手勢測試
==========================

雖然Selenium WebDriver規格支援部分類型的人機互動，它的參數設置跟手機軟體所提供的自動化測試軟體不見得能吻合(例如說iOS提供的UIAutomation)。因此, Appium擴增了WebDriver規格以外的移動設備的手勢指令以及參數設置:

* **點擊** (在螢幕或著物件上) 可設定的參數為:
  * 手指的數量
  * 點擊的時間
  * 點擊的數量
  * 精確的指明螢幕上或是物件上的點擊位置
* **輕拂** (在螢幕或著物件上) 可設定的參數為:
  * 手指的數量
  * 輕拂在螢幕或著物件上的初始位置
  * 輕拂在螢幕或著物件上的結束位置
* **刷動/拖曳** (在螢幕或著物件上) 可設定的參數為:
  * 手指的數量
  * 刷動/拖曳的時間(單位為秒)
  * 刷動在螢幕或著物件上的初始位置
  * 刷動在螢幕或著物件上的結束位置
* **滾動至** (物件)
* **滑動條**
* **震動**
* **長時間觸碰** (物件)
* **手機方向** 可設定的參數為:
  * 新的方向 (倒橫或著豎立)

## JSON Wire Protocol server 擴充
下面是一些我們所編寫的規格擴充終端。

**關於坐標:** 以下所示範的所有X軸和Y軸參數都有兩種使用方式。如果此參數是介于0和1之間(例如說，0.5)，此參數將被視為螢幕或著是物件大小的百分比率。換句話說，`{x: 0.5, y: 0.25}` 指的是一個從螢幕/物件左邊開始算起50%, 然後從螢幕/物件頂部算起25%的坐標。如果參數值大於1, 此參數將被視為像素數。所以，`{x: 100, y: 300}` 所代表的是一個從螢幕/物件左邊算起300像素, 頂部算起300像素的一個坐標。

**關於在螢幕 vs 物件執行動作:** 下列的方法全都允許提供一個非必需的"物件"參數。如果提供此參數，此參數將被視為一個已經檢索到的物件的ID。所以在這種情況下，用戶提供的坐標只會在此物件上使用。 例如說 `{x: 0.5, y: 0.5, element: '3'}` 指的是 "一個ID為'3'的物件的中心坐標".

* `POST session/:sessionId/touch/tap` - 在一個螢幕或是物件上執行點擊
    * URL 參數: 欲連接 session 的sessionId
    * JSON 參數:
        * `tapCount` (非必要, 預設值是 `1`): 執行點擊的次數
        * `touchCount` (非必要, 預設值是 `1`): 執行點擊的手指的數量
        * `duration` (非必要, 預設值是 `0.1`): 點擊觸碰的時間(秒)
        * `x` (非必要, 預設值是 `0.5`): 點擊的 x 軸坐標 (單位是像素或著相對應的單位)
        * `y` (非必要, 預設值是 `0.5`): 點擊的 y 軸坐標 (單位是像素或著相對應的單位)
        * `element` (非必要): 欲在此物件執行此動作的物件的ID
* `POST session:/sessionId/touch/flick_precise` - 在一個螢幕或是物件上執行輕拂
    * URL Parameter: 欲連接 session 的sessionId
    * JSON 參數:
        * `touchCount` (非必要, 預設值是 `1`): 執行輕拂的手指的數量
        * `startX` (非必要, 預設值是 `0.5`): 輕拂的起始 x 軸坐標 (單位是像素或著相對應的單位)
        * `startY` (非必要, 預設值是 `0.5`): 輕拂的起始 y 軸坐標 (單位是像素或著相對應的單位)
        * `endX` (必要): 輕拂的結束 x 軸坐標 (單位是像素或著相對應的單位)
        * `endY` (必要): 輕拂的結束 y 軸坐標 (單位是像素或著相對應的單位)
        * `element` (非必要): 欲在此物件執行此動作的物件的ID
* `POST session:/sessionId/touch/swipe` - 在一個螢幕或是物件上執行刷動/拖曳
    * URL 參數: 欲連接 session 的sessionId
    * JSON 參數:
        * `touchCount` (非必要, 預設值是 `1`): 執行刷動的手指數量
        * `startX` (非必要, 預設值是 `0.5`): 刷動的起始 x 軸坐標 (單位是像素或著相對應的單位)
        * `startY` (非必要, 預設值是 `0.5`): 刷動的起始 y 軸坐標 (單位是像素或著相對應的單位)
        * `endX` (必要): 刷動的結束 x 軸坐標 (單位是像素或著相對應的單位)
        * `endY` (必要): 刷動的結束 y 軸坐標 (單位是像素或著相對應的單位)
        * `duration` (非必要, 預設值是 `0.8`): 刷動/拖曳執行所費的時間(秒)
        * `element` (非必要): 欲在此物件執行此動作的物件的ID

**關於改變設備方向的設定:** 設定設備方向需要使用跟點擊，輕拂，拖曳所不同的參數。這個指令是透過設定瀏覽器的方向 "LANDSCAPE" 或著 "PORTRAIT" 達成的。下面所敘述的方法並不適用在改變設備方向。

* `POST /session/:sessionId/orientation` - 設定瀏覽器的方向
    * URL 參數: 欲連接 session 的sessionId
    * JSON 參數:
        * `orientation` (必要): 新的方向，"LANDSCAPE" 或是 "PORTRAIT"

## 額外的連接方法
擴充 JSON Wire Protocol 是不錯，但是這也代表著不同的 WebDriver 語言必須要由開發者自行編寫連接的接口。自然，這種擴充的編寫時間會依照項目的大小而改變。我們在此提議一種不同的解決方案，使用 `driver.execute()` 的特殊參數.

`POST session/:sessionId/execute` 接受兩種 JSON 參數:
  * `script` (通常是一個 javascript 的片段)
  * `args` (通常是的一個數列的引數, 等著發派給 javascript 引擎使用的)

以新的 mobile methods 為例子來說，`script`必須要是下列參數的其中之一：
  * `mobile: tap`
  * `mobile: flick`
  * `mobile: swipe`
  * `mobile: scrollTo`
  * `mobile: shake`
(前綴 `mobile:` 讓我們連接這些指令到正確的接口).

然後 `args` 將是一個只包含一個物件的數列: 一個描述欲使用的方法的參數的 Javascript 物件。假設，我想使用在某螢幕坐標上執行 `tap` 。我可以呼叫`driver.execute` 並發派下列 JSON 參數:

```json
{
  "script": "mobile: tap",
  "args": [{
    "x": 0.8,
    "y": 0.4
  }]
}
```
在這個範例裡，我們在指上面指定的`x` 和 `y`坐標執行 `tap` 方法。

## 編碼範例
下列的範例裡都可以省略物件參數。

### 點擊
* **WD.js:**

  ```js
  driver.elementsByTagName('tableCell', function(err, els) {
    var tapOpts = {
      x: 150 // 從左方起始的像素位數
      , y: 30 // 從上方起始的像素位數
      , element: els[4].value // 我們想點擊的物件的id
    };
    driver.execute("mobile: tap", [tapOpts], function(err) {
      // 繼續測試
    });
  });
  ```

* **Java:**

  ```java
  WebElement row = driver.findElements(By.tagName("tableCell")).get(4);
  JavascriptExecutor js = (JavascriptExecutor) driver;
  HashMap<String, Double> tapObject = new HashMap<String, Double>();
  tapObject.put("x", 150); // 從左方起始的像素位數
  tapObject.put("y", 30); // 從上方起始的像素位數
  tapObject.put("element", ((RemoteWebElement) row).getId()); // 我們想點擊的物件的id
  js.executeScript("mobile: tap", tapObject);
  ```
  ```java
  // 在iOS app裡，如果UI物件可識參數是"false"的話。 
  // 使用物件位置來執行點擊。
  WebElement element = wd.findElement(By.xpath("//window[1]/scrollview[1]/image[1]"));
  JavascriptExecutor js = (JavascriptExecutor) wd;
  HashMap<String, Double> tapObject = new HashMap<String, Double>();
  tapObject.put("x", (double) element.getLocation().getX()); 
  tapObject.put("y", (double) element.getLocation().getY()); 
  tapObject.put("duration", 0.1);
  js.executeScript("mobile: tap", tapObject);
  ```
* **Python:**

  ```python
  driver.execute_script("mobile: tap", {"touchCount":"1", "x":"0.9", "y":"0.8", "element":element.id})
  ```

* **Ruby:**

  ```ruby
  @driver.execute_script 'mobile: tap', :x => 150, :y => 30
  ```

* **Ruby:**

  ```ruby
  b = @driver.find_element :name, 'Sign In'
  @driver.execute_script 'mobile: tap', :element => b.ref
  ```

* **C#:**

  ```C#
  Dictionary<String, Double> coords = new Dictionary<string, double>();
  coords.Add("x", 12);
  coords.Add("y", 12);
  driver.ExecuteScript("mobile: tap", coords);
  ```

### 輕拂

* **WD.js:**

  ```js
  // 執行一個使用兩隻手指並從螢幕中央向左的輕拂動作
  var flickOpts = {
    endX: 0
    , endY: 0
    , touchCount: 2
  };
  driver.execute("mobile: flick", [flickOpts], function(err) {
    // 持續測試
  });
  ```

* **Java:**

  ```java
  JavascriptExecutor js = (JavascriptExecutor) driver;
  HashMap<String, Double> flickObject = new HashMap<String, Double>();
  flickObject.put("endX", 0);
  flickObject.put("endY", 0);
  flickObject.put("touchCount", 2);
  js.executeScript("mobile: flick", flickObject);
  ```

### 拖曳

* **WD.js:**

  ```js
  // 執行一個緩慢的，從螢幕右邊到左邊的拖曳動作
  var swipeOpts = {
    startX: 0.95
    , startY: 0.5
    , endX: 0.05
    , endY: 0.5
    , duration: 1.8
  };
  driver.execute("mobile: swipe", [swipeOpts], function(err) {
    // 繼續測試
  });
  ```

* **Java:**

  ```java
  JavascriptExecutor js = (JavascriptExecutor) driver;
  HashMap<String, Double> swipeObject = new HashMap<String, Double>();
  swipeObject.put("startX", 0.95);
  swipeObject.put("startY", 0.5);
  swipeObject.put("endX", 0.05);
  swipeObject.put("endY", 0.5);
  swipeObject.put("duration", 1.8);
  js.executeScript("mobile: swipe", swipeObject);
  ```
  
### 滑動條
 
 * **Java**
 
  ```java
  // 滑動條的參數可以是一個0和1之間的數字字串
  // 例如, "0.1" 是 百分之十, "1.0" 是 百分之百
  WebElement slider =  wd.findElement(By.xpath("//window[1]/slider[1]"));
  slider.sendKeys("0.1");
  ```

### 設置設備方向

* **WD.js:**
  ```js
  driver.setOrientation("LANDSCAPE", function(err) {
    // 繼續測試
  });
  ```

* **Python:**
  ```python
  driver.orientation = "LANDSCAPE"
  ```

### 滾動至

```ruby
  b = @driver.find_element :name, 'Sign In'
  @driver.execute_script 'mobile: scrollTo', :element => b.ref
```

### 長時間碰觸
 
 * **c#**
 
  ```c#
  // 長時間碰觸物件
  // 
  Dictionary<string, object> parameters = new Dictionary<string, object>();
  parameters.Add("using", _attributeType);
  parameters.Add("value", _attribute);
  Response response = rm.executescript(DriverCommand.FindElement, parameters);
  Dictionary<string, object> elementDictionary = response.Value as Dictionary<string, object>;
  string id = null;
  if (elementDictionary != null)
  {
     id = (string)elementDictionary["ELEMENT"];
  }
  IJavaScriptExecutor js = (IJavaScriptExecutor)remoteDriver;
  Dictionary<String, String> longTapObject = new Dictionary<String, String>();
  longTapObject.Add("element", id);
  js.ExecuteScript("mobile: longClick", longTapObject);
  ```
