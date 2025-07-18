# 本地部署指南

这是一个基于 jemdoc 的学术个人网站项目。本指南将帮助您在本地构建和预览网站。

## 项目结构

- `www/` - 包含所有 jemdoc 源文件
- `css/` - 样式文件
- `jemdoc` - jemdoc 编译器
- `latexmath2png.py` - LaTeX 数学公式转换工具
- `local_deploy.sh` - 本地部署脚本

## 快速开始

### 1. 本地构建和预览

运行本地部署脚本：

```bash
./local_deploy.sh
```

这将：
- 创建 `_site` 目录
- 复制所有必要的资源文件
- 编译所有 jemdoc 文件为 HTML
- 提供预览选项

### 2. 预览网站

构建完成后，您可以通过以下方式预览：

**方式 1: 直接打开文件**
```bash
open _site/index.html
```

**方式 2: 使用 Python 服务器**
```bash
cd _site
python3 -m http.server 8000
```
然后访问 http://localhost:8000

**方式 3: 使用 live-server (需要先安装)**
```bash
npm install -g live-server
cd _site
live-server
```

## 编辑网站内容

### 主要文件

- `www/index.jemdoc` - 主页内容
- `www/MENU` - 导航菜单配置
- `www/publications.jemdoc` - 发表论文
- `www/people.jemdoc` - 团队成员
- `www/lab.jemdoc` - 实验室信息

### 添加新页面

1. 在 `www/` 目录中创建新的 `.jemdoc` 文件
2. 在 `www/MENU` 中添加菜单项
3. 重新运行 `./local_deploy.sh`

## LaTeX 数学公式

### 使用 MathJax (推荐)

项目已配置 MathJax 支持，您可以直接在 jemdoc 文件中使用 LaTeX 数学公式：

```
行内公式: \( E = mc^2 \)
块级公式: \[ \int_0^\infty e^{-x} dx = 1 \]
```

### 使用 latexmath2png.py

如果需要生成 PNG 图片格式的数学公式：

```python
python latexmath2png.py --help
```

示例用法：
```python
from latexmath2png import math2png

# 生成公式图片
math2png("E = mc^2", "output_dir", prefix="formula")
```

## GitHub Actions 部署

项目包含自动部署配置 (`.github/workflows/deploy.yml`)，当您推送到 main 分支时，GitHub Actions 会自动构建并部署到 gh-pages 分支。

## 故障排除

### 常见问题

1. **jemdoc 命令找不到**
   - 确保 `jemdoc` 文件有执行权限：`chmod +x jemdoc`

2. **CSS 样式丢失**
   - 确保 `css/` 目录存在且包含样式文件
   - 检查 `www/jemdoc.conf` 中的 CSS 配置

3. **数学公式不显示**
   - 检查 MathJax 配置是否正确
   - 确保网络连接正常（MathJax 从 CDN 加载）

4. **图片不显示**
   - 确保图片文件在 `www/photos/` 目录中
   - 检查 jemdoc 文件中的图片路径

### 调试技巧

- 查看构建日志：运行 `./local_deploy.sh` 时注意输出信息
- 检查生成的 HTML 文件：在 `_site/` 目录中查看生成的文件
- 使用浏览器开发工具检查网络请求和控制台错误

## 更多帮助

- jemdoc 文档: http://jemdoc.jaboc.net/
- MathJax 文档: https://docs.mathjax.org/
- 项目仓库: 查看 README.md 和 issues 