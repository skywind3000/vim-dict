# vim-dict

没办法，被逼的，重新整理一个词典补全的数据库。网上很多 dict 的插件，问题：

- 他们不更新，不添加文件类型，每个文件类型关键词太少。
- 没有收录 c10k 之类的英文词库。
- 不提供配置让我加载其他地方的词库，只能加载插件自带的词库。

## 怎么配置其他位置的词库？

```VimL
let g:vim_dict_dict = [
    \ '~/.vim/dict',
    \ '~/.config/nvim/dict',
    \ ]
```

## 怎么挂载 c10k ?

```VimL
let g:config = {'text':['word']}
```

还可以挂在 c20k

```VimL
let g:config = {'text':['wordmax']}
```
