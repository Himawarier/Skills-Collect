# 控件切图命名规范参考

## 前缀表

| 控件类型   | 前缀       | 使用场景                     |
|-----------|-----------|-----------------------------|
| Button    | `Btn_`    | 按钮、可点击区域             |
| Label     | `Lbl_`    | 文本标签、标题               |
| Image     | `Img_`    | 图片、背景图                 |
| Icon      | `Icon_`   | 图标（状态栏图标、功能图标） |
| List      | `List_`   | 列表项、菜单项               |
| Input     | `Input_`  | 输入框、搜索框               |
| Slider    | `Slider_` | 滑动条、进度条               |
| CheckBox  | `Check_`  | 复选框、多选按钮             |
| Radio     | `Radio_`  | 单选框                       |
| Switch    | `Switch_` | 开关按钮                     |
| Progress  | `Prog_`   | 进度指示器、加载条           |
| Tab       | `Tab_`    | 标签页按钮                   |
| Card      | `Card_`   | 卡片容器                     |
| Popup     | `Popup_`  | 弹窗、对话框                 |
| StatusBar | `Status_` | 状态栏                       |
| NavBar    | `Nav_`    | 底部/顶部导航栏              |
| Container | `Ctn_`    | 容器面板                     |
| Bg        | `Bg_`     | 背景图片                     |
| PageCtrl  | `Page_`   | 页面指示器                   |
| ScrollBar | `Scro_`   | 滚动条                       |
| Toast     | `Toast_`  | 提示消息                     |
| Divider   | `Div_`    | 分割线                       |
| Avatar    | `Avt_`    | 头像                         |
| Dropdown  | `Drop_`   | 下拉菜单                     |

## 命名示例

| 原始命名（用户提供）      | 规范命名                   |
|--------------------------|--------------------------|
| `123.jpg`                | `Img_logo.jpg`           |
| `button.png`             | `Btn_confirm.png`        |
| `截屏20240601.png`       | `Bg_main.png`            |
| `wifi-icon.jpg`          | `Icon_wifi.jpg`          |
| `slider2.png`            | `Slider_volume.png`      |
| `topbar.9.png`           | `Status_bar.png`         |
| `abc.png`                | 需根据控件功能命名        |

## 命名原则

1. **含义优先**：名称需体现控件功能，不能无意义
2. **全小写描述**：前缀后的描述部分全小写，单词用下划线分隔
3. **扩展名保留**：保持原始文件扩展名
4. **无空格**：所有名称中不能有空格
5. **数字后缀**：同类型多个控件时用数字区分，如 `Tab_menu1`、`Tab_menu2`
