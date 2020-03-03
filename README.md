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

再挂载 c24k

```VimL
let g:config = {'text':['ultimate']}
```

## C20K 是什么？

传统 Google 词汇 c10k 有很多缺少的单词，比如：

```
shout
critic
sixty
emerge
appoint
marry
troop
pupil
troop
...
```

这些都是基础的不能再基础的单词，c10k 都缺乏，因为他们并没有根据语料库进行过校对。

所以我对比了 COCA/BNC 语料库，增补了前一万的基础词，并且根据构词法数据库，增补了这些单词的所有变形体
最终去掉和原来的重复，剩下 24K 单词。