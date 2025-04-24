import { Word } from '../model/word';
import { getRandomInt } from '../util/util';
import { VerifyCodeComponentWithoutCursor } from './component/textinput';
import { emitter } from '@kit.BasicServicesKit';

@Component
export struct Exam {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('learnIdx') learnIdx: Array<number> = []
  @State wordList: Array<Word> = []
  @State selectedIndex: number = 0

  aboutToAppear(): void {
    Object.values(this.jsonWord!).forEach((word: Array<Word>) => {
      word.forEach(w => {
        this.wordList.push(w)
      })
    })

    this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
  }

  build() {
    NavDestination() {
      Column({ space: 16 }) {
        Text(this.wordList[this.selectedIndex].mean)
          .fontColor("#000")
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        VerifyCodeComponentWithoutCursor()

        Row().layoutWeight(1)
        Button("下一题").alignSelf(ItemAlign.End)
          .onClick(() => {
            emitter.emit({
              eventId: 6
            })
            this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
          })
        Row().height(80)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .padding({
        top: 48,
        left: 16,
        right: 16
      })
    }
    .title("背单词")
    .padding({
      top: 40,
    })
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
  }
}