Google material design 镜像搭建过程

* 首先使用 wget 命令把官网上的资源下载到本地

    wget -r -l1 --no-parent http://www.google.com/design/spec

当然希望上面这条命令能解决问题，但实际上只把所有网页和一部分 css 和 js 文件下载下来，那剩下的资源，
比如说图片和视频文件怎么办呢？ 那就需要通过写脚本，获得图片和视频的链接地址，然后借助 wget 命令挨个下载。

* 下载图片和视频文件

脚本 download_assets.rb 的功能就是下载 google material design 网站上的图片和视频到本地。

因为已经获取了所有的 html 文件，那就读取每个 html 文件的内容，然后匹配所有的 <img> 和 <source> 标签，
分析其中的 src 属性值，从而得到每个资源的链接地址。具体代码查看文件。

有一点需要说明，有的链接地址中存在空格，所以要借助工具处理一下，这个工具就是 URI，调用 URI 的 encode
的方法重新对链接地址编码，把其中的空格替换为 %20，这样才能把文件下载到本地。

最后说一下图片和视频的存放位置。Google material design 文档组织结构，分为十章，每章中又或多或少地包含几个小节。
因此，就在每章下面新建立了一个 images 目录，用于存放本章中用到的图片，若有这一章中包含视频文件，
则会建立 videos 目录，用来存放本章中的视频文件。

* 其它资源下载

通过上面两步操作，仍然不能把 Material Design 的资源全部下载下来，还有一些图片、css、js 文件。
比方说 css 文件中用到的背景图片，控制图片响应式的 js 文件，渲染颜色列表的 css 文件，这些都是手动下载的。

* 更改资源链接地址

好了，完成上面三个操作之后呢，Material Design 的所有资源就都下载到本地了。现在用 Chrome 浏览器打开一个 html 文件，
会发现样式没有加载，图片和视频也不能显示，这时就需要更改这些资源的链接地址了。以下 xxx 代表具体的资源名称：

脚本 assets_sources.rb 文件的功能就是更改图片和视频的链接地址的，地址都用相对地址表示，如 ./images/xxx，./videos/xxx

像 css 样式表中用到的背景图片的地址，则是 ../static/images/xxx

前面所说的控制颜色列表的 css 样式文件地址是，../static/sites/spec/color-palettes.css

那 css 和 js 文件的地址链接是这样的，../satic/css/xxx, ../static/js/xxx, 这些地址的修改是在 sublime 中完成的。
