import { Word } from "../model/word";

@Component
export struct ErrorText {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('unknownIdx') unknownIdx: Array<number> = []
  @State selectedIndex: number = 0;
  @State words: Array<Word> = []
  @Consume navStack: NavPathStack;

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
        ForEach(this.unknownIdx, (idx: number, index: number) => {
          ListItem() {
            Row() {
              Column({ space: 4 }) {
                Text(this.words[idx].word)
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                Text(this.words[idx].mean)
              }
              .alignItems(HorizontalAlign.Start)

              Button("去考试")
                .onClick(() => {
                  this.navStack.pushPathByName('exam', this.words[idx])
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
    .title('错题本')
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
  }
}