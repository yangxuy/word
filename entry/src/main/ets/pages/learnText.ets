import { Word } from "../model/word";

@Component
export struct LearnText {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('learnIdx') learnIdx: Array<number> = []
  @State selectedIndex: number = 0;
  @State words: Array<Word> = []

  aboutToAppear(): void {
    this.words = Object.values(this.jsonWord!).flat()
  }

  @Builder
  BuildTitle() {
    TextInput()
  }

  build() {
    NavDestination() {
      List({ space: 10 }) {
        ForEach(this.learnIdx, (idx: number, index: number) => {
          ListItem() {
            Row() {
              Column({ space: 4 }) {
                Text(this.words[idx].word)
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                Text(this.words[idx].mean)
              }
              .alignItems(HorizontalAlign.Start)

              Button("已学会")
                .onClick(() => {
                  this.learnIdx.splice(index, 1)
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }.margin({
            bottom: 16
          })
        })
      }
      .divider({
        strokeWidth: 1,
        color: '#ffe9f0f0'
      })
      .padding({ left: 16, right: 16 })
    }
    .title('已学单词')
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
  }
}