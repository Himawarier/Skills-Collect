# 交互式HTML模板参考

## 核心结构

生成的HTML应包含以下核心模块：

### 1. 页面容器
- 模拟设备屏幕尺寸（根据分析的分辨率）
- 暗色背景 + 屏幕居中
- 屏幕带圆角边框 + 阴影

### 2. 控件渲染层
- 每个控件一个独立的 div
- 绝对定位（position: absolute）
- 层级管理（z-index）
- 有切图：背景图显示
- 无切图：白膜占位（白色背景、虚线边框、控件名居中）

### 3. 交互层
- 点击交互模拟
- 悬浮 tooltip
- 交互日志面板

### 4. 工具层
- Debug overlay（显示/隐藏控件边框）
- 标尺工具
- 控件信息弹窗

## 模板骨架代码

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>屏幕预览 - {界面名称}</title>
<style>
/* ===== 全局重置 ===== */
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
  background: #1a1a2e;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  font-family: -apple-system, 'PingFang SC', 'Microsoft YaHei', sans-serif;
}

/* ===== 屏幕容器 ===== */
.screen-container {
  position: relative;
  width: {SCREEN_WIDTH}px;
  height: {SCREEN_HEIGHT}px;
  background: #ffffff;
  border-radius: 12px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.5), 0 0 0 2px #333;
  overflow: hidden;
}

/* ===== 控件通用 ===== */
.ctrl {
  position: absolute;
  cursor: pointer;
  transition: filter 0.15s;
}
.ctrl:hover {
  filter: brightness(1.1);
  z-index: 100 !important;
}

/* ===== 白膜占位 ===== */
.ctrl-placeholder {
  background: #f5f5f5;
  border: 1.5px dashed #ccc;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  font-size: 11px;
  text-align: center;
  word-break: break-all;
  padding: 2px;
}

/* ===== 有切图的控件 ===== */
.ctrl-image {
  background-size: 100% 100%;
  background-repeat: no-repeat;
}

/* ===== 交互日志 ===== */
.interact-log {
  position: fixed;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  width: 600px;
  max-height: 120px;
  background: rgba(0,0,0,0.85);
  color: #0f0;
  font-family: 'Courier New', monospace;
  font-size: 13px;
  padding: 10px 16px;
  border-radius: 8px;
  overflow-y: auto;
  z-index: 9999;
  backdrop-filter: blur(8px);
}

/* ===== Tooltip ===== */
.ctrl-tooltip {
  display: none;
  position: absolute;
  bottom: calc(100% + 8px);
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0,0,0,0.9);
  color: #fff;
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 12px;
  white-space: nowrap;
  pointer-events: none;
  z-index: 999;
}
.ctrl:hover .ctrl-tooltip {
  display: block;
}

/* ===== 控件信息卡片 ===== */
.info-card {
  display: none;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.4);
  padding: 24px;
  min-width: 280px;
  z-index: 10000;
}
.info-card.show { display: block; }
.info-overlay {
  display: none;
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,0.4);
  z-index: 9999;
}
.info-overlay.show { display: block; }

/* ===== Debug overlay ===== */
.debug-mode .ctrl {
  outline: 1.5px solid rgba(255, 0, 0, 0.5) !important;
  background: rgba(255, 0, 0, 0.05) !important;
}

/* ===== 标尺 ===== */
.ruler-h {
  position: absolute;
  top: 0; left: 0;
  height: 18px;
  width: 100%;
  background: rgba(0,0,0,0.06);
  display: flex;
  z-index: 999;
}
.ruler-v {
  position: absolute;
  top: 0; left: 0;
  width: 18px;
  height: 100%;
  background: rgba(0,0,0,0.06);
  z-index: 999;
}

/* ===== 控制工具栏 ===== */
.toolbar {
  position: fixed;
  top: 20px;
  right: 20px;
  display: flex;
  gap: 8px;
  z-index: 9999;
}
.toolbar button {
  background: rgba(255,255,255,0.15);
  color: #fff;
  border: 1px solid rgba(255,255,255,0.25);
  padding: 8px 16px;
  border-radius: 8px;
  cursor: pointer;
  font-size: 13px;
  backdrop-filter: blur(8px);
  transition: background 0.2s;
}
.toolbar button:hover {
  background: rgba(255,255,255,0.3);
}
.toolbar button.active {
  background: #4a90d9;
  border-color: #4a90d9;
}
</style>
</head>
<body>

<!-- 工具栏 -->
<div class="toolbar">
  <button onclick="toggleDebug()" id="btnDebug">🔲 辅助线</button>
  <button onclick="toggleRuler()" id="btnRuler">📏 标尺</button>
  <button onclick="clearLog()">🗑 清日志</button>
</div>

<!-- 交互日志 -->
<div class="interact-log" id="logPanel">
  <div style="color:#888;">▶ 交互日志（点击控件查看）</div>
</div>

<!-- 遮罩 -->
<div class="info-overlay" id="infoOverlay" onclick="hideInfo()"></div>

<!-- 信息卡片 -->
<div class="info-card" id="infoCard">
  <h3 id="infoName" style="margin-bottom:8px;"></h3>
  <table style="width:100%;border-collapse:collapse;font-size:13px;">
    <tr><td style="padding:4px 8px;color:#666;">类型</td><td id="infoType" style="padding:4px 8px;"></td></tr>
    <tr><td style="padding:4px 8px;color:#666;">位置</td><td id="infoPos" style="padding:4px 8px;"></td></tr>
    <tr><td style="padding:4px 8px;color:#666;">尺寸</td><td id="infoSize" style="padding:4px 8px;"></td></tr>
    <tr><td style="padding:4px 8px;color:#666;">父对象</td><td id="infoParent" style="padding:4px 8px;"></td></tr>
    <tr><td style="padding:4px 8px;color:#666;">功能</td><td id="infoDesc" style="padding:4px 8px;"></td></tr>
  </table>
  <button onclick="hideInfo()" style="margin-top:12px;padding:6px 20px;border:none;background:#4a90d9;color:#fff;border-radius:6px;cursor:pointer;">关闭</button>
</div>

<!-- 屏幕容器 -->
<div class="screen-container" id="screen">

  <!-- 标尺 -->
  <div class="ruler-h" id="rulerH" style="display:none;"></div>
  <div class="ruler-v" id="rulerV" style="display:none;"></div>

  <!-- ===== 控件列表（动态生成） ===== -->
  <!-- CTRL_PLACEHOLDER -->

</div>

<script>
// 控件数据
const controls = {CTRL_DATA_JSON};

// 交互逻辑映射
const interactions = {INTERACT_DATA_JSON};

// 日志
function addLog(msg) {
  const panel = document.getElementById('logPanel');
  const div = document.createElement('div');
  div.textContent = '▸ ' + msg;
  panel.appendChild(div);
  panel.scrollTop = panel.scrollHeight;
}

function clearLog() {
  const panel = document.getElementById('logPanel');
  panel.innerHTML = '<div style="color:#888;">▶ 交互日志已清空</div>';
}

// 显示信息卡片
function showInfo(name) {
  const ctrl = controls[name];
  if (!ctrl) return;
  document.getElementById('infoName').textContent = name;
  document.getElementById('infoType').textContent = ctrl.type || '-';
  document.getElementById('infoPos').textContent = `X: ${ctrl.x}  Y: ${ctrl.y}`;
  document.getElementById('infoSize').textContent = `W: ${ctrl.w}  H: ${ctrl.h}`;
  document.getElementById('infoParent').textContent = ctrl.parent || '-';
  document.getElementById('infoDesc').textContent = ctrl.desc || '-';
  document.getElementById('infoCard').classList.add('show');
  document.getElementById('infoOverlay').classList.add('show');
}

function hideInfo() {
  document.getElementById('infoCard').classList.remove('show');
  document.getElementById('infoOverlay').classList.remove('show');
}

// Debug 辅助线
let debugOn = false;
function toggleDebug() {
  debugOn = !debugOn;
  document.getElementById('screen').classList.toggle('debug-mode', debugOn);
  document.getElementById('btnDebug').classList.toggle('active', debugOn);
  addLog(debugOn ? '显示控件辅助线' : '隐藏控件辅助线');
}

// 标尺
let rulerOn = false;
function toggleRuler() {
  rulerOn = !rulerOn;
  document.getElementById('rulerH').style.display = rulerOn ? 'flex' : 'none';
  document.getElementById('rulerV').style.display = rulerOn ? 'block' : 'none';
  document.getElementById('btnRuler').classList.toggle('active', rulerOn);
  addLog(rulerOn ? '显示标尺' : '隐藏标尺');
}

// 控件点击处理
function handleClick(name) {
  const action = interactions[name];
  if (action) {
    addLog(`点击「${name}」→ ${action}`);
  } else {
    addLog(`点击「${name}」（未定义交互）`);
  }
  showInfo(name);
}

// 初始化：生成标尺刻度
function initRuler() {
  const screenW = {SCREEN_WIDTH};
  const screenH = {SCREEN_HEIGHT};
  const rulerH = document.getElementById('rulerH');
  const rulerV = document.getElementById('rulerV');

  for (let x = 0; x < screenW; x += 50) {
    const mark = document.createElement('div');
    mark.style.cssText = `position:absolute;left:${x}px;top:0;width:1px;height:10px;background:#999;`;
    rulerH.appendChild(mark);
    if (x % 100 === 0) {
      const lbl = document.createElement('span');
      lbl.style.cssText = `position:absolute;left:${x+3}px;top:10px;font-size:9px;color:#999;`;
      lbl.textContent = x;
      rulerH.appendChild(lbl);
    }
  }

  for (let y = 0; y < screenH; y += 50) {
    const mark = document.createElement('div');
    mark.style.cssText = `position:absolute;top:${y}px;left:0;width:10px;height:1px;background:#999;`;
    rulerV.appendChild(mark);
    if (y % 100 === 0) {
      const lbl = document.createElement('span');
      lbl.style.cssText = `position:absolute;left:12px;top:${y+1}px;font-size:9px;color:#999;white-space:nowrap;`;
      lbl.textContent = y;
      rulerV.appendChild(lbl);
    }
  }
}
initRuler();
</script>
</body>
</html>
```

## 控件HTML生成片段示例

```javascript
// 无切图控件（白膜）
<div class="ctrl ctrl-placeholder" 
     style="left:{X}px; top:{Y}px; width:{W}px; height:{H}px;"
     onclick="handleClick('{NAME}')"
     ondblclick="showInfo('{NAME}')">
  {NAME}
  <div class="ctrl-tooltip">{DESC}</div>
</div>

// 有切图控件
<div class="ctrl ctrl-image"
     style="left:{X}px; top:{Y}px; width:{W}px; height:{H}px;
            background-image:url('{IMAGE_PATH}');"
     onclick="handleClick('{NAME}')"
     ondblclick="showInfo('{NAME}')">
  <div class="ctrl-tooltip">{DESC}</div>
</div>
```

## 交互JSON数据格式

```json
{
  "controls": {
    "Btn_settings": {
      "type": "Button",
      "x": 720, "y": 5,
      "w": 40, "h": 30,
      "parent": "status_bar",
      "desc": "设置快捷入口"
    }
  },
  "interactions": {
    "Btn_settings": "打开设置页面",
    "Btn_music": "跳转到音乐播放界面",
    "Btn_back": "返回上一级页面"
  }
}
```
