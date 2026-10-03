# 矩阵乘法：四种理解

1920×1080，30 fps，141 秒。中文配音和画面讲解。

## 使用

```powershell
npm ci
npm run studio
npm run render
```

源码位于 `src/index.tsx`，配音位于 `public/`。`render.mjs` 使用 Remotion 渲染，输出到上一级目录。

## 内容

- 00:00 引入矩阵与维度
- 00:12 内积：A 的行与 B 的列生成一个元素
- 00:38 外积：A 的列与 B 的行生成矩阵并累加
- 01:04 行组合：A 的行提供系数，组合 B 的行
- 01:34 列组合：B 的列提供系数，组合 A 的列
- 02:04 四种视角总结

A = [[1,2,1],[2,0,1]]，B = [[1,2],[0,1],[2,1]]，AB = [[3,5],[4,5]]。

行空间和列空间的结论是包含关系，通常不保证相等。外积指列向量乘行向量。

Remotion 文档：https://www.remotion.dev/docs/renderer/render-media
