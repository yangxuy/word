import { Word, WordProps } from "../../model/word"

@Component
export struct DictionaryPage {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  private listScroller: Scroller = new Scroller();
  @State  selectedIndex: number = 0;
  @State wordKeys: Array<string> = []

  aboutToAppear(): void {
    this.wordKeys = Object.keys(this.jsonWord!);
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
                }
              }, (item: Word) => JSON.stringify(item))
            }
          }
        })
      }
      .scrollBar(BarState.Off)
      .padding({ top: 48 })
      .sticky(StickyStyle.Header)
      .onScrollIndex((firstIndex: number) => {
        this.selectedIndex=firstIndex
      })

      // 字母表索引组件
      AlphabetIndexer({ arrayValue: Object.keys(this.jsonWord!), selected: 0 })
        .selected(this.selectedIndex)
        .onSelect((index)=>{
          this.listScroller.scrollToIndex(index)
        })
    }
  }
}