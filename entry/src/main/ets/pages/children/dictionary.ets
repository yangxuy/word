import { Word, WordProps } from "../../model/word"
import { JSON } from "@kit.ArkTS";
import { ImmersiveMode, LevelMode } from "@kit.ArkUI";

@Component
export struct DictionaryPage {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  private listScroller: Scroller = new Scroller();
  @State selectedIndex: number = 0;
  @State wordKeys: Array<string> = []
  @State words: Array<Word> = []
  @State searchText: string = ''
  @Consume navStack: NavPathStack;

  aboutToAppear(): void {
    this.wordKeys = Object.keys(this.jsonWord!);
    const allWorks: Array<Array<Word>> = Object.values(this.jsonWord!);
    this.words = allWorks.flat()
  }

  @Builder
  customDialogComponent(text: Array<Word>) {
    List({ space: 16 }) {
      ForEach(text, (w: Word) => {
        ListItem() {
          Column({ space: 4 }) {
            Text(w.word)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
            Text(w.mean)
          }
          .padding({ left: 26 })
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
        }
      })
    }
    .height(300)
    .padding({ top: 30 })
    .borderRadius(0)
  }

  onSearch() {
    const result = this.words.filter((w) => w.word.includes(this.searchText) || w.mean.includes(this.searchText))
    const node: FrameNode | null = this.getUIContext().getFrameNodeById("test_text") || null;
    this.getUIContext().getPromptAction().openCustomDialog({
      builder: () => {
        this.customDialogComponent(result);
      },
      levelMode: LevelMode.EMBEDDED, // 启用页面级弹出框
      levelUniqueId: node?.getUniqueId(), // 设置页面级弹出框所在页面的任意节点ID
      immersiveMode: ImmersiveMode.EXTEND, // 设置页面级弹出框蒙层的显示模式
    })
  }

  @Builder
  BuildTitle(text: string) {
    Text(text)
      .fontSize(20)
      .backgroundColor('#fff1f3f5')
      .width('100%')
      .padding({
        left: 10,
        top: 5,
        bottom: 4
      })
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      Column() {
        Row({ space: 12 }) {
          TextInput({ placeholder: "请输入单词", text: this.searchText })
            .layoutWeight(1)
            .onChange((text) => {
              this.searchText = text
            })
            .backgroundColor('transparent')

          Button('搜索')
            .height(30)
            .width(70)
            .onClick(() => {
              this.onSearch()
            })
        }
        .width('95%')
        .margin(16)
        .padding({
          top: 4,
          bottom: 4,
          left: 8,
          right: 8
        })
        .borderRadius(8)
        .backgroundColor('#fff')

        List({ scroller: this.listScroller }) {
          ForEach(this.wordKeys, (key: string) => {
            ListItemGroup({ header: this.BuildTitle(key) }) {
              // 循环渲染ListItem
              if (this.jsonWord![key]) {
                ForEach(this.jsonWord![key], (item: Word) => {
                  ListItem() {
                    Row() {
                      Text(item.word)
                    }
                    .padding(16)
                    .onClick(() => {
                      this.navStack.pushPathByName('learn', item)
                    })
                  }
                }, (item: Word) => JSON.stringify(item))
              }
            }
          })
        }
        .scrollBar(BarState.Off)
        .sticky(StickyStyle.Header)
        .onScrollIndex((firstIndex: number) => {
          this.selectedIndex = firstIndex
        })
        .layoutWeight(1)
      }

      // 字母表索引组件
      AlphabetIndexer({ arrayValue: Object.keys(this.jsonWord!), selected: 0 })
        .selected(this.selectedIndex)
        .onSelect((index) => {
          this.listScroller.scrollToIndex(index)
        })
    }
  }
}