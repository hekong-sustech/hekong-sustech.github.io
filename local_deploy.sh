#!/bin/bash

# 本地部署脚本 - 基于 GitHub Actions 工作流程
# 用于在本地构建和预览网站

echo "🚀 开始本地部署 jemdoc 网站..."

# 检查 jemdoc 是否可执行
if [ ! -x "jemdoc" ]; then
    echo "🔧 设置 jemdoc 为可执行文件..."
    chmod +x jemdoc
fi

# 创建输出目录
echo "📁 创建输出目录..."
rm -rf _site
mkdir -p _site

# 复制照片目录
if [ -d "www/photos" ]; then
    echo "📸 复制照片目录..."
    cp -r www/photos _site/
fi

# 复制视频目录（如果存在）
if [ -d "www/videos" ]; then
    echo "🎬 复制视频目录..."
    cp -r www/videos _site/
fi

# 复制 CSS 文件
echo "🎨 复制 CSS 文件..."
cp css/* _site/ || true

# 构建 jemdoc 文件
echo "🔨 构建 jemdoc 文件..."
cd www

# 检查并构建所有 jemdoc 文件
for file in *.jemdoc; do
    if [ -f "$file" ]; then
        echo "  📝 构建 $file..."
        ../jemdoc -c jemdoc.conf -o ../_site/${file%.jemdoc}.html "$file"
        if [ $? -eq 0 ]; then
            echo "  ✅ 成功构建 $file"
        else
            echo "  ❌ 构建失败 $file"
        fi
    fi
done

cd ..

echo "🎉 构建完成！"
echo "📂 网站文件已生成在 _site 目录中"
echo "💡 您可以通过以下方式预览："
echo "   1. 直接打开 _site/index.html"
echo "   2. 使用 Python 启动简单服务器："
echo "      cd _site && python3 -m http.server 8000"
echo "   3. 使用 live-server (如果已安装)："
echo "      cd _site && live-server"
echo ""
echo "🌐 如果使用服务器，请访问 http://localhost:8000"
